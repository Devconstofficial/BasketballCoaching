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
      print("HERE \n\n IS \n\n THE COACH \n\n ${coachDocument}");
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
}
