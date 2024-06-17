import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Fireservice {
  // Get collection of memory, users, comments
  final CollectionReference memories =
      FirebaseFirestore.instance.collection("memory");
  final CollectionReference comments =
      FirebaseFirestore.instance.collection("comments");

  // Get all memory
  Stream<QuerySnapshot> getAllMemory() {
    return memories.orderBy('timeStamp', descending: true).snapshots();
  }

  // Get all comments
  // Get all comments without filtering
  Stream<QuerySnapshot> getAllComments() {
    return comments.snapshots();
  }

  // Create user memory
  Future<void>? createMemory(String userID, String memory) async {
    try {
      memories.add({
        'userID': userID,
        'memory': memory,
        'timeStamp': Timestamp.now(),
        "likesCount": 0
      });
    } catch (e) {
      log('Create memory error: ' + e.toString());
    }
  }

  // Create user comment
  Future<void> createComment(
      String userID, String memoryID, String content) async {
    try {
      await comments.add({
        'userID': userID,
        'memoryID': memoryID,
        'content': content,
        'timeStamp': Timestamp.now()
      });
    } catch (e) {
      log('Create comment error: ' + e.toString());
    }
  }

  //Update user memroy
  Future<void>? updateMemory(String id, String memory) async {
    try {
      memories.doc(id).update({'memory': memory});
    } catch (e) {
      log('Update memroy error: ' + e.toString());
    }
  }

  //Update user comment
  Future<void>? updateComment(String id, String content) async {
    try {
      memories.doc(id).update({'content': content});
    } catch (e) {
      log('Update comment error: ' + e.toString());
    }
  }

  //Delete user memory
  Future<void>? deleteMemory(String id) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("User not authenticated");
      }

      final DocumentSnapshot memorySnapshot = await memories.doc(id).get();
      if (!memorySnapshot.exists) {
        throw Exception("Memory does not exist");
      }

      final Map<String, dynamic>? memoryData =
          memorySnapshot.data() as Map<String, dynamic>?;

      if (memoryData == null) {
        throw Exception("Memory data is null");
      }

      final String ownerId = memoryData['userID'];
      if (user.uid != ownerId) {
        throw Exception("User is not authorized to delete this memory");
      }

      await memories.doc(id).delete();
    } catch (e) {
      log('Delete memory error: ' + e.toString());
    }
  }

  //Delete user comment
  Future<void>? deleteComment(String id) async {
    try {
      comments.doc(id).delete();
    } catch (e) {
      log('Delete comment error: ' + e.toString());
    }
  }

  Future<bool> checkIfLike(String memoryID, String userID) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final likeDoc =
          await memories.doc(memoryID).collection('likes').doc(userID).get();
      return likeDoc.exists;
    }
    return false;
  }

  Future<void> toggleLike(String memoryId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User not logged in");
    }
    final memoryRef = memories.doc(memoryId);
    // Creating or Getting Document Reference with User ID
    final likeRef = memoryRef.collection('likes').doc(user.uid);

    final likeSnapshot = await likeRef.get();

    if (likeSnapshot.exists) {
      // Unlike the memory
      await likeRef.delete();
      await memoryRef.update({'likesCount': FieldValue.increment(-1)});
    } else {
      // Like the memory
      await likeRef.set({'liked': true});
      await memoryRef.update({'likesCount': FieldValue.increment(1)});
    }
  }
}
