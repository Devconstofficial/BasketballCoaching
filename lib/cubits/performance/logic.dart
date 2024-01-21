// performance_logic.dart
import '../../models/performance.dart';
import 'cubit.dart';

class PerformanceLogic {
  final PerformanceDataProvider dataProvider = PerformanceDataProvider();

  Future<List<int>> getTotalScores(String studentId, String drillName) async {
    try {
      return await dataProvider.getTotalScores(studentId, drillName);
    } catch (e) {
      throw Exception("Error getting total scores: $e");
    }
  }

  Future<List<int>> getLast7DaysTotalNumbers(String studentId, String drillName) async {
    try {
      return await dataProvider.getLast7DaysTotalNumbers(studentId, drillName);
    } catch (e) {
      throw Exception("Error getting last 7 days total numbers: $e");
    }
  }

  Future<Map<String, dynamic>> getImprovementDetails(String studentId, String drillName) async {
    try {
      return await dataProvider.getImprovementDetails(studentId, drillName);
    } catch (e) {
      throw Exception("Error getting improvement details: $e");
    }
  }
}
