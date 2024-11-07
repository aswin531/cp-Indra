import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/core/widgets/loading_indicator.dart';
import 'package:indrajala/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:indrajala/features/profile/presentation/bloc/profile_event.dart';
import 'package:indrajala/features/profile/presentation/bloc/profile_state.dart';
import 'package:indrajala/features/profile/widgets/error_message.dart';
import 'package:indrajala/features/profile/widgets/profile_detail.dart';

class ProfileContent extends StatelessWidget {
  final String token;

  const ProfileContent({required this.token, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profileState) {
        if (profileState is ProfileInitial) {
          context.read<ProfileBloc>().add(FetchProfileInfo(token));
          return const LoadingIndicator();
        } else if (profileState is ProfileLoading) {
          return const LoadingIndicator();
        } else if (profileState is ProfileLoaded) {
          return ProfileDetails(profile: profileState.profile);
        } else if (profileState is ProfileError) {
          return const ErrorMessage(message: 'Something went wrong');
        }
        return const ErrorMessage(message: 'Unexpected state');
      },
    );
  }
}
