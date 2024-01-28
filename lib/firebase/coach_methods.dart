import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class CoachAuth {
  String generateCoachRandomId() {
    const String prefix = 'C';
    final String randomDigits =
        (1000000 * Random().nextDouble()).floor().toString().padLeft(6, '0');
    return '$prefix$randomDigits';
  }

  Future<String> addCoachDocument(
      String email, String fullName, String teamName) async {
    final CollectionReference coachesCollection =
        FirebaseFirestore.instance.collection('coaches');
    final String coachId = generateCoachRandomId();

    await coachesCollection.doc(coachId).set({
      'email': email,
      'fullName': fullName,
      'teamName': teamName,
      'students': [],
    });

    print('Coach document added with ID: $coachId');
    return coachId;
  }

  Future<Map<String, dynamic>?> getCoachDataByEmail(String email) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('coaches')
            .where('email', isEqualTo: email)
            .get();

    if (querySnapshot.docs.isNotEmpty) {
      final DocumentSnapshot<Map<String, dynamic>> coachDocument =
          querySnapshot.docs.first;
      return coachDocument.data();
    } else {
      return null;
    }
  }
}
