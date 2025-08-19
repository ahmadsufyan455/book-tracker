import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:librio/core/ext/ext_context.dart';
import 'package:librio/core/theme/app_colors.dart';
import 'package:librio/core/theme/text_styles.dart';
import 'package:librio/presentation/common_widgets/common_app_bar.dart';
import 'package:librio/presentation/common_widgets/help_menu.dart';

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: 'Settings',
        showBackButton: false,
        showHelpButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            _buildProfileHeader(),
            const SizedBox(height: 32),

            // Settings Sections
            _buildSettingsSection(),
            const SizedBox(height: 24),

            // App Info Section
            _buildAppInfoSection(),
            const SizedBox(height: 24),

            // Support Section
            _buildSupportSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    final colorScheme = context.theme.colorScheme;

    return Center(
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.librioBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Icon(Icons.person, size: 40, color: AppColors.librioBlue),
          ),
          const SizedBox(height: 16),
          Text(
            'Librio',
            style: LibrioTextStyle.headline?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Track your reading journey',
            style: LibrioTextStyle.smallBody?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          style: LibrioTextStyle.headline?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildSettingCard([
          _buildSettingItem(
            'Dark Mode',
            'Switch between light and dark themes',
            Icons.dark_mode,
            Switch(
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
                // TODO: Implement theme switching
              },
            ),
          ),
          _buildSettingItem(
            'Notifications',
            'Get reminders about your reading goals',
            Icons.notifications,
            Switch(
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
                // TODO: Implement notification settings
              },
            ),
          ),
          _buildSettingItem(
            'Language',
            'Choose your preferred language',
            Icons.language,
            DropdownButton<String>(
              value: _selectedLanguage,
              underline: Container(),
              items: ['English', 'Spanish', 'French', 'German']
                  .map(
                    (language) => DropdownMenuItem(
                      value: language,
                      child: Text(language),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
                // TODO: Implement language switching
              },
            ),
          ),
        ]),
      ],
    );
  }

  Widget _buildAppInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'App Info',
          style: LibrioTextStyle.headline?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildSettingCard([
          _buildSettingItem('Version', '1.0.0', Icons.info_outline, null),
          _buildSettingItem('Build Number', '1', Icons.build, null),
          _buildSettingItem(
            'Last Updated',
            'December 2024',
            Icons.update,
            null,
          ),
        ]),
      ],
    );
  }

  Widget _buildSupportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Support & Feedback',
          style: LibrioTextStyle.headline?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildSettingCard([
          _buildSettingItem(
            'Help & Support',
            'Get help and learn about features',
            Icons.help_outline,
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const HelpMenu(),
                );
              },
              icon: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ),
          _buildSettingItem(
            'Rate App',
            'Share your feedback on the app store',
            Icons.star_outline,
            IconButton(
              onPressed: () {
                // TODO: Implement app rating
              },
              icon: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ),
          _buildSettingItem(
            'Contact Us',
            'Send us feedback or report issues',
            Icons.email_outlined,
            IconButton(
              onPressed: () {
                // TODO: Implement contact form
              },
              icon: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ),
          _buildSettingItem(
            'Privacy Policy',
            'Read our privacy policy',
            Icons.privacy_tip_outlined,
            IconButton(
              onPressed: () {
                // TODO: Show privacy policy
              },
              icon: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ),
          _buildSettingItem(
            'Terms of Service',
            'Read our terms of service',
            Icons.description_outlined,
            IconButton(
              onPressed: () {
                // TODO: Show terms of service
              },
              icon: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ),
        ]),
      ],
    );
  }

  Widget _buildSettingCard(List<Widget> children) {
    final colorScheme = context.theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: colorScheme.brightness == Brightness.dark ? 0.2 : 0.1,
            ),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: children.asMap().entries.map((entry) {
          final index = entry.key;
          final child = entry.value;
          return Column(
            children: [
              child,
              if (index < children.length - 1)
                Divider(
                  height: 1,
                  indent: 56,
                  color: colorScheme.outline.withValues(alpha: 0.2),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSettingItem(
    String title,
    String subtitle,
    IconData icon,
    Widget? trailing,
  ) {
    final colorScheme = context.theme.colorScheme;

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.librioBlue.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.librioBlue, size: 20),
      ),
      title: Text(title, style: LibrioTextStyle.bodyBold),
      subtitle: Text(
        subtitle,
        style: LibrioTextStyle.smallBody?.copyWith(
          color: colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
      trailing: trailing,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}
