import 'dart:convert';

class Student {
  late String studentId; // New field to store document ID
  late String name;
  late double totalScore;
  late String profile;

  Student({
    required this.studentId,
    required this.name,
    required this.totalScore,
    required this.profile,
  });

  Student copyWith({
    String? studentId,
    String? name,
    double? totalScore,
    String? profile,
  }) {
    return Student(
      studentId: studentId ?? this.studentId,
      name: name ?? this.name,
      totalScore: totalScore ?? this.totalScore,
      profile: profile ?? this.profile,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'studentId': studentId,
      'name': name,
      'totalScore': totalScore,
      'profile': profile,
    };
  }

  factory Student.fromMap(String studentId, Map<String, dynamic> map) {
  return Student(
    studentId: studentId,
    name: map['name'] as String,
    totalScore: (map['totalScore'] as num?)?.toDouble() ?? 0.0,
    profile: map['profile'] as String,
  );
}


  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap('', json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Student(studentId: $studentId, name: $name, totalScore: $totalScore, profile: $profile)';
  }

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;

    return 
        other.studentId == studentId &&
        other.name == name &&
        other.totalScore == totalScore &&
        other.profile == profile;
  }

  @override
  int get hashCode {
    return 
        studentId.hashCode ^
        name.hashCode ^
        totalScore.hashCode ^
        profile.hashCode;
  }
}
