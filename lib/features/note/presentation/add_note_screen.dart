import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notepad/core/widgets/navbar.dart';
import '../../notes/presentation/provider/notes_provider.dart';

/// ADD NOTE SCREEN
/// Form to create new notes
///
/// StatefulWidget because we need TextEditingControllers
/// ConsumerStatefulWidget = StatefulWidget + Riverpod access
class AddNoteScreen extends ConsumerStatefulWidget {
  const AddNoteScreen({super.key});

  @override
  ConsumerState<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends ConsumerState<AddNoteScreen> {
  // TEXT CONTROLLERS
  // Manage text field state
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  // FORM KEY
  // For validation
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up controllers when widget is disposed
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  /// SAVE NOTE
  /// Validates and saves note to database
  Future<void> _saveNote() async {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Get text from controllers
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    // Save note using provider
    await ref.read(notesNotifierProvider.notifier).addNote(
          title: title,
          content: content,
        );

    // Go back to notes list
    if (mounted) {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavbar(
        title: "New Note",
        showBackButton: true,
        onBackPressed: () => context.go('/'),
        actions: [
          // SAVE BUTTON in AppBar
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveNote,
            tooltip: 'Save Note',
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // TITLE FIELD
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'Enter note title',
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.sentences,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // CONTENT FIELD
            TextFormField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: 'Content',
                hintText: 'Enter note content',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 15,
              minLines: 10,
              textCapitalization: TextCapitalization.sentences,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter some content';
                }
                return null;
              },
            ),

            const SizedBox(height: 24),

            // SAVE BUTTON
            ElevatedButton.icon(
              onPressed: _saveNote,
              icon: const Icon(Icons.save),
              label: const Text('Save Note'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}