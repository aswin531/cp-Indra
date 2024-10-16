import 'package:flutter/material.dart';
import 'package:indrajala/features/auth/widgets/authlayout_screen.dart';
import 'package:indrajala/features/auth/widgets/signup_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScreenLayout(
      title: 'Indrajala Entertainment',
      child:  RegisterForm(),
    );
  }
}
