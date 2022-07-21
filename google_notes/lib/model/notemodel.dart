class NotesNames {
  static final String id = "id";
  static final String pin = "pin";
  static final String isArchive = "isArchive";
  static final String title = "title";
  static final String content = "content";
  static final String createdTime = "createdTime";
  static final String TableName = "Notes";
  static final List<String> values = [
    id,
    pin,
    isArchive,
    title,
    content,
    createdTime
  ];
}

class Note {
  final int? id;
  final bool pin;
  final bool isArchive;
  final String title;
  final String content;
  final DateTime createdTime;

  const Note({
    this.id,
    required this.pin,
    required this.isArchive,
    required this.title,
    required this.content,
    required this.createdTime,
  });

  Note copy({
    int? id,
    bool? pin,
    bool? isArchive,
    String? title,
    String? content,
    DateTime? createdTime,
  }) {
    return Note(
      id: id ?? this.id,
      pin: pin ?? this.pin,
      isArchive: isArchive ?? this.isArchive,
      title: title ?? this.title,
      content: content ?? this.content,
      createdTime: createdTime ?? this.createdTime,
    );
  }

  static Note fromJson(Map<String, Object?> json) {
    return Note(
      id: json[NotesNames.id] as int?,
      pin: json[NotesNames.pin] == 1,
      isArchive: json[NotesNames.isArchive] == 1,
      title: json[NotesNames.title] as String,
      content: json[NotesNames.content] as String,
      createdTime: DateTime.parse(json[NotesNames.createdTime] as String),
    );
  }

  Map<String, Object?> toJson() {
    return {
      NotesNames.id: id,
      NotesNames.pin: pin ? 1 : 0,
      NotesNames.isArchive: isArchive ? 1 : 0,
      NotesNames.title: title,
      NotesNames.content: content,
      NotesNames.createdTime: createdTime.toIso8601String(),
    };
  }
}
