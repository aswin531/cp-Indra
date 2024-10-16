import 'package:flutter/material.dart';
import 'package:indrajala/core/validators/custom_validators.dart';
import 'package:indrajala/features/auth/widgets/authlayout_screen.dart';
import 'package:indrajala/core/widgets/custom_textformfields.dart';

class PasswordResetScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();

  PasswordResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScreenLayout(
      title: 'Indrajala Entertainment',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Password Reset',
            style: TextStyle(
              color: Color(0xFFFF4D67),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Enter your email to reset your password and continue your entertainment journey.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 20),
          FormWidgets.textField(
            emailController,
            'Email',
            validator: (value) => CustomValidator.validateEmail(value),
          ),
          const SizedBox(height: 10),
          FormWidgets.elevatedButton(context, 'Reset Password', () {}),
        ],
      ),
    );
  }
}
