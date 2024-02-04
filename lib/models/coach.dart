import 'package:cloud_firestore/cloud_firestore.dart';

class Coach {
  final String coachId; // Updated to include Firestore document ID
  final String email;
  final String fullName;
  final String teamName;
  final List<String> students;

  Coach({
    required this.coachId,
    required this.email,
    required this.fullName,
    required this.teamName,
    required this.students,
  });

  factory Coach.fromMap(String coachId, Map<String, dynamic> data) {
    return Coach(
      coachId: coachId,
      email: data['email'],
      fullName: data['fullName'],
      teamName: data['teamName'],
      students: List<String>.from(data['students']),
    );
  }
}
