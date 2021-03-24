import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = Color(0xff191720);
  static MaterialColor primarySwatch = MaterialColor(
    0xff191720,
    <int, Color>{
      50: primaryColor.withOpacity(0.05),
      100: primaryColor.withOpacity(0.1),
      200: primaryColor.withOpacity(0.2),
      300: primaryColor.withOpacity(0.3),
      400: primaryColor.withOpacity(0.4),
      500: primaryColor.withOpacity(0.5),
      600: primaryColor.withOpacity(0.6),
      700: primaryColor.withOpacity(0.7),
      800: primaryColor.withOpacity(0.8),
      900: primaryColor.withOpacity(0.9),
    },
  );
}
