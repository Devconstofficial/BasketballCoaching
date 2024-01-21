import 'dart:convert';

class Student {
  late String id;
  late String name;
  late double totalScore;
  late String profile; 

  Student({
    required this.id,
    required this.name,
    required this.totalScore,
    required this.profile,
  });

  Student copyWith({
    String? id,
    String? name,
    double? totalScore,
    String? profile,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      totalScore: totalScore ?? this.totalScore,
      profile: profile ?? this.profile,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'totalScore': totalScore,
      'profile': profile, 
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] as String,
      name: map['name'] as String,
      totalScore: map['totalScore'] as double,
      profile: map['profile'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Student(id: $id, name: $name, totalScore: $totalScore, profile: $profile)';
  }

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.totalScore == totalScore &&
        other.profile == profile;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ totalScore.hashCode ^ profile.hashCode;
  }
}
