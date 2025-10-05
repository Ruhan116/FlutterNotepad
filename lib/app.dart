import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router.dart';
import 'features/settings/presentation/provider/settings_provider.dart';

/// Changed to ConsumerWidget to access settings provider
/// This makes MyApp rebuild when settings change
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // WATCH SETTINGS - When settings change, entire app rebuilds with new theme
    final settings = ref.watch(settingsProvider);

    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,

      // GLOBAL THEME - This applies to all text in the app
      theme: ThemeData(
        // Use default Material3 theme
        useMaterial3: true,

        // TEXT THEME - Customize all text styles based on settings
        textTheme: TextTheme(
          // Body text - used by default Text widgets
          bodyLarge: TextStyle(fontSize: settings.fontSize * 1.0),
          bodyMedium: TextStyle(fontSize: settings.fontSize * 0.875),
          bodySmall: TextStyle(fontSize: settings.fontSize * 0.75),

          // Headlines - used by titles
          headlineLarge: TextStyle(fontSize: settings.fontSize * 2.0),
          headlineMedium: TextStyle(fontSize: settings.fontSize * 1.75),
          headlineSmall: TextStyle(fontSize: settings.fontSize * 1.5),

          // Title styles - used by AppBar, ListTile titles
          titleLarge: TextStyle(fontSize: settings.fontSize * 1.375),
          titleMedium: TextStyle(fontSize: settings.fontSize * 1.0),
          titleSmall: TextStyle(fontSize: settings.fontSize * 0.875),

          // Label styles - used by buttons, chips
          labelLarge: TextStyle(fontSize: settings.fontSize * 0.875),
          labelMedium: TextStyle(fontSize: settings.fontSize * 0.75),
          labelSmall: TextStyle(fontSize: settings.fontSize * 0.6875),
        ),
      ),
    );
  }
}