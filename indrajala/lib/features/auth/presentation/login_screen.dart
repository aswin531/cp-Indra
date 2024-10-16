import 'package:flutter/material.dart';
import 'package:indrajala/features/auth/widgets/authlayout_screen.dart';
import 'package:indrajala/features/auth/widgets/loginform_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScreenLayout(
      title: 'Welcome to Indrajala',
      child:  LoginForm(),
    );
  }
}
