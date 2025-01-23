import 'package:flutter/material.dart';

class GameTheme {
  // Cell colors
  static const Color deckColor = Colors.grey;
  static const Color validColor = Color(0xFF4CAF50);  // Material Green
  static const Color invalidColor = Color(0xFFF44336);  // Material Red
  static const Color emptyColor = Color(0xFF2196F3);  // Material Blue
  static const Color outerColor = Color(0xFF9E9E9E);  // Material Grey
  static const Color highlightColor = Color(0xFF81C784);  // Light Green
  static const Color handBackgroundColor = Color(0x1F000000);  // 12% black

  // Text styles
  static const TextStyle cellText = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle handText = TextStyle(
    color: Colors.black87,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  // Decorations
  static BoxDecoration cardBorder(bool isValid) => BoxDecoration(
    border: Border.all(
      color: isValid ? validColor : invalidColor,
      width: 2,
    ),
    borderRadius: BorderRadius.circular(4),
  );

  static BoxDecoration cellDecoration(Color color) => BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(4),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
  );
} 