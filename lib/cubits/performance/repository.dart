// performance_repository.dart
part of 'cubit.dart';

class PerformanceRepository {
  final PerformanceDataProvider dataProvider = PerformanceDataProvider();

  Future<List<PerformanceRecord>> getPerformanceRecords(String studentId, String drillName) async {
    try {
      return await dataProvider.getPerformanceRecords(studentId, drillName);
    } catch (e) {
      throw Exception("Error fetching performance records: $e");
    }
  }

  Future<void> addPerformanceRecord(String studentId, String drillName, PerformanceRecord record) async {
    try {
      await dataProvider.addPerformanceRecord(studentId, drillName, record);
    } catch (e) {
      throw Exception("Error adding performance record: $e");
    }
  }
}
