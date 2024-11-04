import 'package:flutter/material.dart';

// Custom snackbar function
void showCustomSnackbar(BuildContext context, String message,Color color) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.white), 
    ),
    backgroundColor: color,
    behavior: SnackBarBehavior.floating, 
    duration:const Duration(seconds: 3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0), 
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
