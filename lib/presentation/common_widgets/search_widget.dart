import 'package:flutter/material.dart';
import 'package:librio/core/ext/ext_context.dart';
import 'package:librio/core/theme/app_colors.dart';
import 'package:librio/core/theme/text_styles.dart';

class SearchWidget extends StatelessWidget {
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback? onClear;
  final String hintText;
  final bool showClearButton;

  const SearchWidget({
    super.key,
    required this.searchQuery,
    required this.onSearchChanged,
    this.onClear,
    this.hintText = 'Search...',
    this.showClearButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = theme.brightness == Brightness.dark;

    return TextField(
      onChanged: onSearchChanged,
      onTapOutside: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: LibrioTextStyle.body?.copyWith(
          color: context.theme.colorScheme.onSurface.withValues(alpha: 0.5),
        ),
        prefixIcon: const Icon(Icons.search),
        suffixIcon: showClearButton && searchQuery.isNotEmpty
            ? IconButton(onPressed: onClear, icon: const Icon(Icons.clear))
            : null,
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
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2.0),
        ),
        filled: true,
        fillColor: isDark
            ? AppColors.librioDarkSurfaceVariant
            : AppColors.librioLightSurfaceVariant,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }
}
