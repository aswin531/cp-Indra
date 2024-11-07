import 'package:flutter/material.dart';
import 'package:indrajala/core/theme/app_textstyles.dart';

class ErrorMessage extends StatelessWidget {
  final String message;

  const ErrorMessage({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message, style: IAppTextStyles.bodyText),
    );
  }
}
