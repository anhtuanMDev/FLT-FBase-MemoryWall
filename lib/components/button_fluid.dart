import 'package:flutter/material.dart';

class ButtonFluid extends StatelessWidget {
  final String hintText;
  final void Function()? onTap;

  ButtonFluid({super.key, required this.hintText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null ? () => onTap!() : null,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Center(
            child: Text(
          hintText,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        )),
      ),
    );
  }
}
