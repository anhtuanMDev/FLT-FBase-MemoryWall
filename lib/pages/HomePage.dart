// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memory_wall/components/drawer.dart';
import 'package:memory_wall/components/memory_card.dart';
import 'package:memory_wall/pages/CreateMemoryPage.dart';
import 'package:memory_wall/services/fireservice.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Stream<QuerySnapshot> _memoirsStream;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _memoirsStream = Fireservice().getAllMemory();
  }

  Future<void> _refresh() async {
    setState(() {
      _memoirsStream = Fireservice().getAllMemory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateMemoryPage(),
                ),
              );
            },
            icon: const Icon(Icons.post_add),
          ),
        ],
      ),
      drawer: const DrawerCpn(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: StreamBuilder(
          stream: _memoirsStream,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            // Show loading state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // Show error state
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            // Show message when data is empty
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('There are no memories yet.'),
              );
            }

            List<DocumentSnapshot> memoirs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: memoirs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot memory = memoirs[index];
                String id = memory.id;

                Map<String, dynamic> memoirData =
                    memory.data() as Map<String, dynamic>;
                String content = memoirData["memory"];
                String uid = memoirData["userID"];
                int likesCount = memoirData["likesCount"] ?? 0;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: MemoryCard(
                    content: content,
                    likesCount: likesCount,
                    id: id,
                    userID: uid,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
