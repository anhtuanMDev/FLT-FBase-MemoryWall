// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:memory_wall/components/button_fluid.dart';
import 'package:memory_wall/components/text_field.dart';
import 'package:memory_wall/helper/helper_function.dart';

class Signinpage extends StatefulWidget {
  final void Function()? onPress;
  Signinpage({super.key, required this.onPress});

  @override
  State<Signinpage> createState() => _SigninpageState();
}

class _SigninpageState extends State<Signinpage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  void login() async {
    showProgress(context);
    try {
      FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (context.mounted) {
        Navigator.pop(context);
        log("Sign in");
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),

              Container(height: 5),
              const Text(
                'M E M O R Y W A L L',
                style: TextStyle(fontSize: 20),
              ),
              Container(height: 50),

              TextInput(
                  hintText: 'Email',
                  controller: emailController,
                  obsecure: false),

              Container(height: 25),

              TextInput(
                  hintText: 'Password',
                  controller: passwordController,
                  obsecure: true),
              Container(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  )
                ],
              ),

              Container(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                      child: ButtonFluid(
                    hintText: 'Log in',
                    onTap: login,
                  ))
                ],
              ),

              Container(height: 10),

              RichText(
                text: TextSpan(
                  text: 'Doesn\'t has an account ? ',
                  style: const TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Click here!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          widget.onPress?.call();
                        },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
