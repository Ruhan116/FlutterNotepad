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
          ],
        ),
      ),
    );
  }
}