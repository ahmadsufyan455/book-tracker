import 'package:flutter/material.dart';
import 'package:librio/core/ext/ext_context.dart';

class LinearProgress extends StatelessWidget {
  const LinearProgress({super.key, required this.progress, this.valueColor});

  final double progress;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: LinearProgressIndicator(
        minHeight: 8,
        value: progress,
        valueColor: AlwaysStoppedAnimation<Color>(
          valueColor ?? colorScheme.primary,
        ),
        backgroundColor: colorScheme.outline.withValues(alpha: 0.2),
      ),
    );
  }
}
