import 'package:flutter/material.dart';
import 'package:indrajala/core/theme/app_textstyles.dart';

class SubscriptionFeature extends StatelessWidget {
  final String text;

  const SubscriptionFeature({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.check, color: Colors.pink),
          const SizedBox(width: 8),
          Text(
            text,
            style: IAppTextStyles.localtext,
          ),
        ],
      ),
    );
  }
}
