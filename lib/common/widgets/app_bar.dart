import 'package:drdrakify/common/helpers/is_dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BasicAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? action;
  final Color? background;
  final VoidCallback onPressed;
  final bool hideBack;
  const BasicAppbar(
      {this.title,
      this.hideBack = false,
      this.action,
      this.background,
      required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: background ?? Colors.transparent,
      title: title ?? const Text(''),
      actions: [action ?? Container()],
      elevation: 0,
      centerTitle: true,
      leading: hideBack
          ? null
          : IconButton(
              icon: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: context.isDarkMode
                        ? Colors.white.withOpacity(0.03)
                        : Colors.black.withOpacity(0.04),
                    shape: BoxShape.circle),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 15,
                  color: context.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              onPressed: () {
                onPressed();
              },
            ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
