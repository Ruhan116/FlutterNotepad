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
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 4,
      shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),

      // Leading: back button if needed
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              // Use custom action if provided, otherwise use pop
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
