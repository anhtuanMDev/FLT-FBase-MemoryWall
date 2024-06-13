import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obsecure;

  const TextInput(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.obsecure});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          hintText: hintText),
      obscureText: obsecure,
    );
  }
}
