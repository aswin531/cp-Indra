import 'package:flutter/material.dart';
import 'package:indrajala/core/theme/app_textstyles.dart';

class DetailText extends StatelessWidget {
  final String label;
  final String value;

  const DetailText({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$label: $value',
      style: IAppTextStyles.subtitle,
    );
  }
}
