import 'package:flutter/material.dart';
import 'package:librio/core/ext/ext_context.dart';
import 'package:librio/core/theme/text_styles.dart';

class CommonTextfield extends StatelessWidget {
  const CommonTextfield({
    super.key,
    required this.label,
    required this.controller,
    this.maxLines = 1,
    this.minLines = 1,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputAction = TextInputAction.next,
    this.isRequired = false,
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final int maxLines;
  final int minLines;
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputAction textInputAction;
  final bool isRequired;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
          child: Row(
            children: [
              Text(label, style: LibrioTextStyle.bodyBold),
              if (isRequired)
                Text(
                  ' *',
                  style: LibrioTextStyle.bodyBold?.copyWith(color: Colors.red),
                ),
            ],
          ),
        ),
        TextField(
          controller: controller,
          textInputAction: textInputAction,
          maxLines: maxLines,
          minLines: minLines,
          keyboardType: keyboardType,
          style: LibrioTextStyle.body?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: LibrioTextStyle.body?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    size: 20,
                  )
                : null,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: theme.colorScheme.primary.withValues(alpha: 0.3),
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: theme.colorScheme.error,
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: theme.colorScheme.error,
                width: 2.0,
              ),
            ),
            filled: true,
            fillColor: theme.colorScheme.surface.withValues(alpha: 0.3),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            labelText: null,
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        ),
      ],
    );
  }
}
