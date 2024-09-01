import 'package:drdrakify/core/configs/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightColorscheme = ColorScheme.fromSwatch().copyWith(
    primary: AppColors.yellow_color,
    secondary: AppColors.red_color,
    brightness: Brightness.light // Replace with your secondary color
    );

final darkColorscheme = ColorScheme.fromSwatch().copyWith(
    primary: AppColors.yellow_color,
    secondary: AppColors.red_color,
    brightness: Brightness.dark // Replace with your secondary color
    );

class AppThemes {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.purple_color,
    colorScheme: lightColorscheme,
    textTheme: ThemeData().textTheme.copyWith(
        titleSmall: GoogleFonts.openSans(fontWeight: FontWeight.normal)),
    scaffoldBackgroundColor: AppColors.light_background,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      hintStyle:
          const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
      contentPadding: const EdgeInsets.all(30),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.black, width: 0.4),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.black, width: 0.4),
      ),
    ),
  )
      //brightness: Brightness.light)
      ;

  static final darkTheme = ThemeData(
    primaryColor: AppColors.purple_color,
    colorScheme: darkColorscheme,
    scaffoldBackgroundColor: AppColors.dark_background,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      hintStyle:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      contentPadding: const EdgeInsets.all(30),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.white, width: 0.4),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.white, width: 0.4),
      ),
    ),
  );
}
