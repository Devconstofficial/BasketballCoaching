// data_provider.dart
part of 'cubit.dart';

class StudentDataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String generateStudentRandomId() {
    const String prefix = 'STD';
    final String randomDigits =
        (1000000 * Random().nextDouble()).floor().toString().padLeft(6, '0');
    return '$prefix$randomDigits';
  }

  // Future<List<Student>> getAllStudents() async {
  //   try {
  //     final querySnapshot = await _firestore.collection('students').get();
  //     List data = querySnapshot.docs;
  //     List<Student> students = List.generate(
  //       data.length,
  //       (index) => Student.fromMap(
  //         data[index].id,
  //         data[index].data(),
  //       ),
  //     );
  //     return students;
  //   } catch (e) {
  //     print("Error fetching students: $e");
  //     return [];
  //   }
  // }
  Future<List<Student>> getAllStudents() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('user_id');
      print("coach id \n\n\n $userId");
      Coach? coach = await CoachAuth().getCoachDataByCoachId(userId!);
      print("COACH \n\n ${coach!.coachId}");

      final querySnapshot = await _firestore.collection('students').get();
      List data = querySnapshot.docs;
      print("STUDENTS \n\n\n ${data}");
      if (coach.students != [] || coach.students.isNotEmpty) {
        List<String> coachStudents = coach.students;
        print("COACH STUDENTS\n\n $coachStudents");
        List<Student> students = data
            .map((doc) => Student.fromMap(doc.id, doc.data()))
            .where((student) => coachStudents.contains(student.studentId))
            .toList();
        print("COACH Students\n\n\n $students");

        return students;
      }
      return [];
    } catch (e) {
      print("Error fetching students: $e");
      return [];
    }
  }

  Future<Student?> getStudentById(String studentId) async {
    try {
      final DocumentSnapshot document =
          await _firestore.collection('students').doc(studentId).get();

      if (document.exists) {
        return Student.fromMap(
            studentId, document.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching student: $e");
      return null;
    }
  }

  Future<void> deleteStudent(String studentId) async {
    try {
      await _firestore.collection('students').doc(studentId).delete();
    } catch (e) {
      throw Exception("Error deleting student: $e");
    }
  }

  Future<void> removeStudentFromCoach(String studentId) async {
    try {
      final coachesQuerySnapshot =
          await FirebaseFirestore.instance.collection('coaches').get();

      for (final coachDoc in coachesQuerySnapshot.docs) {
        final coachId = coachDoc.id;
        await FirebaseFirestore.instance
            .collection('coaches')
            .doc(coachId)
            .update({
          'students': FieldValue.arrayRemove(
              [FirebaseFirestore.instance.doc('students/$studentId')])
        });
      }
    } catch (e) {
      print("Error removing student from coach: $e");
    }
  }

  Future<void> updateProfile(String studentId, String newProfile) async {
    try {
      await _firestore
          .collection('students')
          .doc(studentId)
          .update({'profile': newProfile});
    } catch (e) {
      throw Exception("Error updating profile: $e");
    }
  }

  Future<void> updateName(String studentId, String newName) async {
    try {
      await _firestore
          .collection('students')
          .doc(studentId)
          .update({'name': newName});
    } catch (e) {
      throw Exception("Error updating name: $e");
    }
  }

  Future<void> updateTotalScore(String studentId, double newTotalScore) async {
    try {
      await _firestore
          .collection('students')
          .doc(studentId)
          .update({'totalScore': newTotalScore});
    } catch (e) {
      throw Exception("Error updating total score: $e");
    }
  }

  Future<Student> createNewStudent(String name, String coachId) async {
    try {
      final String studentId = generateStudentRandomId();
      Student newStudent = Student(
          studentId: studentId, name: name, profile: "avatars/avatar2.png");
      final CollectionReference studentsCollection =
          FirebaseFirestore.instance.collection('students');
      await _firestore
          .collection('students')
          .doc(studentId)
          .set(newStudent.toMap());
      await studentsCollection
          .doc(studentId)
          .collection('performance')
          .doc("cone")
          .set({});
      await studentsCollection
          .doc(studentId)
          .collection('performance')
          .doc("pull up")
          .set({});
      await studentsCollection
          .doc(studentId)
          .collection('performance')
          .doc("bank shot")
          .set({});
      await studentsCollection
          .doc(studentId)
          .collection('performance')
          .doc("close shot")
          .set({});
      await studentsCollection
          .doc(studentId)
          .collection('performance')
          .doc("3-drill")
          .set({});
      await updateCoachStudents(coachId, studentId);
      return newStudent;
    } catch (e) {
      throw Exception("Error creating new student: $e");
    }
  }

  // Future<void> addStudentToCoach(String coachId, String studentId) async {
  //   final DocumentReference coachDocRef =
  //       FirebaseFirestore.instance.collection('coaches').doc(coachId);

  //   await coachDocRef.update({
  //     'students': FieldValue.arrayUnion(
  //         [FirebaseFirestore.instance.doc('students/$studentId')]),
  //   });

  //   print('Student added to coach\'s document');
  // }
  Future<void> updateCoachStudents(String coachId, String studentId) async {
    try {
      final coachDocRef =
          FirebaseFirestore.instance.collection('coaches').doc(coachId);
      final coachDoc = await coachDocRef.get();
      print("COACH FIREBASE DATA \n ${coachDoc.data()}");

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
}
