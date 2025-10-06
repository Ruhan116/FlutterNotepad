import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../note/data/note_repository.dart';
import '../../../note/domain/note_model.dart';

part 'notes_provider.g.dart';

/// NOTES PROVIDER
///
/// Manages list of notes using Riverpod
/// This is a FutureProvider - handles async data loading
///
/// Why FutureProvider?
/// - Database operations are async
/// - Handles loading/error states automatically
/// - UI can easily show loading spinner
///
/// @riverpod generates:
/// - notesProvider (to get notes)
/// - ref.invalidate(notesProvider) to refresh

@riverpod
Future<List<Note>> notes(NotesRef ref) async {
  final repository = NoteRepository();

  // Fetch all notes from database
  return await repository.getAllNotes();
}

/// NOTES NOTIFIER
/// Provides methods to manipulate notes
///
/// Why separate notifier?
/// - FutureProvider is read-only
/// - Notifier provides actions (add, delete, update)
/// - After action, invalidate provider to refresh

@riverpod
class NotesNotifier extends _$NotesNotifier {
  late final NoteRepository _repository;

  @override
  void build() {
    _repository = NoteRepository();
  }

  /// ADD NOTE
  /// Creates new note and refreshes list
  Future<void> addNote({
    required String title,
    required String content,
  }) async {
    final now = DateTime.now();

    final note = Note(
      title: title,
      content: content,
      createdAt: now,
      updatedAt: now,
    );

    // Save to database
    await _repository.createNote(note);

    // Refresh the notes list
    // This triggers notesProvider to re-fetch
    ref.invalidate(notesProvider);
  }

  /// UPDATE NOTE
  /// Updates existing note and refreshes list
  Future<void> updateNote(Note note) async {
    await _repository.updateNote(note);

    // Refresh the notes list
    ref.invalidate(notesProvider);
  }

  /// DELETE NOTE
  /// Removes note and refreshes list
  Future<void> deleteNote(int id) async {
    await _repository.deleteNote(id);

    // Refresh the notes list
    ref.invalidate(notesProvider);
  }
}
