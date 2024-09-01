import 'package:drdrakify/core/configs/themes/GradientText.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class logo extends StatelessWidget {
  const logo({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    print(isDarkMode);
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
          fontSize: 70,
          fontWeight: FontWeight.bold,
          letterSpacing: -1.5,
        ),
      ),
      Text(
        'drake',
        style: TextStyle(
            fontFamily: 'PlayfairDisplay',
            fontStyle: FontStyle.italic,
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 70,
            fontWeight: FontWeight.normal),
      ),
    ]);
  }
}
