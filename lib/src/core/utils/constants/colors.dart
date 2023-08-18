import 'package:flutter/material.dart';

class AppColors {
  //Text Color
  static Color txtPrimary = hexToColor('#484948');
  static const Color textSubtitle = Color(0xFF7E7E7E);
  static const Color textWhite = Color(0xFFFFFFFF);

  //Background Color
  static const Color scaffoldPrimary = Color(0xFFF6F8FB);
  static Color greyBg = hexToColor("#EBEDF2");
  static Color appBarIcon = hexToColor('#202A44');

  //Button Color
  static Color btnPrimary = hexToColor('#ff8b45');
  static Color btnYellow = hexToColor('#FFBA4D');

  //Icon Color
  static Color primaryIcon = hexToColor("#EBEDF2");
  static Color greenLacost = hexToColor("#004526");

  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
