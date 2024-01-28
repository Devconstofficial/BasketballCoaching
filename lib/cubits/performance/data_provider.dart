part of 'cubit.dart';

class PerformanceDataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<PerformanceRecord>> getPerformanceRecords(
      String studentId, String drillName) async {
    try {
      final querySnapshot = await _firestore
          .collection('students/$studentId/performance/$drillName')
          .get();
      return querySnapshot.docs
          .map((doc) =>
              PerformanceRecord.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
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
      var videoUrl = "";
      PerformanceRecord record;

      if (videoFile != null && videoFile.path.isNotEmpty) {
        videoUrl = await uploadVideo(videoFile, fileName);
        VideoCubit videoCubit = VideoCubit();
        VideoRecord videoRecord = VideoRecord(
          file: videoUrl,
          leaderboard: leaderboard,
          type: selectedDrill,
          date: DateTime.now(),
        );
        videoCubit.uploadVideo(videoRecord, studentId);
      }

      record = PerformanceRecord(
        date: DateTime.now(),
        leaderboard: leaderboard,
        minutes: selectedMinutes,
        seconds: selectedSeconds,
        number: number,
        totalScore: 0,
        video: videoUrl,
        scores: scores,
      );

      final String yearMonthKey =
          "${record.date.year}-${record.date.month.toString().padLeft(2, '0')}";

      final DocumentReference drillRef =
          _firestore.doc('students/$studentId/performance/$selectedDrill');

      final drillDocSnapshot = await drillRef.get();
      if (!drillDocSnapshot.exists) {
        await drillRef.set({});
      }

      await drillRef.set(
        {
          yearMonthKey: FieldValue.arrayUnion([record.toMap()])
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      throw Exception("Error adding performance record: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getTotalOfDrillDataByMonth(
      String studentId, String drillName) async {
    try {
      final querySnapshot = await _firestore
          .collection('students/$studentId/performance/$drillName')
          .get();

      final List<Map<String, dynamic>> monthlyScores = [];

      for (final doc in querySnapshot.docs) {
        final monthData = doc.data() as Map<String, dynamic>;
        final month =
            DateFormat('MMM').format(monthData['date'].toDate()).toLowerCase();

        final totalScore = monthData.entries
            .where((entry) => entry.value is List)
            .map((entry) => (entry.value as List).fold(
                0, (sum, record) => sum + (record['totalScore'] as int? ?? 0)))
            .fold(0, (sum, score) => sum + score);

        final totalNumber = monthData.entries
            .where((entry) => entry.value is List)
            .map((entry) => (entry.value as List).fold(
                0, (sum, record) => sum + (record['number'] as int? ?? 0)))
            .fold(0, (sum, number) => sum + number);

        monthlyScores.add({
          'month': month,
          'totalScore': totalScore,
          'totalNumber': totalNumber,
        });
      }

      return monthlyScores;
    } catch (e) {
      throw Exception("Error getting total scores: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getAllDrillsTotalResultsByMonth(
    String studentId,
  ) async {
    try {
      final querySnapshot =
          await _firestore.collection('students/$studentId/performance').get();

      final Map<String, Map<String, dynamic>> monthlyScores = {};

      for (final doc in querySnapshot.docs) {
        final drillData = doc.data() as Map<String, dynamic>;

        for (final MapEntry<String, dynamic> monthDataEntry
            in drillData.entries) {
          final monthData = monthDataEntry.value;

          if (monthData is List<dynamic>) {
            // Handle the case where monthData is a list of maps
            for (final drillEntry in monthData) {
              if (drillEntry is Map<String, dynamic>) {
                final date = drillEntry['date'];

                if (date != null) {
                  final month = DateFormat('MMM')
                      .format(date.toDate()) // Assuming 'date' is a Timestamp
                      .toLowerCase();

                  final totalScore = (drillEntry['scores'] as List)
                      .map((score) => score as int? ?? 0)
                      .fold(0, (sum, score) => sum + score);

                  final totalNumber = drillEntry['number'] as int? ?? 0;

                  if (monthlyScores.containsKey(month)) {
                    monthlyScores[month]!['totalScore'] += totalScore;
                    monthlyScores[month]!['totalNumber'] += totalNumber;
                  } else {
                    monthlyScores[month] = {
                      'month': month,
                      'totalScore': totalScore,
                      'totalNumber': totalNumber,
                    };
                  }
                }
              }
            }
          } else if (monthData is Map<String, dynamic>) {
            final date = monthData['date'];

            if (date != null) {
              final month = DateFormat('MMM')
                  .format(date.toDate()) // Assuming 'date' is a Timestamp
                  .toLowerCase();

              final totalScore = (monthData['scores'] as List)
                  .map((score) => score as int? ?? 0)
                  .fold(0, (sum, score) => sum + score);

              final totalNumber = monthData['number'] as int? ?? 0;

              if (monthlyScores.containsKey(month)) {
                monthlyScores[month]!['totalScore'] += totalScore;
                monthlyScores[month]!['totalNumber'] += totalNumber;
              } else {
                monthlyScores[month] = {
                  'month': month,
                  'totalScore': totalScore,
                  'totalNumber': totalNumber,
                };
              }
            }
          }
        }
      }

      return monthlyScores.values.toList();
    } catch (e) {
      throw Exception("Error getting total scores: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getLast7DaysTotalNumbers(
      String studentId, String drillName) async {
    try {
      print("enter method");
      final now = DateTime.now();
      final DateTime last7DaysStart = now.subtract(Duration(days: 7));

      final currentYearMonth =
          '${now.year}-${now.month.toString().padLeft(2, '0')}';

      final querySnapshot = await _firestore
          .collection('students')
          .doc(studentId)
          .collection('performance')
          .doc(drillName)
          .get();
      print("got path");

      final List<Map<String, dynamic>> last7DaysTotalNumbers = [];

      // Check if the document with the specified drill name exists
      if (querySnapshot.exists) {
        final drillData = querySnapshot.data();
        print(drillData);

        // Check if the current year-month is present in the document data
        if (drillData?.containsKey(currentYearMonth) ?? false) {
          final drillDataList = drillData?[currentYearMonth] as List?;

          // Check if drillDataList is a List
          if (drillDataList is List) {
            for (final Map<String, dynamic>? doc in drillDataList) {
              print("entered loop");

              final date = (doc?['date'] as Timestamp?)?.toDate();

              // Check if date is within the last 7 days
              if (date != null && date.isAfter(last7DaysStart)) {
                final dateString = "${date.year}-${date.month}-${date.day}";
                final dayOfWeek = _getWeekDay(date);

                final existingEntry = last7DaysTotalNumbers.firstWhere(
                  (entry) => entry['day'] == dayOfWeek,
                  orElse: () => {'height': 0, 'day': dayOfWeek},
                );

                if (existingEntry.containsKey('height')) {
                  existingEntry['height'] += (doc?['number'] as int? ?? 0);
                } else {
                  existingEntry['height'] = (doc?['number'] as int? ?? 0);
                }

                if (!last7DaysTotalNumbers.contains(existingEntry)) {
                  last7DaysTotalNumbers.add(existingEntry);
                }
              }
            }
          }
        }
      }

      // Ensure that there is an entry for each day in the last 7 days
      final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      for (final weekday in weekdays) {
        if (last7DaysTotalNumbers.every((entry) => entry['day'] != weekday)) {
          last7DaysTotalNumbers.add({'height': 0, 'day': weekday});
        }
      }

      // Sort the result by day of the week
      last7DaysTotalNumbers.sort((a, b) =>
          weekdays.indexOf(a['day'] as String) -
          weekdays.indexOf(b['day'] as String));

      print(last7DaysTotalNumbers);
      return last7DaysTotalNumbers;
    } catch (e) {
      print("Error getting last 7 days total numbers: $e");
      throw Exception("Error getting last 7 days total numbers: $e");
    }
  }

  String _getWeekDay(DateTime date) {
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[date.weekday - 1];
  }

  Future<Map<String, dynamic>> getImprovementDetails(
      String studentId, String drillName) async {
    try {
      final now = DateTime.now();
      final String currentMonthKey =
          "${now.year}-${now.month.toString().padLeft(2, '0')}";
      final DateTime lastMonthStart =
          DateTime(now.year, now.month - 1, now.day);

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

      final int improvementPercentage =
          ((currentMonthTotalDrills - lastMonthTotalDrills) /
                  lastMonthTotalDrills *
                  100)
              .toInt();

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
