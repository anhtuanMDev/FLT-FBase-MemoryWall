// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:memory_wall/auth/Login.dart';
import 'package:memory_wall/pages/HomePage.dart';
import 'package:memory_wall/pages/SigninPage.dart';
import 'package:memory_wall/pages/RegisterPage.dart';
import 'package:memory_wall/theme/dark_mode.dart';
import 'package:memory_wall/theme/light_mode.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Login(),
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
