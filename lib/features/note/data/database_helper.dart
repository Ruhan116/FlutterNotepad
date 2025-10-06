import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// DATABASE HELPER (Data Layer)
///
/// Singleton pattern - only one database instance exists
/// Handles:
/// - Database creation
/// - Table schema
/// - Database version management
///
/// Why Singleton?
/// - Prevent multiple database connections
/// - Memory efficient
/// - Thread-safe access
class DatabaseHelper {
  // Singleton instance
  static final DatabaseHelper instance = DatabaseHelper._internal();

  // Private constructor (can't create new instances)
  DatabaseHelper._internal();

  // Database instance (nullable until initialized)
  static Database? _database;

  /// Database name
  static const String _databaseName = 'notepad.db';
  static const int _databaseVersion = 1;

  /// Table name
  static const String tableNotes = 'notes';

  /// Column names
  static const String columnId = 'id';
  static const String columnTitle = 'title';
  static const String columnContent = 'content';
  static const String columnCreatedAt = 'createdAt';
  static const String columnUpdatedAt = 'updatedAt';

  /// GET DATABASE
  /// Returns existing database or creates new one
  ///
  /// How it works:
  /// 1. If database exists → return it
  /// 2. If not → create it
  /// 3. Cache it for future use
  Future<Database> get database async {
    if (_database != null) return _database!;

    // Initialize database
    _database = await _initDatabase();
    return _database!;
  }

  /// INITIALIZE DATABASE
  /// Creates the database file and tables
  Future<Database> _initDatabase() async {
    // Get database path
    // path package helps with cross-platform paths
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _databaseName);

    // Open/create database
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  /// CREATE TABLES
  /// Called when database is created for first time
  ///
  /// SQL Schema:
  /// - id: Primary key, auto-increment
  /// - title: Text, required
  /// - content: Text, required
  /// - createdAt: Text (ISO8601 datetime)
  /// - updatedAt: Text (ISO8601 datetime)
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableNotes (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnTitle TEXT NOT NULL,
        $columnContent TEXT NOT NULL,
        $columnCreatedAt TEXT NOT NULL,
        $columnUpdatedAt TEXT NOT NULL
      )
    ''');
  }

  /// INSERT NOTE
  /// Adds new note to database
  /// Returns the auto-generated ID
  Future<int> insertNote(Map<String, dynamic> note) async {
    final db = await database;
    return await db.insert(tableNotes, note);
  }

  /// GET ALL NOTES
  /// Returns all notes, newest first
  Future<List<Map<String, dynamic>>> getAllNotes() async {
    final db = await database;
    return await db.query(
      tableNotes,
      orderBy: '$columnCreatedAt DESC', // Newest first
    );
  }

  /// GET NOTE BY ID
  /// Returns single note or null if not found
  Future<Map<String, dynamic>?> getNote(int id) async {
    final db = await database;
    final results = await db.query(
      tableNotes,
      where: '$columnId = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (results.isNotEmpty) {
      return results.first;
    }
    return null;
  }

  /// UPDATE NOTE
  /// Updates existing note
  /// Returns number of rows affected (should be 1)
  Future<int> updateNote(Map<String, dynamic> note) async {
    final db = await database;
    final id = note[columnId];
    return await db.update(
      tableNotes,
      note,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  /// DELETE NOTE
  /// Removes note from database
  /// Returns number of rows deleted (should be 1)
  Future<int> deleteNote(int id) async {
    final db = await database;
    return await db.delete(
      tableNotes,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  /// CLOSE DATABASE
  /// Call when app is shutting down
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
