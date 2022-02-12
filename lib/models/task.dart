import 'dart:convert';

class Task {
  String title = '';
  String description = '';
  bool status = false;
  Task({
    required this.title,
    required this.description,
    required this.status,
  });

  Task copyWith({
    String? title,
    String? description,
    bool? status,
  }) {
    return Task(
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
      title: map['title'],
      description: map['description'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  @override
  String toString() =>
      'Task(title: $title, description: $description, status: $status)';

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
