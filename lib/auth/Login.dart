import 'package:flutter/material.dart';
import 'package:memory_wall/pages/RegisterPage.dart';
import 'package:memory_wall/pages/SigninPage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool showLoginPage = true;
  void showPage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLoginPage
        ? Signinpage(
            onPress: showPage,
          )
        : Registerpage(
            onPress: showPage,
          );
  }
}
