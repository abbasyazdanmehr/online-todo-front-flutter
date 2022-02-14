import 'dart:convert';

class Task {
  int id = 0;
  String title = '';
  String description = '';
  bool status = false;
  Task({
    this.id = 0,
    required this.title,
    required this.description,
    required this.status,
  });

  Task copyWith({
    int? id,
    String? title,
    String? description,
    bool? status,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'status': status,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  @override
  String toString() =>
      'Task(id: $id, title: $title, description: $description, status: $status)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Task &&
        other.title == title &&
        other.description == description &&
        other.status == status;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode ^ status.hashCode;
}
