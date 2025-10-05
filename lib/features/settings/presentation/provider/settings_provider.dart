import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'settings_provider.g.dart';


class SettingsState {
  final double fontSize;
  // We'll add theme here later!

  const SettingsState({
    this.fontSize = 16.0, 
  });

  SettingsState copyWith({
    double? fontSize,
  }) {
    return SettingsState(
      fontSize: fontSize ?? this.fontSize,
    );
  }
}

@riverpod
class Settings extends _$Settings {
  @override
  SettingsState build() {
    // Return initial state
    // Later we can load from SharedPreferences here!
    return const SettingsState();
  }

  void updateFontSize(double newSize) {
    // Validation: keep font size in reasonable range
    if (newSize < 8.0 || newSize > 32.0) return;
    state = state.copyWith(fontSize: newSize);
  }
}
