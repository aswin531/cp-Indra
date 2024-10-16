import 'package:flutter/material.dart';

class ResponsiveSize {
  static double getCardWidth(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 800) {
      return 400; // Large screen width
    } else if (screenWidth > 500) {
      return screenWidth * 0.5; // Medium screen width
    } else {
      return screenWidth * 0.7; // Small screen width
    }
  }

  static double getCardHeight(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    if (screenHeight > 800) {
      return 500; // Large screen height
    } else if (screenHeight > 500) {
      return screenHeight * 0.6; // Medium screen height
    } else {
      return screenHeight * 0.4; // Small screen height
    }
  }

  static double getTextSize(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 800) {
      return 24; // Larger text size for big screens
    } else if (screenWidth > 500) {
      return 20; // Medium text size
    } else {
      return 16; // Smaller text size for small screens
    }
  }
}
