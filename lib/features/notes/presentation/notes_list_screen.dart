import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notepad/core/widgets/navbar.dart';
import 'provider/notes_provider.dart';

/// NOTES LIST SCREEN
/// Displays all notes from database
///
/// ConsumerWidget gives access to providers via 'ref'
class NotesListScreen extends ConsumerWidget {
  const NotesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // WATCH NOTES PROVIDER
    // This is AsyncValue<List<Note>> - handles loading/error/data states
    final notesAsync = ref.watch(notesProvider);

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

      // ASYNC VALUE HANDLING
      // .when() method handles all states elegantly
      body: notesAsync.when(
        // LOADING STATE - Show spinner
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),

        // ERROR STATE - Show error message
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(notesProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),

        // DATA STATE - Show notes list
        data: (notes) {
          // Empty state
          if (notes.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.note_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No notes yet',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tap + to create your first note',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          // List of notes
          return ListView.builder(
            itemCount: notes.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final note = notes[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  title: Text(
                    note.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    note.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      // Delete note
                      ref
                          .read(notesNotifierProvider.notifier)
                          .deleteNote(note.id!);
                    },
                  ),
                  onTap: () {
                    // TODO: Navigate to edit note screen
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}