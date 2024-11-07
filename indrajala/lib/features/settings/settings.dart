import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/core/constants/api_constants.dart';
import 'package:indrajala/core/theme/app_colors.dart';
import 'package:indrajala/core/widgets/custom_alertbox.dart';
import 'package:indrajala/features/auth/bloc/authbloc/auth_bloc.dart';
import 'package:indrajala/features/auth/bloc/authbloc/auth_event.dart';
import 'package:indrajala/features/home/domain/usecases/launchurl_usecase.dart';
import 'package:indrajala/features/settings/widgets/logout_button.dart';
import 'package:indrajala/features/settings/widgets/settings_group.dart';
import 'package:indrajala/features/settings/widgets/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  final LaunchUrlUseCase _launchUrlUseCase = LaunchUrlUseCase();

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IAppColors.bgBlack,
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.w600, color: IAppColors.grey),
        ),
        backgroundColor: IAppColors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          SettingsGroup(
            title: "Legal & Privacy",
            children: [
              SettingsTile(
                icon: Icons.description_outlined,
                title: 'General Policy',
                onTap: () => _launchUrlUseCase.call(generalPolicy),
              ),
              const Divider(height: 1, color: Colors.white12),
              SettingsTile(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                onTap: () => _launchUrlUseCase.call(dataPolicy),
              ),
              const Divider(height: 1, color: Colors.white12),
              SettingsTile(
                icon: Icons.gavel_outlined,
                title: 'Terms and Conditions',
                onTap: () => _launchUrlUseCase.call(termsConditions),
              ),
            ],
          ),
          const SizedBox(height: 32),
          LogoutButton(onLogout: () => _showLogoutDialog(context)),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        title: "Logout",
        content: "Are you sure you want to logout?",
        confirmButtonText: "Yes",
        cancelButtonText: "No",
        onConfirm: () {
          context.read<AuthBloc>().add(LogoutEvent());
          Navigator.of(context).pop();
        },
        onCancel: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
