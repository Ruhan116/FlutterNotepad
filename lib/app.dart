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
    // WATCH SETTINGS - When settings change, entire app rebuilds
    final settings = ref.watch(settingsProvider);

    // Helper function to create TextTheme with custom font sizes
    TextTheme _getTextTheme(double baseFontSize) {
      return TextTheme(
        bodyLarge: TextStyle(fontSize: baseFontSize * 1.0),
        bodyMedium: TextStyle(fontSize: baseFontSize * 0.875),
        bodySmall: TextStyle(fontSize: baseFontSize * 0.75),
        headlineLarge: TextStyle(fontSize: baseFontSize * 2.0),
        headlineMedium: TextStyle(fontSize: baseFontSize * 1.75),
        headlineSmall: TextStyle(fontSize: baseFontSize * 1.5),
        titleLarge: TextStyle(fontSize: baseFontSize * 1.375),
        titleMedium: TextStyle(fontSize: baseFontSize * 1.0),
        titleSmall: TextStyle(fontSize: baseFontSize * 0.875),
        labelLarge: TextStyle(fontSize: baseFontSize * 0.875),
        labelMedium: TextStyle(fontSize: baseFontSize * 0.75),
        labelSmall: TextStyle(fontSize: baseFontSize * 0.6875),
      );
    }

    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,

      // THEME MODE - Controls which theme to use
      // ThemeMode.light → always light
      // ThemeMode.dark → always dark
      // ThemeMode.system → follows device setting
      themeMode: settings.themeMode,

      // LIGHT THEME - Used when themeMode is light or system (if device is light)
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        textTheme: _getTextTheme(settings.fontSize),
      ),

      // DARK THEME - Used when themeMode is dark or system (if device is dark)
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        textTheme: _getTextTheme(settings.fontSize),
      ),
    );
  }
}