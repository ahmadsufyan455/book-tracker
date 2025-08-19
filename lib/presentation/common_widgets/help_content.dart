import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:librio/core/theme/text_styles.dart';

class AddBookHelpContent extends StatelessWidget {
  const AddBookHelpContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection('📖 Adding a New Book', [
            'Tap the + button on the home screen',
            'Fill in the book details (title, author, etc.)',
            'Choose a category and reading status',
            'Add a cover image (optional)',
            'Tap "Add Book" to save',
          ]),
          const Gap(24),
          _buildSection('📝 Required Fields', [
            'Book Title - The name of the book',
            'Author - Who wrote the book',
            'Category - What type of book it is',
            'Reading Status - Your current progress',
          ]),
          const Gap(24),
          _buildSection('🖼️ Cover Image', [
            'Tap the image area to add a cover',
            'You can take a photo or choose from gallery',
            'The image will be automatically cropped to fit',
            'You can skip this step if you prefer',
          ]),
          const Gap(24),
          _buildSection('📊 Reading Status', [
            'Not Started - Haven\'t begun reading yet',
            'Currently Reading - Currently reading the book',
            'Completed - Finished reading the book',
            'On Hold - Temporarily stopped reading',
          ]),
          const Gap(24),
          _buildSection('💡 Tips', [
            'Use descriptive titles for better organization',
            'Add cover images to easily identify books',
            'Update reading status as you progress',
            'Use categories to group similar books',
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: LibrioTextStyle.bodyBold?.copyWith(fontSize: 18)),
        const Gap(12),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    shape: BoxShape.circle,
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Text(
                    item,
                    style: LibrioTextStyle.body?.copyWith(height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
