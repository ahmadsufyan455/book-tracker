import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:librio/core/ext/ext_context.dart';
import 'package:librio/core/theme/text_styles.dart';
import 'package:librio/presentation/common_widgets/help_content.dart';
import 'package:librio/presentation/common_widgets/help_content_widgets.dart';

class HelpMenu extends StatefulWidget {
  const HelpMenu({super.key});

  @override
  State<HelpMenu> createState() => _HelpMenuState();
}

class _HelpMenuState extends State<HelpMenu> {
  String? _currentView;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                if (_currentView != null)
                  IconButton(
                    onPressed: () => setState(() => _currentView = null),
                    icon: const Icon(Icons.arrow_back),
                    style: IconButton.styleFrom(
                      backgroundColor: theme.colorScheme.surface,
                    ),
                  ),
                if (_currentView == null) ...[
                  Icon(
                    Icons.help_outline_rounded,
                    color: theme.colorScheme.primary,
                    size: 24,
                  ),
                  const Gap(12),
                ],
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position:
                                  Tween<Offset>(
                                    begin: const Offset(0.1, 0),
                                    end: Offset.zero,
                                  ).animate(
                                    CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeInOut,
                                    ),
                                  ),
                              child: child,
                            ),
                          );
                        },
                    child: Text(
                      _currentView ?? 'Help & Support',
                      key: ValueKey(_currentView),
                      style: LibrioTextStyle.headline?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => context.maybePop(),
                  icon: const Icon(Icons.close),
                  style: IconButton.styleFrom(
                    backgroundColor: theme.colorScheme.surface,
                  ),
                ),
              ],
            ),
            const Gap(24),

            // Content with smooth transitions
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position:
                          Tween<Offset>(
                            begin: const Offset(0.2, 0),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeInOutCubic,
                            ),
                          ),
                      child: child,
                    ),
                  );
                },
                child: _buildContent(),
              ),
            ),

            // Footer (only show in main menu)
            if (_currentView == null) ...[
              const Gap(20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: theme.colorScheme.primary.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.feedback_outlined,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                    const Gap(8),
                    Expanded(
                      child: Text(
                        'Have feedback? We\'d love to hear from you!',
                        style: LibrioTextStyle.smallBody?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    Widget content;
    switch (_currentView) {
      case 'Add Book Guide':
        content = const AddBookHelpContent();
        break;
      case 'Quick Tips':
        content = const QuickTipsContent();
        break;
      case 'Feature Tour':
        content = const FeatureTourContent();
        break;
      case 'About Librio':
        content = const AboutLibrioContent();
        break;
      default:
        content = _buildMainMenu();
        break;
    }

    return Container(key: ValueKey(_currentView), child: content);
  }

  Widget _buildMainMenu() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHelpOption(
            '📚 Add Book Guide',
            'Learn how to add and organize your books',
            Icons.book,
            () => setState(() => _currentView = 'Add Book Guide'),
          ),
          const Gap(12),
          _buildHelpOption(
            '💡 Quick Tips',
            'Pro tips and best practices',
            Icons.lightbulb_outline,
            () => setState(() => _currentView = 'Quick Tips'),
          ),
          const Gap(12),
          _buildHelpOption(
            '🎯 Feature Tour',
            'Take a tour of the app features',
            Icons.explore_outlined,
            () => setState(() => _currentView = 'Feature Tour'),
          ),
          const Gap(12),
          _buildHelpOption(
            'ℹ️ About Librio',
            'Learn more about the app',
            Icons.info_outline,
            () => setState(() => _currentView = 'About Librio'),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpOption(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    final theme = context.theme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: theme.colorScheme.primary, size: 20),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: LibrioTextStyle.bodyBold),
                  const Gap(2),
                  Text(
                    subtitle,
                    style: LibrioTextStyle.smallBody?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ],
        ),
      ),
    );
  }
}
