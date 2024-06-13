import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade100, // Light grey for background
    primary: Color(0xFF1877F2), // Facebook Blue for primary
    secondary: Colors.grey.shade600, // Darker grey for secondary elements
    inversePrimary: Colors.grey.shade800, // Very dark grey for inverse primary
  ),
  appBarTheme: const AppBarTheme(
    color: Color(0xFF1877F2), // Facebook Blue for AppBar
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
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
        bodyColor: Colors.grey[800], // Black text color
        displayColor: Colors.black, // Black text color
      ),
);
