class Note {
  String? id;
  String? title;
  String? content;
  DateTime? createdAt;
  DateTime? updateAt;
  List<String> tags;

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updateAt,
    required this.tags
  });

  factory Note.fromFireStore(Map<String, dynamic> doc) {
    return Note(
        id: doc["id"],
        title: doc["title"],
        content: doc["content"],
        createdAt: doc["createdAt"],
        updateAt: doc["updateAt"],
        tags: List<String>.from(doc["tags"] ?? [])
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'created_at': createdAt,
      'updated_at': updateAt,
      'tags': tags,
    };
  }

}