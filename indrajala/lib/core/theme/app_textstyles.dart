import 'package:flutter/material.dart';
import 'package:indrajala/core/theme/app_colors.dart';

class IAppTextStyles {
  static TextStyle heading1 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 46, // For Roboto Bold 46 pt
    fontWeight: FontWeight.bold,
    color: IAppColors.white,
  );

  static TextStyle subtitle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 20, // For Roboto Medium 18 pt
    fontWeight: FontWeight.w500,
    color: IAppColors.grey,
  );

  static TextStyle bodyText = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 24, // For Roboto Bold 24 pt
    fontWeight: FontWeight.bold,
    color: IAppColors.white,
  );

  static TextStyle bodyTextBlack = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 22, // For Roboto Bold 24 pt
    fontWeight: FontWeight.bold,
    color: IAppColors.bgBlack,
  );

  static TextStyle headTextPink = const TextStyle(
    fontFamily: 'Roboto',
    fontSize: 35, // For Roboto Bold 24 pt
    fontWeight: FontWeight.bold,
    color: IAppColors.pink,
  );

  static TextStyle localtext = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 15, // For Roboto Medium 15 pt
    fontWeight: FontWeight.w500,
    color: IAppColors.grey,
  );

  static TextStyle descriptionText = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 20, // For Roboto Medium 15 pt
    fontWeight: FontWeight.bold,
    color: IAppColors.white,
  );

  static TextStyle detailLabel = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 18, // Smaller font size for labels
    fontWeight: FontWeight.w500,
    color: IAppColors.grey,
  );

  static TextStyle detailValue = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 18, // Consistent with label size
    fontWeight: FontWeight.w400,
    color: IAppColors.white,
  );

  static TextStyle appBarTitle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 22, // For AppBar title
    fontWeight: FontWeight.bold,
    color: IAppColors.white,
  );

  static TextStyle subheading = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 18, // For subheadings
    fontWeight: FontWeight.w600,
    color: IAppColors.white,
  );
}
