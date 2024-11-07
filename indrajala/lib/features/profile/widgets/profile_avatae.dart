import 'package:flutter/material.dart';
import 'package:indrajala/core/theme/app_colors.dart';
import 'package:indrajala/core/theme/app_textstyles.dart';

class ProfileAvatar extends StatelessWidget {
  final String name;

  const ProfileAvatar({required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: IAppColors.pink,
      child: Text(
        name.isNotEmpty ? name[0].toUpperCase() : 'U',
        style: IAppTextStyles.heading1.copyWith(color: IAppColors.white),
      ),
    );
  }
}

