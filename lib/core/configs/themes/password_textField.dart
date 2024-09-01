import 'package:drdrakify/common/helpers/is_dark_mode.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordField({super.key, required this.controller});

  @override
  // ignore: library_private_types_in_public_api
  _PasswordField createState() => _PasswordField();
}

class _PasswordField extends State<PasswordField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        hintText: 'Password',
        suffixIcon: IconButton(
          icon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: context.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          onPressed: _toggleVisibility,
        ),
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
      style: TextStyle(
        color: context.isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }
}
