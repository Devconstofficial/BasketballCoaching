import 'dart:convert';

class Student {
  late String studentId; // New field to store document ID
  late String name;
  late String profile;

  Student({
    required this.studentId,
    required this.name,
    required this.profile,
  });

  Student copyWith({
    String? studentId,
    String? name,
    String? profile,
  }) {
    return Student(
      studentId: studentId ?? this.studentId,
      name: name ?? this.name,
      profile: profile ?? this.profile,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'studentId': studentId,
      'name': name,
      'profile': profile,
    };
  }

  factory Student.fromMap(String studentId, Map<String, dynamic> map) {
    return Student(
      studentId: studentId,
      name: map['name'] as String,
      profile: map['profile'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap('', json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Student(studentId: $studentId, name: $name, profile: $profile)';
  }

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;

    return other.studentId == studentId &&
        other.name == name &&
        other.profile == profile;
  }

  @override
  int get hashCode {
    return studentId.hashCode ^ name.hashCode ^ profile.hashCode;
  }
}
