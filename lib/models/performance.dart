import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PerformanceRecord {
  late DateTime date;
  late String leaderboard;
  late int minutes;
  late int number;
  late List<int> scores;
  late int seconds;
  late int totalScore;
  late String video;

  PerformanceRecord({
    required this.date,
    required this.leaderboard,
    required this.minutes,
    required this.number,
    required this.scores,
    required this.seconds,
    required this.totalScore,
    required this.video,
  });

  PerformanceRecord copyWith({
    DateTime? date,
    String? leaderboard,
    int? minutes,
    int? number,
    List<int>? scores,
    int? seconds,
    int? totalScore,
    String? video,
  }) {
    return PerformanceRecord(
      date: date ?? this.date,
      leaderboard: leaderboard ?? this.leaderboard,
      minutes: minutes ?? this.minutes,
      number: number ?? this.number,
      scores: scores ?? this.scores,
      seconds: seconds ?? this.seconds,
      totalScore: totalScore ?? this.totalScore,
      video: video ?? this.video,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.toUtc(),
      'leaderboard': leaderboard,
      'minutes': minutes,
      'number': number,
      'scores': scores,
      'seconds': seconds,
      'totalScore': totalScore,
      'video': video,
    };
  }

  factory PerformanceRecord.fromMap(Map<String, dynamic> map) {
    return PerformanceRecord(
      date: (map['date'] as Timestamp).toDate(),
      leaderboard: map['leaderboard'] ?? '',
      minutes: map['minutes'] ?? 0,
      number: map['number'] ?? 0,
      scores: List<int>.from(map['scores'] ?? []),
      seconds: map['seconds'] ?? 0,
      totalScore: map['totalScore'] ?? 0,
      video: map['video'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PerformanceRecord.fromJson(String source) =>
      PerformanceRecord.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PerformanceRecord(date: $date, leaderboard: $leaderboard, minutes: $minutes, '
        'number: $number, scores: $scores, seconds: $seconds, totalScore: $totalScore, video: $video)';
  }

  @override
  bool operator ==(covariant PerformanceRecord other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.leaderboard == leaderboard &&
        other.minutes == minutes &&
        other.number == number &&
        const ListEquality<int>().equals(other.scores, scores) &&
        other.seconds == seconds &&
        other.totalScore == totalScore &&
        other.video == video;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        leaderboard.hashCode ^
        minutes.hashCode ^
        number.hashCode ^
        scores.hashCode ^
        seconds.hashCode ^
        totalScore.hashCode ^
        video.hashCode;
  }
}
