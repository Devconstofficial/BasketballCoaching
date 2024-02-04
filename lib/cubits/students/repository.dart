// repository.dart
part of 'cubit.dart';

class StudentRepository {
  final StudentDataProvider dataProvider = StudentDataProvider();

  Future<List<Student>> getAllStudents() async {
    try {
      print('Inside repo');
      return await dataProvider.getAllStudents();
    } catch (e) {
      throw Exception("Error fetching students: $e");
    }
  }

  Future<Student?> getStudentById(String studentId) async {
    try {
      return await dataProvider.getStudentById(studentId);
    } catch (e) {
      throw Exception("Error fetching Student: $e");
    }
  }

  Future<void> deleteStudent(String studentId) async {
    try {
      await dataProvider.deleteStudent(studentId);
    } catch (e) {
      throw Exception("Error deleting student: $e");
    }
  }

  Future<void> removeStudentFromCoach(String studentId) async {
    try {
      await dataProvider.removeStudentFromCoach(studentId);
    } catch (e) {
      throw Exception("Error deleting student: $e");
    }
  }

  Future<void> updateProfile(String studentId, String newProfile) async {
    try {
      await dataProvider.updateProfile(studentId, newProfile);
    } catch (e) {
      throw Exception("Error updating profile: $e");
    }
  }

  Future<void> updateTotalScore(String studentId, double newTotalScore) async {
    try {
      await dataProvider.updateTotalScore(studentId, newTotalScore);
    } catch (e) {
      throw Exception("Error updating total score: $e");
    }
  }

  Future<Student> createNewStudent(String name, String coachId) async {
    try {
      return await dataProvider.createNewStudent(name, coachId);
    } catch (e) {
      throw Exception("Error creating new student: $e");
    }
  }
}
