import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.black,
    primary: Color(0xFF1877F2),
    secondary: Colors.grey.shade300,
    inversePrimary: Colors.grey.shade100,
  ),
  appBarTheme: const AppBarTheme(
    color: Color(0xFF1877F2), // Facebook Blue for AppBar
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFF1877F2), // Facebook Blue for buttons
    textTheme: ButtonTextTheme.primary,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF1877F2), // Facebook Blue for FAB
  ),
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.grey[400], // Black text color
        displayColor: Colors.white, // Black text color
      ),
);
