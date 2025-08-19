import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:librio/core/ext/ext_context.dart';
import 'package:librio/core/theme/app_colors.dart';
import 'package:librio/core/theme/text_styles.dart';
import 'package:librio/presentation/common_widgets/help_menu.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool showHelpButton;
  final List<Widget>? additionalActions;
  final VoidCallback? onBackPressed;
  final bool centerTitle;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CommonAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.showHelpButton = true,
    this.additionalActions,
    this.onBackPressed,
    this.centerTitle = true,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final effectiveBackgroundColor =
        backgroundColor ?? theme.colorScheme.surface;
    final effectiveForegroundColor =
        foregroundColor ?? theme.colorScheme.onSurface;

    return AppBar(
      title: Text(
        title,
        style: LibrioTextStyle.subHeadline?.copyWith(
          color: effectiveForegroundColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: centerTitle,
      elevation: 0,
      backgroundColor: effectiveBackgroundColor,
      foregroundColor: effectiveForegroundColor,
      leading: showBackButton
          ? Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.librioBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.librioBlue.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: IconButton(
                onPressed: onBackPressed ?? () => context.back(),
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.librioBlue,
                  size: 20,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: AppColors.librioBlue,
                  padding: const EdgeInsets.all(8),
                ),
              ),
            )
          : null,
      actions: [
        if (showHelpButton) ...[
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.librioBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.librioBlue.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const HelpMenu(),
                );
              },
              icon: Icon(
                Icons.help_outline_rounded,
                color: AppColors.librioBlue,
                size: 20,
              ),
              style: IconButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: AppColors.librioBlue,
                padding: const EdgeInsets.all(8),
              ),
            ),
          ),
        ],
        if (additionalActions != null) ...[
          ...additionalActions!,
          const SizedBox(width: 8),
        ],
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                AppColors.librioBlue.withValues(alpha: 0.1),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
