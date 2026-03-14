import 'package:flutter/material.dart';

class MyColors {
  // Primary accent (active elements, links, filled state) – reference blue
  static const Color primary = Color(0xFF369EFF);
  static const Color primaryLight = Color(0xFF5BB0FF);
  static const Color primaryDark = Color(0xFF2680E0);
  static const Color secondary = Color(0xFF272727);
  static const Color secondaryLight = Color(0xFF4B5363);
  static const Color accent = Color(0xFF369EFF);
  static const Color accentLight = Color(0xFF5BB0FF);
  static const Color primaryBackground = Color(0xFFFFFFFF);
  static const Color secondaryBackground = Color(0xFFF5F5F5);

  // Dashboard Specific Colors
  static const Color dashboardAppbarBackground = Color(0xFF369EFF);

  // Text colors (reference: dark grey for headings/input, light grey for placeholders/inactive)
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF4B5363);
  static const Color textDarkPrimary = Color(0xFFFFFFFF);
  static const Color textDarkSecondary = Color(0xFFD1D5DB);
  static const Color textWhite = Colors.white;
  static const Color placeholderInactive = Color(0xFFAAAAAA);

  static const Color disabledTextLight = Color(0xFF333333);
  static const Color disabledBackgroundLight = Color(0xFFEEEEEE);

  static const Color disabledTextDark = textSecondary;
  static const Color disabledBackgroundDark = Color(0xFF222A3D);

  // Background colors
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color darkBackground = Color(0xFF02040A);

  // Input field / inactive (light grey border and bg)
  static const Color lightContainer = Color(0xFFF5F5F5);
  static const Color darkContainer = Color(0xFF13192B);
  static const Color cardBackgroundColor = Color(0xFFF7F5F1);

  // Button colors
  static const Color buttonPrimary = primary;
  static const Color buttonSecondary = secondary;
  static const Color buttonDisabled = Color(0xFFEEEEEE);
  static const Color buttonDisabledText = Color(0xFF333333);

  // -- Social Button Colors
  static const Color googleBackgroundColor = Color(0xFFDFEFFF);
  static const Color googleForegroundColor = Color(0xFF167EE6);
  static const Color facebookBackgroundColor = Color(0xFF1877F2);

  // -- ON-BOARDING COLORS
  static const Color onBoardingPage1Color = Colors.white;
  static const Color onBoardingPage2Color = Color(0xfffddcdf);
  static const Color onBoardingPage3Color = Color(0xffffdcbd);

  // Icon colors (inactive = grey; active/filled = primary blue)
  static const Color iconPrimaryLight = Color(0xFF369EFF);
  static const Color iconSecondaryLight = Color(0xFFAAAAAA);
  static const Color iconPrimaryDark = Color(0xFFFFFFFF);
  static const Color iconSecondaryDark = Color(0xFF9CA3AF);

  // Border colors
  static const Color borderPrimary = primary;
  static const Color borderSecondary = secondary;
  static const Color borderLight = Color(0xFFD1D5DB); // Gray 30
  static const Color borderDark = Color(0xFF9CA3AF); // Gray 40

  // Error and validation colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);

  // Neutral Shades
  static const Color black = Color(0xFF232323);
  static const Color teal90 = Color(0xFF004D40);
  static const Color teal80 = Color(0xFF00695C);
  static const Color teal20 = Color(0xFF99F6E4);
  static const Color dark = Color(0xff272727);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color grey10 = Color(0xFFF3F4F6);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);
  static const Color red = Color(0xfff43F5E);
}
