import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notepad/core/widgets/navbar.dart';
import 'provider/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: TopNavbar(
        title: "Settings",
        showBackButton: true,
        onBackPressed: () => context.go('/'), // Route to notes list
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Font Size',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Current: ${settings.fontSize.toStringAsFixed(1)}',
              style: TextStyle(fontSize: settings.fontSize),
            ),
            const SizedBox(height: 16),
            Slider(
              value: settings.fontSize,
              min: 8.0,
              max: 32.0,
              divisions: 24, // Steps of 1
              label: settings.fontSize.toStringAsFixed(1),
              onChanged: (newSize) {
                ref.read(settingsProvider.notifier).updateFontSize(newSize);
              },
            ),

            const SizedBox(height: 24),

            // Preview text at different sizes
            const Text('Preview:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Small text', style: TextStyle(fontSize: settings.fontSize * 0.8)),
            Text('Normal text', style: TextStyle(fontSize: settings.fontSize)),
            Text('Large text', style: TextStyle(fontSize: settings.fontSize * 1.2)),

            const SizedBox(height: 32),
            const Divider(), // Visual separator
            const SizedBox(height: 16),

            // THEME SECTION
            Text(
              'Theme',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            // RADIO BUTTONS FOR THEME SELECTION
            // How RadioListTile works:
            // - value: The value this option represents
            // - groupValue: The currently selected value
            // - When value == groupValue, radio is selected
            // - onChanged: Called when user taps this option

            // LIGHT THEME OPTION
            RadioListTile<ThemeMode>(
              title: const Text('Light'),
              subtitle: const Text('Always use light theme'),
              value: ThemeMode.light, // This option's value
              groupValue: settings.themeMode, // Currently selected theme
              onChanged: (value) {
                if (value != null) {
                  ref.read(settingsProvider.notifier).updateTheme(value);
                }
              },
              secondary: const Icon(Icons.light_mode),
            ),

            // DARK THEME OPTION
            RadioListTile<ThemeMode>(
              title: const Text('Dark'),
              subtitle: const Text('Always use dark theme'),
              value: ThemeMode.dark,
              groupValue: settings.themeMode,
              onChanged: (value) {
                if (value != null) {
                  ref.read(settingsProvider.notifier).updateTheme(value);
                }
              },
              secondary: const Icon(Icons.dark_mode),
            ),

            // SYSTEM THEME OPTION (follows device settings)
            RadioListTile<ThemeMode>(
              title: const Text('System'),
              subtitle: const Text('Follow device theme settings'),
              value: ThemeMode.system,
              groupValue: settings.themeMode,
              onChanged: (value) {
                if (value != null) {
                  ref.read(settingsProvider.notifier).updateTheme(value);
                }
              },
              secondary: const Icon(Icons.auto_mode),
            ),
          ],
        ),
      ),
    );
  }
}