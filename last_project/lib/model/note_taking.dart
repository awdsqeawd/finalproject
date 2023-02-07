final String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    id,
    privacy,
    number,
    title,
    category,
    createdTime
  ];

  static final String id = '_id';
  static final String privacy = 'privacy';
  static final String number = 'number';
  static final String title = 'title';
  static final String category = 'category';
  static final String createdTime = 'createdTime';
}

class Note {
  final int? id;
  final bool privacy;
  final int number;
  final String title;
  final String category;
  final DateTime createdTime;

  const Note({
    this.id,
    required this.privacy,
    required this.number,
    required this.title,
    required this.category,
    required this.createdTime,
  });

  Note copy({
    int? id,
    bool? privacy,
    int? number,
    String? title,
    String? category,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        privacy: privacy ?? this.privacy,
        number: number ?? this.number,
        title: title ?? this.title,
        category: category ?? this.category,
        createdTime: createdTime ?? this.createdTime,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        privacy: json[NoteFields.privacy] == 1,
        number: json[NoteFields.number] as int,
        title: json[NoteFields.title] as String,
        category: json[NoteFields.category] as String,
        createdTime: DateTime.parse([NoteFields.createdTime] as String),
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.privacy: privacy ? 1 : 0,
        NoteFields.number: number,
        NoteFields.title: title,
        NoteFields.category: category,
        NoteFields.createdTime: createdTime.toIso8601String(),
      };
}
