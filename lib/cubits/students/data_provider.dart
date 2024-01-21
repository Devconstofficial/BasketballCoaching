// data_provider.dart
part of 'cubit.dart';

class StudentDataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Student>> getAllStudents() async {
    try {
      final querySnapshot = await _firestore.collection('students').get();
      return querySnapshot.docs.map((doc) => Student.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception("Error fetching students: $e");
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
      await _firestore.collection('students').doc(studentId).update({'profile': newProfile});
    } catch (e) {
      throw Exception("Error updating profile: $e");
    }
  }

  Future<void> updateName(String studentId, String newName) async {
    try {
      await _firestore.collection('students').doc(studentId).update({'name': newName});
    } catch (e) {
      throw Exception("Error updating name: $e");
    }
  }

  Future<void> updateTotalScore(String studentId, double newTotalScore) async {
    try {
      await _firestore.collection('students').doc(studentId).update({'totalScore': newTotalScore});
    } catch (e) {
      throw Exception("Error updating total score: $e");
    }
  }

  Future<Student> createNewStudent() async {
    try {
      String newStudentId = "STD" + DateTime.now().millisecondsSinceEpoch.toString();
      
      Student newStudent = Student(id: newStudentId, name: "", totalScore: 0.0, profile: "");

      await _firestore.collection('students').doc(newStudentId).set(newStudent.toMap());
      return newStudent;
    } catch (e) {
      throw Exception("Error creating new student: $e");
    }
  }
}
