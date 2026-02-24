import 'package:flutter/material.dart';

/// Wraps any widget so that tapping outside a focused field
/// removes focus and hides the keyboard.
class TapUnfocus extends StatelessWidget {
  const TapUnfocus({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}
