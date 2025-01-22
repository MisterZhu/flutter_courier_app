import 'package:courier_app/widgets/base/texts.dart';
import 'package:flutter/material.dart';

class SingleButtonBottomBar extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;

  final EdgeInsetsGeometry padding;

  const SingleButtonBottomBar({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 65,
      color: Colors.white,
      child: Padding(
        padding: padding,
        child: FilledButton(
          onPressed: onPressed,
          child: Texts.larger(
            buttonText,
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }
}
