import 'dart:convert';

class VideoRecord {
  late String file;
  late String leaderboard;
  late String type;

  VideoRecord({
    required this.file,
    required this.leaderboard,
    required this.type,
  });

  VideoRecord copyWith({
    String? file,
    String? leaderboard,
    String? type,
  }) {
    return VideoRecord(
      file: file ?? this.file,
      leaderboard: leaderboard ?? this.leaderboard,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'file': file,
      'leaderboard': leaderboard,
      'type': type,
    };
  }

  factory VideoRecord.fromMap(Map<String, dynamic> map) {
    return VideoRecord(
      file: map['file'] as String,
      leaderboard: map['leaderboard'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoRecord.fromJson(String source) =>
      VideoRecord.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VideoRecord(file: $file, leaderboard: $leaderboard, type: $type)';
  }

  @override
  bool operator ==(covariant VideoRecord other) {
    if (identical(this, other)) return true;

    return other.file == file &&
        other.leaderboard == leaderboard &&
        other.type == type;
  }

  @override
  int get hashCode {
    return file.hashCode ^ leaderboard.hashCode ^ type.hashCode;
  }
}
