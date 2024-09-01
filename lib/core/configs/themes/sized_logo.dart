import 'package:drdrakify/core/configs/themes/GradientText.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SizedLogo extends StatelessWidget {
  const SizedLogo({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Align(
      alignment: Alignment.center,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        GradientText(
          'dr',
          gradient: const LinearGradient(
            colors: [
              Color(0xFFFFD319),
              Color(0xFFFF2975),
              Color(0xFF8C1EFF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          style: GoogleFonts.openSans(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.5,
          ),
        ),
      ]),
    );
  }
}
