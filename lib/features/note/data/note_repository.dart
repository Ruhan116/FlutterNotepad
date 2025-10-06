import '../domain/note_model.dart';
import 'database_helper.dart';

/// NOTE REPOSITORY (Data Layer)
///
/// Repository Pattern - Abstracts data source
/// Benefits:
/// - UI doesn't know about database implementation
/// - Easy to switch data sources (SQLite → Firebase → API)
/// - Converts between database Maps and domain Note objects
/// - Single source of truth for data operations
///
/// Clean Architecture:
/// Presentation → Repository → Database
/// (knows Note) → (knows both) → (knows Map)

class NoteRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  /// CREATE NOTE
  /// Saves new note to database
  ///
  /// Flow:
  /// 1. Convert Note object → Map
  /// 2. Insert into database
  /// 3. Get auto-generated ID
  /// 4. Return Note with ID
  Future<Note> createNote(Note note) async {
    final id = await _dbHelper.insertNote(note.toMap());

    // Return note with the generated ID
    return note.copyWith(id: id);
  }

  /// GET ALL NOTES
  /// Retrieves all notes from database
  ///
  /// Flow:
  /// 1. Get all rows from database (List<Map>)
  /// 2. Convert each Map → Note object
  /// 3. Return List<Note>
  Future<List<Note>> getAllNotes() async {
    final noteMaps = await _dbHelper.getAllNotes();

    // Convert each Map to Note object
    return noteMaps.map((map) => Note.fromMap(map)).toList();
  }

  /// GET NOTE BY ID
  /// Retrieves single note
  Future<Note?> getNoteById(int id) async {
    final noteMap = await _dbHelper.getNote(id);

    if (noteMap != null) {
      return Note.fromMap(noteMap);
    }
    return null;
  }

  /// UPDATE NOTE
  /// Updates existing note
  ///
  /// Important: Update the 'updatedAt' timestamp!
  Future<void> updateNote(Note note) async {
    // Update the updatedAt timestamp
    final updatedNote = note.copyWith(updatedAt: DateTime.now());

    await _dbHelper.updateNote(updatedNote.toMap());
  }

  /// DELETE NOTE
  /// Removes note from database
  Future<void> deleteNote(int id) async {
    await _dbHelper.deleteNote(id);
  }
}
