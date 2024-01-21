part of 'cubit.dart';

class PerformanceDataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<PerformanceRecord>> getPerformanceRecords(String studentId, String drillName) async {
    try {
      final querySnapshot = await _firestore.collection('students/$studentId/performance/$drillName').get();
      return querySnapshot.docs.map((doc) => PerformanceRecord.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception("Error fetching performance records: $e");
    }
  }

  Future<void> addPerformanceRecord(String studentId, String drillName, PerformanceRecord record) async {
  try {
    final String yearMonthKey = "${record.date.year}-${record.date.month.toString().padLeft(2, '0')}";
    final DocumentReference drillRef = _firestore.doc('students/$studentId/performance/$drillName');
    final drillDocSnapshot = await drillRef.get();

    if (!drillDocSnapshot.exists) {
      await drillRef.set({});
    }

    await drillRef.set(
      {yearMonthKey: FieldValue.arrayUnion([record.toMap()])},
      SetOptions(merge: true),
    );
  } catch (e) {
    throw Exception("Error adding performance record: $e");
  }
}


  Future<List<int>> getTotalScores(String studentId, String drillName) async {
    try {
      final querySnapshot = await _firestore.collection('students/$studentId/performance/$drillName').get();
      final List<int> totalScores = [];

      for (final doc in querySnapshot.docs) {
        final monthData = doc.data() as Map<String, dynamic>;
        final totalScore = monthData.entries
            .where((entry) => entry.value is List)
            .map((entry) =>
                (entry.value as List).fold(0, (sum, record) => sum + (record['totalScore'] as int? ?? 0)))
            .fold(0, (sum, score) => sum + score);
        totalScores.add(totalScore);
      }

      return totalScores;
    } catch (e) {
      throw Exception("Error getting total scores: $e");
    }
  }

  Future<List<int>> getLast7DaysTotalNumbers(String studentId, String drillName) async {
    try {
      final now = DateTime.now();
      final DateTime last7DaysStart = now.subtract(Duration(days: 7));

      final querySnapshot = await _firestore
          .collection('students/$studentId/performance/$drillName')
          .where('date', isGreaterThanOrEqualTo: last7DaysStart)
          .get();

      final Map<String, int> totalNumbers = {};

      for (final doc in querySnapshot.docs) {
        final date = (doc['date'] as Timestamp).toDate();
        final dateString = "${date.year}-${date.month}-${date.day}";
        totalNumbers.update(dateString, (value) => value + (doc['number'] as int? ?? 0), ifAbsent: () => 0);
      }

      final List<int> last7DaysTotalNumbers = totalNumbers.values.toList();
      return last7DaysTotalNumbers;
    } catch (e) {
      throw Exception("Error getting last 7 days total numbers: $e");
    }
  }

  Future<Map<String, dynamic>> getImprovementDetails(String studentId, String drillName) async {
    try {
      final now = DateTime.now();
      final String currentMonthKey = "${now.year}-${now.month.toString().padLeft(2, '0')}";
      final DateTime lastMonthStart = DateTime(now.year, now.month - 1, now.day);

      final querySnapshot = await _firestore
          .collection('students/$studentId/performance/$drillName')
          .where('date', isGreaterThanOrEqualTo: lastMonthStart)
          .get();

      int currentMonthTotalDrills = 0;
      int currentMonthTotalScore = 0;

      int lastMonthTotalDrills = 0;
      int lastMonthTotalScore = 0;

      for (final doc in querySnapshot.docs) {
        final date = (doc['date'] as Timestamp).toDate();
        final dateString = "${date.year}-${date.month}-${date.day}";
        final number = doc['number'] as int? ?? 0;
        final totalScore = doc['totalScore'] as int? ?? 0;

        if (date.isAfter(lastMonthStart)) {
          currentMonthTotalDrills += number;
          currentMonthTotalScore += totalScore;
        } else {
          lastMonthTotalDrills += number;
          lastMonthTotalScore += totalScore;
        }
      }

      final int improvementPercentage = ((currentMonthTotalDrills - lastMonthTotalDrills) / lastMonthTotalDrills * 100).toInt();

      final Map<String, dynamic> improvementDetails = {
        'currentMonthTotalDrills': currentMonthTotalDrills,
        'currentMonthTotalScore': currentMonthTotalScore,
        'lastMonthTotalDrills': lastMonthTotalDrills,
        'lastMonthTotalScore': lastMonthTotalScore,
        'improvementPercentage': improvementPercentage,
      };

      return improvementDetails;
    } catch (e) {
      throw Exception("Error getting improvement details: $e");
    }
  }

  // Other data provider methods...
}
