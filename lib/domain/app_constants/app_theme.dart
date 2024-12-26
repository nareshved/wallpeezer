import 'package:flutter/material.dart';
import 'app_colors.dart';

// app light theme

final mLightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.primaryLightColor,
    scaffoldBackgroundColor: AppColors.lightSurfaceColor,
    colorScheme: const ColorScheme.light(
        surface: AppColors.lightSurfaceColor,
        primary: AppColors.primaryLightColor,
        onPrimaryContainer: AppColors.darkOnPrimaryContainerColor),
    appBarTheme: const AppBarTheme(
        //   centerTitle: true,
        backgroundColor: AppColors.lightSurfaceColor),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: "outfit",
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontFamily: "outfit",
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      displaySmall: TextStyle(
        fontFamily: "outfit",
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        fontFamily: "outfit",
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      headlineSmall: TextStyle(
        fontFamily: "outfit",
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: TextStyle(
        fontFamily: "outfit",
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        fontFamily: "outfit",
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        fontFamily: "outfit",
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      titleMedium: TextStyle(
        fontFamily: "outfit",
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        fontFamily: "outfit",
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        fontFamily: "outfit",
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ));

// app dark theme

final mDarkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    // primaryColor: AppColors.primaryDarkColor,
    scaffoldBackgroundColor: AppColors.darkSurfaceColor,
    colorScheme: const ColorScheme.dark(
        primaryContainer: AppColors.darkPrimaryContainerColor,
        surface: AppColors.darkSurfaceColor,
        primary: AppColors.primaryDarkColor,
        onPrimaryContainer: AppColors.darkOnPrimaryContainerColor),
    appBarTheme: const AppBarTheme(
        // centerTitle: true,
        backgroundColor: AppColors.darkSurfaceColor),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: "outfit",
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontFamily: "outfit",
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      displaySmall: TextStyle(
        fontFamily: "outfit",
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        fontFamily: "outfit",
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      headlineSmall: TextStyle(
        fontFamily: "outfit",
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: TextStyle(
        fontFamily: "outfit",
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        fontFamily: "outfit",
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        fontFamily: "outfit",
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      titleMedium: TextStyle(
        fontFamily: "outfit",
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        fontFamily: "outfit",
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        fontFamily: "outfit",
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ));
