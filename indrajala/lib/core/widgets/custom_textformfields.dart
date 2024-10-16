import 'package:flutter/material.dart';
import 'package:indrajala/core/theme/app_colors.dart';
import 'package:indrajala/core/theme/app_textstyles.dart';

class FormWidgets {
  static Widget textField(
    TextEditingController controller,
    String label, {
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: IAppTextStyles.subtitle),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          style: IAppTextStyles.bodyText.copyWith(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[800],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          ),
          validator: validator,
        ),
      ],
    );
  }

  static Widget elevatedButton(
    BuildContext context,
    String label,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: IAppColors.pink,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(label, style: TextStyle(color: IAppColors.white)),
    );
  }
}
