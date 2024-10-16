import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/core/constants/api_constants.dart';
import 'package:indrajala/core/dependency_injection/service_locator.dart';
import 'package:indrajala/core/router/approutes.dart';
import 'package:indrajala/core/theme/app_colors.dart';
import 'package:indrajala/features/auth/bloc/authbloc/auth_bloc.dart';
import 'package:indrajala/features/auth/bloc/authbloc/auth_event.dart';
import 'package:indrajala/features/home/domain/usecases/launchurl_usecase.dart';

class HomeDrawer extends StatelessWidget {
  final LaunchUrlUseCase _launchUrlUseCase = sl<LaunchUrlUseCase>();

  HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: IAppColors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 100,
          ),
          ListTile(
            leading: const Icon(
              Icons.subscriptions,
              color: IAppColors.pink,
            ),
            title: Text(
              'Subscribe',
              style: TextStyle(color: IAppColors.white),
            ),
            onTap: () {
              Navigator.pushNamed(context, IAppRoutes.subScription);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text('Profile', style: TextStyle(color: IAppColors.white)),
            onTap: () {
              Navigator.pushNamed(context, IAppRoutes.profile);
            },
          ),
          ListTile(
            leading: const Icon(Icons.list_alt),
            title: Text('Plans', style: TextStyle(color: IAppColors.white)),
            onTap: () {
              Navigator.pushNamed(context, IAppRoutes.subScription);
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: Text('General Policy',
                style: TextStyle(color: IAppColors.white)),
            onTap: () {
              _launchUrlUseCase.call(generalPolicy);
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: Text('Privacy Policy',
                style: TextStyle(color: IAppColors.white)),
            onTap: () {
              _launchUrlUseCase.call(dataPolicy);
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: Text('Terms and Conditions',
                style: TextStyle(color: IAppColors.white)),
            onTap: () {
              _launchUrlUseCase.call(termsConditions);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: IAppColors.red,
            ),
            title: Text(
              'LogOut',
              style: TextStyle(color: IAppColors.red),
            ),
            onTap: () {
              context.read<AuthBloc>().add(LogoutEvent());
            },
          ),
        ],
      ),
    );
  }
}
