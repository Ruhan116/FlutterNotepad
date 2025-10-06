import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


/// Reusable TopNavbar using ConsumerWidget for provider access
class TopNavbar extends ConsumerWidget implements PreferredSizeWidget {
  const TopNavbar({
    super.key,
    this.title = "",
    this.actions = const [],
    this.showBackButton = false,
    this.onBackPressed, // Custom back button action
  });

  final String title;
  final List<Widget> actions;
  final bool showBackButton;
  final VoidCallback? onBackPressed; // Optional custom back action

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get current theme to make navbar theme-aware
    // Theme.of(context) gives access to current theme colors
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppBar(
      // Use theme colors instead of hardcoded white
      // surfaceContainer is perfect for AppBar in Material 3
      // Automatically adapts to light/dark theme
      backgroundColor: colorScheme.surfaceContainer,

      // Foreground color for icons and text
      // onSurface ensures good contrast
      foregroundColor: colorScheme.onSurface,

      elevation: 4,

      // Shadow color also adapts to theme
      shadowColor: colorScheme.shadow.withValues(alpha: 0.25),

      // Leading: back button if needed
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
            )
          : null,

      title: Text(title),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}
