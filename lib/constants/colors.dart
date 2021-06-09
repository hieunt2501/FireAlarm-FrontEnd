import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // this basically makes it so you can't instantiate this class

  static List<Color> normalBackground = [
    Colors.lightGreen[400],
    Colors.lightGreen[100],
    Colors.lightGreen[400],
  ];

  static List<Color> statBar = [
    Colors.blueGrey[900],
    Colors.blueGrey[800],
  ];
  static Color kPrimaryColor = Color(0x66CA8383);
  static Color kSecondaryColor = Color(0xFF6B0000);
  static Color kText = Color(0xFFA60000);
}
