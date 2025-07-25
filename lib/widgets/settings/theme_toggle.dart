import 'package:flutter/material.dart';

class ThemeToggle extends StatelessWidget {
  final bool darkMode;
  final VoidCallback onToggle;

  const ThemeToggle({
    super.key,
    required this.darkMode,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'App Theme',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.light_mode),
                const SizedBox(width: 8.0),
                Switch(value: darkMode, onChanged: (_) => onToggle()),
                const SizedBox(width: 8.0),
                const Icon(Icons.dark_mode),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              darkMode ? 'Dark Theme' : 'Light Theme',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
