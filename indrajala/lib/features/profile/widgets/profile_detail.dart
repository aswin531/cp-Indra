
import 'package:flutter/material.dart';
import 'package:indrajala/core/theme/app_textstyles.dart';
import 'package:indrajala/features/profile/data/model/userprofile_model.dart';
import 'package:indrajala/features/profile/widgets/action_buttons.dart';
import 'package:indrajala/features/profile/widgets/info_tile.dart';
import 'package:indrajala/features/profile/widgets/profile_avatae.dart';

class ProfileDetails extends StatelessWidget {
  final ProfileModel profile;

  const ProfileDetails({required this.profile, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          ProfileAvatar(name: profile.name),
          const SizedBox(height: 16),
          Text(profile.name, style: IAppTextStyles.heading1),
          const SizedBox(height: 32),
          InfoTile(label: 'Email', value: profile.email),
          const SizedBox(height: 16),
          InfoTile(label: 'Subscription', value: profile.subscriptionType),
          const SizedBox(height: 16),
          InfoTile(label: 'Expiry Date', value: _formatExpiryDate(profile.expiryDate)),
          const Spacer(),
          const ActionButtons(),
        ],
      ),
    );
  }

  String _formatExpiryDate(DateTime expiryDate) {
    String year = expiryDate.year.toString();
    String month = expiryDate.month.toString().padLeft(2, '0');
    String day = expiryDate.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}
