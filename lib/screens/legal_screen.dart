import 'package:flutter/material.dart';

class LegalScreen extends StatelessWidget {
  const LegalScreen({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 12, 22, 40),
        child: SelectableText(
          content,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.65),
        ),
      ),
    );
  }
}

const privacyText = '''
Privacy Policy

Last updated: July 2026

Focus Forest is designed to work offline. The app does not require an account, registration, or login.

Information Collection
Focus Forest does not collect, sell, rent, or share personal information. The app does not request your name, email address, phone number, location, contacts, photos, camera, microphone, or payment details.

Local Storage
Focus sessions, trees, XP, coins, streaks, achievements, and settings are stored locally on your device using standard application storage.

Internet, Analytics, and Advertising
The core application does not require an internet connection. It does not use advertising SDKs, analytics SDKs, tracking technologies, Firebase, or a remote backend.

Permissions
The app may use basic haptic feedback when enabled. It does not require sensitive permissions for its core features.

Data Deletion
You can delete local progress using the Reset All Progress option. Uninstalling the application or clearing its data may also permanently remove locally stored information.

Children's Privacy
The app does not knowingly collect personal information from children or adults. It contains no chat, public profiles, or social interaction.

Changes
This Privacy Policy may be updated when features or legal requirements change.

Contact Us
For privacy questions or support, use the Contact Us information shown on the application's official store listing.
''';

const termsText = '''
Terms & Conditions

Last updated: July 2026

By downloading or using Focus Forest, you agree to these Terms & Conditions.

Purpose
Focus Forest is a personal productivity and entertainment application. It is not medical, psychological, legal, financial, or professional advice.

Local Data
Application progress is stored locally. Clearing app data, uninstalling the app, or losing access to the device may permanently remove progress.

Acceptable Use
You agree not to misuse the application, interfere with its operation, distribute unauthorized modified copies, or use it for unlawful purposes.

Intellectual Property
The app's branding, interface, illustrations, content, and software are protected by applicable intellectual-property laws.

Availability
Features may be changed, improved, suspended, or removed. Continuous availability or compatibility with every device is not guaranteed.

Disclaimer
The application is provided on an "as available" basis to the maximum extent permitted by law.

Limitation of Liability
The developer is not responsible for indirect or consequential losses, including the loss of locally stored progress.

Contact Us
For support or questions about these Terms, use the Contact Us information shown on the application's official store listing.
''';
