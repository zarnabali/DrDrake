import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class GradientButton extends StatelessWidget {
  List<Color> gradient_color = [
    const Color(0xFFFFD319),
    const Color(0xFFFF2975),
    const Color(0xFF8C1EFF)
  ];
  String text;
  final VoidCallback onPressed;
  final double? height;
  GradientButton(
      {super.key, required this.text, required this.onPressed, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Adjust the width as needed
      height: height ?? 80, // Adjust the height as needed
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.fromHeight(height ??
              80), // Ensure no padding to allow full gradient coverage
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: onPressed,
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradient_color,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
