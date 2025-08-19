import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:librio/core/theme/text_styles.dart';

class QuickTipsContent extends StatelessWidget {
  const QuickTipsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('💡 Pro Tips:', style: LibrioTextStyle.bodyBold),
          const Gap(8),
          _buildTipItem('Use categories to organize your library'),
          _buildTipItem('Add detailed descriptions for better search'),
          _buildTipItem('Update your reading progress regularly'),
          _buildTipItem('Add notes when you finish a book'),
          _buildTipItem('Use the search feature to find books quickly'),
          const Gap(16),
          Text('🎯 Best Practices:', style: LibrioTextStyle.bodyBold),
          const Gap(8),
          _buildTipItem('Keep your book covers high quality'),
          _buildTipItem('Use consistent category naming'),
          _buildTipItem('Regular backups of your data'),
          _buildTipItem('Review and update book statuses'),
        ],
      ),
    );
  }

  Widget _buildTipItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• '),
          Expanded(child: Text(text, style: LibrioTextStyle.smallBody)),
        ],
      ),
    );
  }
}

class FeatureTourContent extends StatelessWidget {
  const FeatureTourContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to Librio!',
            style: LibrioTextStyle.headline?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(16),
          Text(
            'Let\'s take a quick tour of the main features:',
            style: LibrioTextStyle.body,
          ),
          const Gap(20),
          _buildFeatureItem('1. Add books with covers and details'),
          _buildFeatureItem('2. Organize with categories'),
          _buildFeatureItem('3. Track your reading progress'),
          _buildFeatureItem('4. Add personal notes and thoughts'),
          const Gap(20),
          Text(
            'Tap the help button (?) anytime for assistance!',
            style: LibrioTextStyle.smallBody?.copyWith(
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: LibrioTextStyle.body)),
        ],
      ),
    );
  }
}

class AboutLibrioContent extends StatelessWidget {
  const AboutLibrioContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                const FlutterLogo(size: 64),
                const Gap(16),
                Text(
                  'Librio',
                  style: LibrioTextStyle.headline?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Version 1.0.0',
                  style: LibrioTextStyle.smallBody?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Gap(24),
          Text(
            'Librio is your personal book tracking companion. '
            'Organize your reading journey, track your progress, '
            'and discover new books to read.',
            style: LibrioTextStyle.body,
          ),
          const Gap(16),
          Text('Features:', style: LibrioTextStyle.bodyBold),
          const Gap(8),
          _buildFeatureItem('• Add and organize your books'),
          _buildFeatureItem('• Track reading progress'),
          _buildFeatureItem('• Categorize your library'),
          _buildFeatureItem('• Add personal notes and thoughts'),
          _buildFeatureItem('• Beautiful, intuitive interface'),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(text, style: LibrioTextStyle.body),
    );
  }
}
