// performance_repository.dart
part of 'cubit.dart';

class PerformanceRepository {
  final PerformanceDataProvider dataProvider = PerformanceDataProvider();

  Future<List<PerformanceRecord>> getPerformanceRecords(
      String studentId, String drillName) async {
    try {
      return await dataProvider.getPerformanceRecords(studentId, drillName);
    } catch (e) {
      throw Exception("Error fetching performance records: $e");
    }
  }

  Future<void> addPerformanceRecord(
    String studentId,
    File videoFile,
    String fileName,
    int selectedMinutes,
    int selectedSeconds,
    String selectedDrill,
    String leaderboard,
    int number,
    List<int> scores,
  ) async {
    try {
      await dataProvider.addPerformanceRecord(
          studentId,
          videoFile,
          fileName,
          selectedMinutes,
          selectedSeconds,
          selectedDrill,
          leaderboard,
          number,
          scores);
    } catch (e) {
      throw Exception("Error adding performance record: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getLast7DaysTotalNumbers(
      String studentId, String drillName) async {
    try {
      return await dataProvider.getLast7DaysTotalNumbers(studentId, drillName);
    } catch (e) {
      throw Exception("Error getting last 7 days total numbers: $e");
    }
  }
}
