import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:memory_wall/pages/MemoryDetail.dart';
import 'package:memory_wall/services/fireservice.dart';

class MemoryCard extends StatefulWidget {
  final String content;
  final String id;
  final int likesCount;

  const MemoryCard({
    Key? key,
    required this.content,
    required this.likesCount,
    required this.id,
  }) : super(key: key);

  @override
  State<MemoryCard> createState() => _MemoryCardState();
}

class _MemoryCardState extends State<MemoryCard> {
  bool isLiked = false;
  final user = FirebaseAuth.instance.currentUser;

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
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
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
                Expanded(
                  child: Container(),
                ),
                IconButton(
                  icon: Icon(Icons.comment),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Memorydetail(
                          memoryID: widget.id,
                        );
                      },
                    ));
                  },
                ),
                Text(
                  'Comment',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
