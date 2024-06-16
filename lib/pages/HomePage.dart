// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memory_wall/components/drawer.dart';
import 'package:memory_wall/components/memory_card.dart';
import 'package:memory_wall/pages/CreateMemoryPage.dart';
import 'package:memory_wall/services/fireservice.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        leading: Builder(
          builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu)),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Creatememorypage(),
                    ));
              },
              icon: const Icon(Icons.post_add))
        ],
      ),
      drawer: const DrawerCpn(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: StreamBuilder(
        stream: Fireservice().getAllMemory(),
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
            return const ListTile(
              title: Text('There isn\'t any memory yet'),
            );
          }

          List<DocumentSnapshot> memoir = snapshot.data!.docs;
          return ListView.builder(
            itemCount: memoir.length,
            itemBuilder: (context, index) {
              DocumentSnapshot memory = memoir[index];
              String id = memory.id;

              Map<String, dynamic> memoirData =
                  memory.data() as Map<String, dynamic>;
              String content = memoirData["memory"];
              int likesCount = memoirData["likesCount"] ?? 0;

              return MemoryCard(
                  content: content, likesCount: likesCount, id: id);
            },
          );
        },
      ),
    );
  }
}
