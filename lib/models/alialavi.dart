import 'dart:convert';

class Ali {
  String username = '';
  int age = 0;
  String field = '';
  Ali({
    required this.username,
    required this.age,
    required this.field,
  });
  // ...

  Ali copyWith({
    String? username,
    int? age,
    String? field,
  }) {
    return Ali(
      username: username ?? this.username,
      age: age ?? this.age,
      field: field ?? this.field,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'age': age,
      'field': field,
    };
  }

  factory Ali.fromMap(Map<String, dynamic> map) {
    return Ali(
      username: map['username'],
      age: map['age'],
      field: map['field'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Ali.fromJson(String source) => Ali.fromMap(json.decode(source));

  @override
  String toString() => 'Ali(username: $username, age: $age, field: $field)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Ali &&
        other.username == username &&
        other.age == age &&
        other.field == field;
  }

  @override
  int get hashCode => username.hashCode ^ age.hashCode ^ field.hashCode;
}
