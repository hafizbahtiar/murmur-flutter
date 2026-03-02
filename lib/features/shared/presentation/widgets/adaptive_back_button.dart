import 'dart:io';
import 'package:flutter/material.dart';

class AdaptiveBackButton extends StatelessWidget {
  final Color? color;
  final VoidCallback? onPressed;

  const AdaptiveBackButton({super.key, this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    // Check if running on iOS or macOS
    final isIos = Platform.isIOS || Platform.isMacOS;

    return IconButton(
      icon: Padding(
        padding: isIos ? const EdgeInsets.only(left: 4.0) : EdgeInsets.zero,
        child: Icon(Icons.adaptive.arrow_back, color: color),
      ),
      onPressed: onPressed ?? () => Navigator.of(context).pop(),
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
    );
  }
}
