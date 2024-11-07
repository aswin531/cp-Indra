import 'package:flutter/material.dart';
import 'package:indrajala/core/router/approutes.dart';
import 'package:indrajala/core/theme/app_colors.dart';
import 'package:indrajala/core/theme/app_textstyles.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.8),
                    Colors.blue.withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shadowColor: Colors.transparent,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    IAppRoutes.bottomnavbar,
                    (route) => false,
                  );
                },
                child: Text('GO BACK HOME', style: IAppTextStyles.subtitle),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    IAppColors.pink.withOpacity(0.8),
                    IAppColors.pink.withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shadowColor: Colors.transparent,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, IAppRoutes.subScription);
                },
                child: Text('SUBSCRIBE NOW', style: IAppTextStyles.subtitle),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
