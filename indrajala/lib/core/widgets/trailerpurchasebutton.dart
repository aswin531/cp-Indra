import 'package:flutter/material.dart';

class Trailerpurchasebutton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final TextStyle textStyle;
  final Color iconColor;
  final VoidCallback onPressed;

  const Trailerpurchasebutton({
    super.key,
    required this.color,
    required this.icon,
    required this.text,
    required this.textStyle,
    required this.iconColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: onPressed,
        icon: Icon(icon, size: 24, color: iconColor),
        label: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
