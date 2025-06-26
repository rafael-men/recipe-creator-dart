import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: const Color(0xFF8B0000),
  scaffoldBackgroundColor: const Color(0xFFFFF8F8),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: const Color(0xFFB22222),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF8B0000),
    foregroundColor: Colors.white,
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      fontSize: 16,
      color: Color(0xFF1A1A1A),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF8B0000),
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
);
