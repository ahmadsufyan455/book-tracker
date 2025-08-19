import 'package:flutter/material.dart';

import 'app_colors.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.librioLightBackground,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.librioBlue,
    foregroundColor: Colors.white,
  ),
  colorScheme: const ColorScheme.light(
    primary: AppColors.librioBlue,
    onPrimary: Colors.white,
    secondary: AppColors.librioBlue,
    onSecondary: Colors.white,
    surface: AppColors.librioLightSurface,
    onSurface: AppColors.librioLightText,
    error: Colors.red,
    onError: Colors.white,
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.librioDarkBackground,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.librioDarkSurface,
    foregroundColor: AppColors.librioDarkText,
  ),
  colorScheme: const ColorScheme.dark(
    primary: AppColors.librioBlue,
    onPrimary: Colors.black,
    secondary: AppColors.librioBlue,
    onSecondary: Colors.black,
    surface: AppColors.librioDarkSurface,
    onSurface: AppColors.librioDarkText,
    error: Colors.red,
    onError: Colors.black,
  ),
);
