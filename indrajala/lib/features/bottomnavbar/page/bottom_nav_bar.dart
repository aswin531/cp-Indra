import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/features/bottomnavbar/bloc/bloc.dart';
import 'package:indrajala/features/bottomnavbar/bloc/state.dart';
import 'package:indrajala/features/bottomnavbar/widgets/custom_navbar.dart';
import 'package:indrajala/features/home/presentation/homescreen.dart';
import 'package:indrajala/features/profile/presentation/presentation/profile.dart';
import 'package:indrajala/features/settings/settings.dart';
import 'package:indrajala/features/subscription/presentation/subscription_screen.dart';

class MainScreen extends StatelessWidget {
  final List<Widget> screens = [
    HomeScreenTest(),
    const SubscriptionPage(),
    const ProfilePage(),
    const SettingsScreen()
  ];

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomNavBarBloc, BottomNavState>(
        builder: (context, state) {
          return IndexedStack(
            index: state.selectedIndex,
            children: screens,
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}
