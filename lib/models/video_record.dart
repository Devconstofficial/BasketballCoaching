import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class VideoRecord {
  late String file;
  late String? leaderboard;
  late String? type;
  late DateTime date;

  VideoRecord({
    required this.file,
    required this.leaderboard,
    required this.type,
    required this.date,
  });

  VideoRecord copyWith({
    String? file,
    String? leaderboard,
    String? type,
    DateTime? date,
  }) {
    return VideoRecord(
      file: file ?? this.file,
      leaderboard: leaderboard ?? this.leaderboard,
      type: type ?? this.type,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'file': file,
      'leaderboard': leaderboard,
      'type': type,
      'date': date.toUtc(),
    };
  }

  factory VideoRecord.fromMap(Map<String, dynamic> map) {
    return VideoRecord(
      file: map['file'] as String,
      leaderboard: map['leaderboard'] as String,
      type: map['type'] != null ? map['type'] as String : "",
      date: (map['date'] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoRecord.fromJson(String source) =>
      VideoRecord.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VideoRecord(file: $file, leaderboard: $leaderboard, type: $type, date: $date)';
  }

  @override
  bool operator ==(covariant VideoRecord other) {
    if (identical(this, other)) return true;

    return other.file == file &&
        other.leaderboard == leaderboard &&
        other.type == type &&
        other.date == date;
  }

  @override
  int get hashCode {
    return file.hashCode ^ leaderboard.hashCode ^ type.hashCode ^ date.hashCode;
  }
}
