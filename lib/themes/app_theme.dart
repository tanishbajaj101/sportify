import 'package:flutter/material.dart';
import 'package:hackathon/themes/pallete.dart';

class AppTheme {
  static ThemeData theme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.backgroundColor,
      elevation: 0,
    ),
    // adding a PLAY! button here
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Pallete.green,
    ),
  );
}
