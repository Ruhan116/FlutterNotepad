/// NOTE MODEL (Domain Layer)
///
/// This is our core business entity - represents a Note
/// Clean Architecture principle: Domain layer has NO dependencies
/// - No Flutter imports
/// - No database imports
/// - Pure Dart class
///
/// Why immutable (final fields)?
/// - Predictable state
/// - Thread-safe
/// - Easy to reason about

class Note {
  final int? id; // Nullable because new notes don't have ID yet
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Note({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  /// FROM MAP - Convert database row to Note object
  /// Used when reading from SQLite
  ///
  /// Example database row:
  /// {
  ///   'id': 1,
  ///   'title': 'My Note',
  ///   'content': 'Hello world',
  ///   'createdAt': '2024-01-01 10:00:00',
  ///   'updatedAt': '2024-01-01 10:00:00'
  /// }
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int?,
      title: map['title'] as String,
      content: map['content'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }

  /// TO MAP - Convert Note object to database row
  /// Used when writing to SQLite
  ///
  /// Returns a Map that SQLite can insert/update
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// COPY WITH - Create modified copy
  /// Useful for updates: note.copyWith(title: 'New Title')
  Note copyWith({
    int? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'Note(id: $id, title: $title, createdAt: $createdAt)';
  }
}
