// coach_auth.dart
import 'dart:math';
import 'package:basketball_coaching/models/coach.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CoachAuth {
  String generateCoachRandomId() {
    const String prefix = 'C';
    final String randomDigits =
        (1000000 * Random().nextDouble()).floor().toString().padLeft(6, '0');
    return '$prefix$randomDigits';
  }

  Future<String?> addCoachDocument(
      String email, String fullName, String teamName) async {
    try {
      final String coachId = generateCoachRandomId();
      final CollectionReference coachesCollection =
          FirebaseFirestore.instance.collection('coaches');

      await coachesCollection.doc(coachId).set({
        'email': email,
        'fullName': fullName,
        'teamName': teamName,
        'students': [],
      });

      print('Coach document added with ID: $coachId');
      return coachId;
    } catch (e) {
      print('Error adding coach document: $e');
      return null;
    }
  }

  Future<Coach?> getCoachDataByEmail(String email) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('coaches')
              .where('email', isEqualTo: email)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot<Map<String, dynamic>> coachDocument =
            querySnapshot.docs.first;
        print("\n COACH \n\n ID \n\n ${coachDocument.id}");
        String coachId = coachDocument.id;
        return await getCoachDataByCoachId(coachId);
        // Coach newCoach = Coach(
        //   coachId: coachId,
        //   email: coachDocument['email'],
        //   fullName: coachDocument['fullName'],
        //   teamName: coachDocument['teamName'],
        //   students: coachDocument['students'],
        // );
        // print("NEW COACH \n\n\n HERE \n\n ${newCoach}");
        // return newCoach;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting coach data: $e');
      return null;
    }
  }

  Future<Coach?> getCoachDataByCoachId(String coachId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> coachDocument =
          await FirebaseFirestore.instance
              .collection('coaches')
              .doc(coachId)
              .get();
      print("HERE \n\n IS \n\n THE COACH \n\n ${coachDocument.data()}");
      if (coachDocument.exists) {
        return Coach.fromMap(coachId, coachDocument.data()!);
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting coach data by coachId: $e');
      return null;
    }
  }

  Future<void> updateCoachStudents(String coachId, String studentId) async {
    try {
      final coachDocRef =
          FirebaseFirestore.instance.collection('coaches').doc(coachId);
      final coachDoc = await coachDocRef.get();
      print("COACH DOC \n\n $coachDoc");

      if (coachDoc.exists) {
        List<String> existingStudents =
            List<String>.from(coachDoc.data()?['students'] ?? []);
        if (!existingStudents.contains(studentId)) {
          existingStudents.add(studentId);

          await coachDocRef.update({
            'students': existingStudents,
          });
          print('Coach students updated successfully');
        } else {
          print('Student already exists in the coach\'s list');
        }
      } else {
        print('Coach not found');
      }
    } catch (e) {
      print('Error updating coach students: $e');
    }
  }

  Future<void> deleteStudentFromCoach(String coachId, String studentId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> coachDocument =
          await FirebaseFirestore.instance
              .collection('coaches')
              .doc(coachId)
              .get();

      if (coachDocument.exists) {
        List<String> students =
            List<String>.from(coachDocument.data()?['students']);
        students.remove(studentId);
        await FirebaseFirestore.instance
            .collection('coaches')
            .doc(coachId)
            .update({
          'students': students,
        });
        print('Student $studentId deleted from coach $coachId');
      } else {
        print('Coach with ID $coachId not found');
      }
    } catch (e) {
      print('Error deleting student from coach: $e');
    }
  }
}
