// message_model.dart
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  late String messageId;
  late String senderId;
  late String senderName;
  late String content;
  late String imageUrl;
  late String videoUrl;
  late DateTime time;

  Message({
    required this.messageId,
    required this.senderId,
    required this.senderName,
    required this.content,
    required this.imageUrl,
    required this.videoUrl,
    required this.time,
  });

  Message copyWith({
    String? messageId,
    String? senderId,
    String? senderName,
    String? content,
    String? imageUrl,
    String? videoUrl,
    DateTime? time,
  }) {
    return Message(
      messageId: messageId ?? this.messageId,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messageId': messageId,
      'senderId': senderId,
      'senderName': senderName,
      'content': content,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'time': time.toUtc(),
    };
  }

  factory Message.fromMap(String messageId, Map<String, dynamic> map) {
    return Message(
      messageId: messageId,
      senderId: map['senderId'] as String,
      senderName: map['senderName'] as String,
      content: map['content'] as String,
      imageUrl: map['imageUrl'] as String,
      videoUrl: map['videoUrl'] as String,
      time: (map['time'] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap('', json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(messageId: $messageId, senderId: $senderId, senderName: $senderName, content: $content, imageUrl: $imageUrl, videoUrl: $videoUrl, time: $time)';
  }

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.messageId == messageId &&
        other.senderId == senderId &&
        other.senderName == senderName &&
        other.content == content &&
        other.imageUrl == imageUrl &&
        other.videoUrl == videoUrl &&
        other.time == time;
  }

  @override
  int get hashCode {
    return messageId.hashCode ^
        senderId.hashCode ^
        senderName.hashCode ^
        content.hashCode ^
        imageUrl.hashCode ^
        videoUrl.hashCode ^
        time.hashCode;
  }
}
