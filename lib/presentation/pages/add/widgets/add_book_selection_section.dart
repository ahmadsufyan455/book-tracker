import 'package:flutter/material.dart';
import 'package:librio/core/ext/ext_context.dart';
import 'package:librio/core/theme/text_styles.dart';
import 'package:librio/presentation/pages/add/widgets/add_book_chip.dart';

class AddBookSelectionSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> options;
  final List<bool> selectedStates;
  final Function(int index) onTap;
  final String? helperText;
  final bool showHelperText;
  final bool showAddButton;
  final Function()? onAddTap;

  const AddBookSelectionSection({
    super.key,
    required this.title,
    required this.icon,
    required this.options,
    required this.selectedStates,
    required this.onTap,
    this.helperText,
    this.showHelperText = false,
    this.showAddButton = false,
    this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 8),
              Text(title, style: LibrioTextStyle.bodyBold),
              if (showAddButton)
                IconButton(
                  onPressed: onAddTap,
                  icon: Icon(Icons.add, size: 20),
                ),
            ],
          ),
        ),

        // Selection chips
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: theme.colorScheme.primary.withValues(alpha: 0.3),
              width: 1.0,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              final isSelected = selectedStates[index];

              return AddBookChip(
                label: option,
                isSelected: isSelected,
                onTap: () => onTap(index),
              );
            }).toList(),
          ),
        ),

        // Helper text
        if (showHelperText && helperText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 4.0),
            child: Text(
              helperText!,
              style: LibrioTextStyle.smallBody?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }
}
