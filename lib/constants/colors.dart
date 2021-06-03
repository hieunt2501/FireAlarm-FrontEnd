import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // this basically makes it so you can't instantiate this class

  // static const Map<int, Color> orange = const <int, Color>{
  //   50: const Color(0xFFFCF2E7),
  //   100: const Color(0xFFF8DEC3),
  //   200: const Color(0xFFF3C89C),
  //   300: const Color(0xFFEEB274),
  //   400: const Color(0xFFEAA256),
  //   500: const Color(0xFFE69138),
  //   600: const Color(0xFFE38932),
  //   700: const Color(0xFFDF7E2B),
  //   800: const Color(0xFFDB7424),
  //   900: const Color(0xFFD56217)
  // };
  static List<Color> normalBackground = [
    Colors.lightGreen[400],
    Colors.lightGreen[100],
    Colors.lightGreen[400],
  ];

  static List<Color> avgBar = [
    Colors.blueGrey[900],
    Colors.blueGrey[800],
  ];
  static Color kPrimaryColor = Color(0x66CA8383);
  static Color kSecondaryColor = Color(0xFF6B0000);
  static Color kText = Color(0xFFA60000);
}
