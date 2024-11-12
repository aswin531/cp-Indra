import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/core/theme/app_colors.dart';
import 'package:indrajala/core/theme/app_textstyles.dart';
import 'package:indrajala/core/validators/custom_validators.dart';
import 'package:indrajala/core/widgets/custom_snackbar.dart';
import 'package:indrajala/features/auth/bloc/authbloc/auth_bloc.dart';
import 'package:indrajala/features/auth/bloc/authbloc/auth_event.dart';
import 'package:indrajala/features/auth/bloc/authbloc/auth_state.dart';
import 'package:indrajala/features/auth/bloc/visibilitybloc/visibility_bloc.dart';
import 'package:indrajala/features/auth/bloc/visibilitybloc/visibility_event.dart';
import 'package:indrajala/features/auth/bloc/visibilitybloc/visibility_state.dart';
import 'package:indrajala/core/widgets/custom_textformfields.dart';

class RegisterForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.pushReplacementNamed(context, '/bottomnavbar');
        } else if (state is AuthError) {
          showCustomSnackbar(context, state.message, IAppColors.red);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Register', style: IAppTextStyles.heading1),
              const SizedBox(height: 32),
              FormWidgets.textField(_nameController, 'Name',
                  validator: (value) =>
                      CustomValidator.validateUsername(value)),
              const SizedBox(height: 16),
              FormWidgets.textField(_emailController, 'Email',
                  validator: (value) => CustomValidator.validateEmail(value)),
              const SizedBox(height: 16),
              _buildPasswordField(context, _passwordController, 'Password'),
              // _buildPasswordField(
              //   context,_newPass,'New Pass'
              // ),
              const SizedBox(height: 32),
              FormWidgets.elevatedButton(context, 'Register', () {
                if (_formKey.currentState!.validate()) {
                  final name = _nameController.text;
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  context
                      .read<AuthBloc>()
                      .add(SignUpEvent(name, email, password));
                }
              }),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Already have an account? Login',
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
                validator: (value) => CustomValidator.validatePassword(value),
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
                  suffixIcon: IconButton(
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
                // validator: passwordController != null
                //     ? (value) => CustomValidator.validateConfirmPassword(
                //         value, passwordController.text)
                //     : (value) => CustomValidator.validatePassword(value),
              ),
            ],
          );
        },
      ),
    );
  }
}
