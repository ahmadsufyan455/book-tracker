import 'package:flutter/material.dart';
import 'package:librio/core/ext/ext_context.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.onPressed, required this.child});
  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: context.theme.colorScheme.primary,
        foregroundColor: context.theme.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        textStyle: const TextStyle(fontSize: 16.0),
        minimumSize: const Size(double.infinity, 48.0),
        elevation: 0,
        shadowColor: Colors.transparent,
        side: BorderSide.none,
      ),
      child: child,
    );
  }
}
