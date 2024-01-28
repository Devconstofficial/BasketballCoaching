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

  Future<List<Student>> getAllStudents() async {
    try {
      final querySnapshot = await _firestore.collection('students').get();
      List data = querySnapshot.docs;
      List<Student> students = List.generate(
        data.length,
        (index) => Student.fromMap(
          data[index].id,
          data[index].data(),
        ),
      );
      return students;
    } catch (e) {
      print("Error fetching students: $e");
      return [];
    }
  }

  Future<void> deleteStudent(String studentId) async {
    try {
      await _firestore.collection('students').doc(studentId).delete();
    } catch (e) {
      throw Exception("Error deleting student: $e");
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
      Student newStudent =
          Student(studentId: studentId, name: name, totalScore: 0, profile: "");
      final CollectionReference studentsCollection =
          FirebaseFirestore.instance.collection('students');
      await _firestore
          .collection('students')
          .doc(studentId)
          .set(newStudent.toMap());
      await studentsCollection.doc(studentId).collection('performance').add({});
      addStudentToCoach(coachId, studentId);
      return newStudent;
    } catch (e) {
      throw Exception("Error creating new student: $e");
    }
  }

  Future<void> addStudentToCoach(String coachId, String studentId) async {
    final DocumentReference coachDocRef =
        FirebaseFirestore.instance.collection('coaches').doc(coachId);

    await coachDocRef.update({
      'students': FieldValue.arrayUnion(
          [FirebaseFirestore.instance.doc('students/$studentId')]),
    });

    print('Student added to coach\'s document');
  }
}
