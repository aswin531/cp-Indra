import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/core/theme/app_textstyles.dart';
import 'package:indrajala/features/auth/bloc/authbloc/auth_bloc.dart';
import 'package:indrajala/features/auth/bloc/authbloc/auth_event.dart';
import 'package:indrajala/features/auth/bloc/authbloc/auth_state.dart';
import 'package:indrajala/features/auth/bloc/visibilitybloc/visibility_bloc.dart';
import 'package:indrajala/features/auth/bloc/visibilitybloc/visibility_event.dart';
import 'package:indrajala/features/auth/bloc/visibilitybloc/visibility_state.dart';
import 'package:indrajala/features/auth/presentation/passwordreset_screen.dart';
import 'package:indrajala/features/auth/presentation/signup_screen.dart';
import 'package:indrajala/core/widgets/custom_textformfields.dart';

class LoginForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              FormWidgets.textField(
                _emailController,
                'Email',
                // validator: (value) => CustomValidator.validateEmail(value),
              ),
              const SizedBox(height: 16),
              _buildPasswordField(context, _passwordController, 'Password'),
              const SizedBox(height: 32),
              FormWidgets.elevatedButton(context, 'Login', () {
                if (_formKey.currentState!.validate()) {
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  context.read<AuthBloc>().add(LoginEvent(email, password));
                }
              }),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen()),
                  );
                },
                child:
                     Text('Register Now', style: IAppTextStyles.subtitle),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PasswordResetScreen()),
                  );
                },
                child:  Text('Forget Password ?',
                    style: IAppTextStyles.subtitle),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(
      BuildContext context, TextEditingController controller, String label) {
    return BlocProvider(
      create: (_) => PasswordVisibilityBloc(),
      child: BlocBuilder<PasswordVisibilityBloc, PasswordVisibilityState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: IAppTextStyles.subtitle),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller,
                obscureText: !state.isVisible,
                style: IAppTextStyles.bodyText.copyWith(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: IconButton(
                      icon: Icon(
                        state.isVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        context
                            .read<PasswordVisibilityBloc>()
                            .add(TogglePasswordVisibilityEvent());
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
