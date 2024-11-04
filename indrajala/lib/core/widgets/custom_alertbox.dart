import 'package:flutter/material.dart';
import 'package:indrajala/core/theme/app_colors.dart';
import 'package:indrajala/core/theme/app_textstyles.dart'; // Import the text styles

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmButtonText;
  final String cancelButtonText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.confirmButtonText,
    required this.cancelButtonText,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: IAppColors.black,
      title: Text(
        title,
        style: IAppTextStyles.heading1, // Use heading1 style for the title
      ),
      content: Text(
        content,
        style: IAppTextStyles.descriptionText, // Use descriptionText style for the content
      ),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: Text(
            cancelButtonText,
            style: IAppTextStyles.localtext.copyWith(color: IAppColors.grey), // Use localtext style for the cancel button
          ),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(
            confirmButtonText,
            style: IAppTextStyles.headTextPink, // Use headTextPink style for the confirm button
          ),
        ),
      ],
    );
  }
}
