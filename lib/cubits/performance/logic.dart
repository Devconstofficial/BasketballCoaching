// performance_logic.dart
import 'cubit.dart';

class PerformanceLogic {
  final PerformanceDataProvider dataProvider = PerformanceDataProvider();

  Future<List<Map<String, dynamic>>> getTotalOfDrillDataByMonth(
      String studentId, String drillName) async {
    try {
      return await dataProvider.getTotalOfDrillDataByMonth(
          studentId, drillName);
    } catch (e) {
      throw Exception("Error getting total scores: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getAllDrillsTotalResultsByMonth(
      String studentId) async {
    try {
      return await dataProvider.getAllDrillsTotalResultsByMonth(studentId);
    } catch (e) {
      throw Exception("Error getting improvement details: $e");
    }
  }

  Future<Map<String, dynamic>> getImprovementDetails(
      String studentId, String drillName) async {
    try {
      return await dataProvider.getImprovementDetails(studentId, drillName);
    } catch (e) {
      throw Exception("Error getting improvement details: $e");
    }
  }
}
