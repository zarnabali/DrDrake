// ignore: file_names
import 'package:flutter/material.dart';

class GradientLine extends StatelessWidget {
  GradientLine({super.key, required this.gradient_color});

  final List<Color> gradient_color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 5, // Adjust the height to make the line thinner or thicker
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient_color,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }
}
