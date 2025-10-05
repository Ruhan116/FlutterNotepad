import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notepad/core/widgets/navbar.dart';


class NotesListScreen extends StatelessWidget {
  const NotesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavbar(
        title: "My Notes",
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.go('/settings'),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/add_note'),
          ),
        ],
      ),
      body: const Center(
        child: Text("List of Notes will be displayed here"),
      ),
    );
  }
}