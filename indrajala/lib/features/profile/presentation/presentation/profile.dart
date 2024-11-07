import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/core/theme/app_colors.dart';
import 'package:indrajala/core/widgets/loading_indicator.dart';
import 'package:indrajala/features/auth/bloc/authbloc/auth_bloc.dart';
import 'package:indrajala/features/auth/bloc/authbloc/auth_event.dart';
import 'package:indrajala/features/auth/bloc/authbloc/auth_state.dart';
import 'package:indrajala/features/profile/widgets/error_message.dart';
import 'package:indrajala/features/profile/widgets/profile_content.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: IAppColors.black,
//       body: SafeArea(
//         child: BlocBuilder<AuthBloc, AuthState>(
//           builder: (context, authState) {
//             if (authState is Authenticated) {
//               // User is authenticated, get the token
//               context.read<AuthBloc>().add(GetTokenEvent());
//               return const Center(
//                   child: CircularProgressIndicator(color: IAppColors.pink));
//             } else if (authState is TokenRetrieved) {
//               return BlocBuilder<ProfileBloc, ProfileState>(
//                 builder: (context, profileState) {
//                   if (profileState is ProfileInitial) {
//                     // Trigger profile fetch with the token
//                     context
//                         .read<ProfileBloc>()
//                         .add(FetchProfileInfo(authState.token));
//                     return const Center(
//                         child:
//                             CircularProgressIndicator(color: IAppColors.pink));
//                   } else if (profileState is ProfileLoading) {
//                     return const Center(
//                         child:
//                             CircularProgressIndicator(color: IAppColors.pink));
//                   } else if (profileState is ProfileLoaded) {
//                     return _buildProfileContent(context, profileState.profile);
//                   } else if (profileState is ProfileError) {
//                     return Center(
//                         child: Text('Error: ${profileState.message}',
//                             style: IAppTextStyles.bodyText));
//                   }
//                   return Center(
//                       child: Text('Unexpected state',
//                           style: IAppTextStyles.bodyText));
//                 },
//               );
//             } else if (authState is AuthError) {
//               return Center(
//                   child: Text('Auth Error: ${authState.message}',
//                       style: IAppTextStyles.bodyText));
//             } else {
//               return Center(
//                   child: Text('Please log in to view your profile.',
//                       style: IAppTextStyles.bodyText));
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildProfileContent(BuildContext context, ProfileModel profile) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const SizedBox(height: 20),
//           _buildProfileAvatar(profile.name),
//           const SizedBox(height: 16),
//           Text(profile.name, style: IAppTextStyles.heading1),
//           const SizedBox(height: 32),
//           _buildInfoTile('Email', profile.email),
//           const SizedBox(height: 16),
//           _buildInfoTile('Subscription', profile.subscriptionType),
//           const SizedBox(height: 16),
//           _buildInfoTile(
//               'Expiry Date', getFormattedExpiryDate(profile.expiryDate)),
//           const Spacer(),
//           _buildButtons(context),
//         ],
//       ),
//     );
//   }

//   Widget _buildProfileAvatar(String name) {
//     return CircleAvatar(
//       radius: 50,
//       backgroundColor: IAppColors.pink,
//       child: Text(
//         name.isNotEmpty ? name[0].toUpperCase() : 'U',
//         style: IAppTextStyles.heading1.copyWith(color: IAppColors.white),
//       ),
//     );
//   }

//   Widget _buildInfoTile(String label, String value) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: IAppColors.bgBlack,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label, style: IAppTextStyles.subtitle),
//           const SizedBox(height: 4),
//           Text(value, style: IAppTextStyles.bodyText),
//         ],
//       ),
//     );                                          
//   }

//   Widget _buildButtons(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue,
//               padding: const EdgeInsets.symmetric(vertical: 16),
//             ),
//             onPressed: () => {
//               //Navigator.of(context).pushNamed('/bottomnavbar'),
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(4.0),
//               child: Text('GO BACK HOME', style: IAppTextStyles.subtitle),
//             ),
//           ),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: IAppColors.pink,
//               padding: const EdgeInsets.symmetric(vertical: 16),
//             ),
//             onPressed: () {
//               Navigator.pushNamed(context, IAppRoutes.subScription);
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(4.0),
//               child: Text('SUBSCRIBE NOW', style: IAppTextStyles.subtitle),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   String getFormattedExpiryDate(expiryDate) {
//     String year = expiryDate.year.toString();
//     String month = expiryDate.month.toString().padLeft(2, '0');
//     String day = expiryDate.day.toString().padLeft(2, '0');
//     return '$year-$month-$day';
//   }
// }



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
