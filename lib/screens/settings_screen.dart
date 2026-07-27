import 'package:flutter/material.dart';
import '../app.dart';
import 'legal_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  value: controller.darkMode,
                  onChanged: controller.toggleDarkMode,
                  title: const Text('Dark mode'),
                  secondary: const Icon(Icons.dark_mode_outlined),
                ),
                SwitchListTile(
                  value: controller.soundEnabled,
                  onChanged: controller.toggleSound,
                  title: const Text('Sound effects'),
                  secondary: const Icon(Icons.volume_up_outlined),
                ),
                SwitchListTile(
                  value: controller.hapticsEnabled,
                  onChanged: controller.toggleHaptics,
                  title: const Text('Haptic feedback'),
                  secondary: const Icon(Icons.vibration_rounded),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: const Text('Privacy Policy'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const LegalScreen(
                        title: 'Privacy Policy',
                        content: privacyText,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.description_outlined),
                  title: const Text('Terms & Conditions'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const LegalScreen(
                        title: 'Terms & Conditions',
                        content: termsText,
                      ),
                    ),
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('Version'),
                  trailing: Text('1.0.0'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text('Reset all progress'),
              subtitle: const Text('Delete sessions, trees, XP, and coins'),
              onTap: () async {
                final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Reset everything?'),
                        content: const Text(
                          'This action permanently removes all locally stored progress.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                          FilledButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Reset'),
                          ),
                        ],
                      ),
                    ) ??
                    false;
                if (confirmed) await controller.resetAll();
              },
            ),
          ),
        ],
      ),
    );
  }
}
