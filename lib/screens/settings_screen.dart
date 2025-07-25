import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';
import '../widgets/settings/reset_button.dart';
import '../widgets/settings/theme_toggle.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Consumer<AppProvider>(
        builder: (context, appProvider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Reset All Counters',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Text(
                          'This will reset all counters to zero. This action cannot be undone.',
                        ),
                        ResetButton(onReset: appProvider.resetAll),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ThemeToggle(
                  darkMode: appProvider.state.darkMode,
                  onToggle: appProvider.toggleTheme,
                ),
                const SizedBox(height: 24.0),
                _buildAboutSection(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'T&B Food Ordering and Settlement Tracking Application',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4.0),
            const Text('Version 1.1.0'),
            const SizedBox(height: 16.0),
            const Text(
              'This application helps track food orders and calculate settlement amounts for suppliers.',
            ),
          ],
        ),
      ),
    );
  }
}
