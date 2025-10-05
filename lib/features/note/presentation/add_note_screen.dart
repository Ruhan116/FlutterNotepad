import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notepad/core/widgets/navbar.dart';

class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavbar(
        title: "New Note",
        showBackButton: true,
        onBackPressed: () => context.go('/'), // Route to notes list
      ),
      body: Center(
        child: Text("Add a new note here."),
      ),
    );
  }
}