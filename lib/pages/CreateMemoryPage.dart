import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memory_wall/components/button_fluid.dart';
import 'package:memory_wall/components/drawer.dart';
import 'package:memory_wall/helper/helper_function.dart';
import 'package:memory_wall/services/fireservice.dart';

class CreateMemoryPage extends StatefulWidget {
  const CreateMemoryPage({super.key});

  @override
  State<CreateMemoryPage> createState() => _CreateMemoryPageState();
}

class _CreateMemoryPageState extends State<CreateMemoryPage> {
  final TextEditingController control = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share your new Memory"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20, right: 15, left: 15, bottom: 5),
        child: Column(
          children: [
            TextField(
              controller: control,
              maxLines: 20,
              autofocus: true,
            ),
            ButtonFluid(
              hintText: "Pin Memory on The Wall",
              onTap: () async {
                if (!control.text.isEmpty) {
                  await Fireservice().createMemory(
                      FirebaseAuth.instance.currentUser!.uid, control.text);
                  Navigator.pop(context); // Navigate back to previous page
                } else {
                  displayMessageToUser(
                      "Please insert your memory first", context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
