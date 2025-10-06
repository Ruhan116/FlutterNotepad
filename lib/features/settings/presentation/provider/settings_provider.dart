import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_provider.g.dart';

/// SETTINGS STATE - Holds all app settings
/// This is immutable (all fields are final)
/// Uses copyWith pattern for updates
class SettingsState {
  final double fontSize;
  final ThemeMode themeMode; // ← NEW: Light, Dark, or System

  const SettingsState({
    this.fontSize = 16.0,
    this.themeMode = ThemeMode.system, // ← Default: follow device
  });

  /// copyWith - Creates new state with updated values
  /// Only changed fields are updated, rest stay the same
  SettingsState copyWith({
    double? fontSize,
    ThemeMode? themeMode, // ← NEW: Add theme to copyWith
  }) {
    return SettingsState(
      fontSize: fontSize ?? this.fontSize,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}

/// SETTINGS NOTIFIER
/// Manages app settings and provides methods to update them
@riverpod
class Settings extends _$Settings {
  @override
  SettingsState build() {
    // Return initial state
    // Default: 16px font, system theme (follows device)
    return const SettingsState();
  }

  /// UPDATE FONT SIZE
  /// Called when user changes font size slider
  void updateFontSize(double newSize) {
    // Validation: keep font size in reasonable range
    if (newSize < 8.0 || newSize > 32.0) return;

    // Update state - triggers rebuild of all watching widgets
    state = state.copyWith(fontSize: newSize);
    // TODO: Save to SharedPreferences
  }

  /// UPDATE THEME MODE
  /// Called when user selects Light/Dark/System theme
  ///
  /// How it works:
  /// 1. User selects theme in settings
  /// 2. This method updates state
  /// 3. MyApp rebuilds with new theme
  /// 4. Entire app switches theme automatically
  void updateTheme(ThemeMode newTheme) {
    // Update state with new theme
    state = state.copyWith(themeMode: newTheme);
    // TODO: Save to SharedPreferences
  }
}
