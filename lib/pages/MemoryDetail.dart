import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Memorydetail extends StatefulWidget {
  final String memoryID;
  const Memorydetail({super.key, required this.memoryID});

  @override
  State<Memorydetail> createState() => _MemorydetailState();
}

class _MemorydetailState extends State<Memorydetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Memory's Comments"),
      ),
    );
  }
}
