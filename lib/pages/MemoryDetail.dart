import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:memory_wall/services/fireservice.dart';

class MemoryDetail extends StatefulWidget {
  final String memoryID;
  final String content;

  const MemoryDetail({Key? key, required this.memoryID, required this.content})
      : super(key: key);

  @override
  State<MemoryDetail> createState() => _MemoryDetailState();
}

class _MemoryDetailState extends State<MemoryDetail> {
  final TextEditingController _commentController = TextEditingController();

  Future<void> _createComment() async {
    if (_commentController.text.isEmpty) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await Fireservice().createComment(
        user.uid,
        widget.memoryID,
        _commentController.text,
      );
      _commentController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please log in to comment.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Memory Comments"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      widget.content,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  StreamBuilder(
                    stream: Fireservice().getAllComments(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text('No comments yet.'));
                      }
                      List<DocumentSnapshot> allComments = snapshot.data!.docs;

                      // Filter comments for the specific memoryID
                      List<DocumentSnapshot> filteredComments = allComments
                          .where((comment) =>
                              comment['memoryID'] == widget.memoryID)
                          .toList();

                      // Sort comments by timeStamp in descending order
                      filteredComments.sort((a, b) {
                        Timestamp tsA = a['timeStamp'];
                        Timestamp tsB = b['timeStamp'];
                        return tsB.compareTo(tsA);
                      });

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: filteredComments.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot comment = filteredComments[index];
                          Map<String, dynamic> commentData =
                              comment.data() as Map<String, dynamic>;
                          String content = commentData["content"];
                          String commentId = comment.id;
                          bool canDelete = commentData["userID"] ==
                              FirebaseAuth.instance.currentUser?.uid;

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    content,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                if (canDelete)
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () =>
                                        Fireservice().deleteComment(commentId),
                                  ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      labelText: 'Write a comment...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _createComment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
