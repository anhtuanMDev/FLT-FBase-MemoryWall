import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:memory_wall/pages/MemoryDetail.dart';
import 'package:memory_wall/services/fireservice.dart';

class MemoryCard extends StatefulWidget {
  final String content;
  final String id;
  final int likesCount;
  final String userID; // Added userID to identify memory owner

  const MemoryCard({
    Key? key,
    required this.content,
    required this.likesCount,
    required this.id,
    required this.userID,
  }) : super(key: key);

  @override
  State<MemoryCard> createState() => _MemoryCardState();
}

class _MemoryCardState extends State<MemoryCard> {
  bool isLiked = false;
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    if (user != null) {
      checkIfLiked();
    }
  }

  Future<void> checkIfLiked() async {
    try {
      bool liked = await Fireservice().checkIfLike(widget.id, user!.uid);
      setState(() {
        isLiked = liked;
      });
    } catch (e) {
      print('Error checking like: $e');
    }
  }

  Future<void> toggleLike() async {
    try {
      await Fireservice().toggleLike(widget.id);
      setState(() {
        isLiked = !isLiked;
      });
    } catch (e) {
      print('Error toggling like: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isOwner = (user != null && widget.userID == user!.uid);

    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.content,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Divider(thickness: 1, color: Colors.grey),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                        color: isLiked ? Colors.blue : Colors.grey,
                      ),
                      onPressed: toggleLike,
                    ),
                    Text(
                      '${widget.likesCount} likes',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MemoryDetail(
                              memoryID: widget.id,
                              content: widget.content,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.comment),
                      label: Text(
                        'Comment',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    if (isOwner)
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () async {
                          try {
                            await Fireservice().deleteMemory(widget.id);
                          } catch (e) {
                            print('Error deleting memory: $e');
                          }
                        },
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
