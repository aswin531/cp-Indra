import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/core/theme/app_colors.dart';
import 'package:indrajala/core/widgets/loading_indicator.dart';
import 'package:indrajala/features/auth/bloc/authbloc/auth_bloc.dart';
import 'package:indrajala/features/auth/bloc/authbloc/auth_event.dart';
import 'package:indrajala/features/auth/bloc/authbloc/auth_state.dart';
import 'package:indrajala/features/profile/widgets/error_message.dart';
import 'package:indrajala/features/profile/widgets/profile_content.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IAppColors.black,
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            if (authState is Authenticated) {
              context.read<AuthBloc>().add(GetTokenEvent());
              return const LoadingIndicator();
            } else if (authState is TokenRetrieved) {
              return ProfileContent(token: authState.token);
            } else if (authState is AuthError) {
              return ErrorMessage(message: 'Auth Error: ${authState.message}');
            } else {
              return const ErrorMessage(message: 'Please log in to view your profile.');
            }
          },
        ),
      ),
    );
  }
}
