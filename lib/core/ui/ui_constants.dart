import 'package:flutter/material.dart';

class UiColors {
  static const primary = Color(0xFF7C3AED);
  static const primaryLight = Color(0xFFA78BFA);
  static const backgroundColor = Color(0xFFFAFAFA);
  static const borderColor = Color(0xFFE5E7EB);
  static const statGreen = Colors.green;
  static const statOrange = Colors.orange;
  static const statRed = Colors.red;
}

class UiConstants {
  static const double imageBorderRadius = 16;
  static const double cardBorderRadius = 12;
  static const double defaultSpacing = 24;
  static const double imageSize = 220;
  static const double maxStatValue = 160;
  static const double statGoodThreshold = 0.7;
  static const double statMediumThreshold = 0.4;
}

class UiTypography {
  static const titleLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.0,
  );
  static const titleMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: UiColors.primary,
  );
  static const labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: UiColors.primary,
  );
  static const labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
  static const labelSmall = TextStyle(
    fontSize: 12,
    color: Colors.grey,
    fontWeight: FontWeight.w500,
  );
  static const chipLabel = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 12,
  );
}
