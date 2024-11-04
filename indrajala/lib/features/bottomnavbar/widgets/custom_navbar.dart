import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/core/theme/app_colors.dart';
import 'package:indrajala/features/bottomnavbar/bloc/bloc.dart';
import 'package:indrajala/features/bottomnavbar/bloc/event.dart';
import 'package:indrajala/features/bottomnavbar/bloc/state.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarBloc, BottomNavState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: IAppColors.black,
            boxShadow: [
              BoxShadow(
                color: IAppColors.pink.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: BottomNavigationBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                currentIndex: state.selectedIndex,
                onTap: (index) =>
                    context.read<BottomNavBarBloc>().add(SelectedTabEvent(index)),
                selectedItemColor: IAppColors.pink,
                unselectedItemColor: IAppColors.grey.withOpacity(0.5),
                showSelectedLabels: true,
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                items: [
                  _buildNavItem(Icons.home_rounded, 'Home', state.selectedIndex == 0),
                  _buildNavItem(Icons.subscriptions_rounded, 'Subscribe', state.selectedIndex == 1),
                  _buildNavItem(Icons.person_rounded, 'Profile', state.selectedIndex == 2),
                  _buildNavItem(Icons.settings_rounded, 'Settings', state.selectedIndex == 3),
                ],
                selectedLabelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, bool isSelected) {
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(isSelected ? 12 : 8),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    IAppColors.pink.withOpacity(0.2),
                    IAppColors.pink.withOpacity(0.1),
                  ],
                )
              : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: isSelected ? 1 : 0),
          duration: const Duration(milliseconds: 200),
          builder: (context, value, child) {
            return Transform.scale(
              scale: 1 + (value * 0.2),
              child: Icon(
                icon,
                size: 24,
              ),
            );
          },
        ),
      ),
      label: label,
    );
  }
}

// // Add this extension for a smoother ripple effect
// extension CustomNavBarTheme on ThemeData {
//   ThemeData get withCustomNavBar {
//     return copyWith(
//       splashColor: Colors.transparent,
//       highlightColor: Colors.transparent,
//     );
//   }
// }