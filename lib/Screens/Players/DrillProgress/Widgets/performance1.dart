import 'package:basketball_coaching/Components/my_snackbar.dart';
import 'package:basketball_coaching/Screens/Players/DrillProgress/Widgets/bad_score_images.dart';
import 'package:basketball_coaching/Screens/Players/DrillProgress/Widgets/good_score_images.dart';
import 'package:basketball_coaching/cubits/performance/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'month1_dropdown.dart';
import 'month2_dropdown.dart';

class PerformanceStudent extends StatefulWidget {
  final String studentId;
  final String? drillName;
  const PerformanceStudent({
    super.key,
    this.drillName,
    required this.studentId,
  });

  @override
  State<PerformanceStudent> createState() => _PerformanceState();
}

class _PerformanceState extends State<PerformanceStudent> {
  List<String> months = [
    'jan',
    'feb',
    'mar',
    'apr',
    'may',
    'jun',
    'jul',
    'aug',
    'sep',
    'oct',
    'nov',
    'dec',
  ];
  String selectedPreviousMonth = "";
  String selectedCurrentMonth = "";

  List<Map<String, dynamic>> monthResultsOfAllDrills = [];
  int month1Score = 0;
  int month1Drills = 0;

  int month2Score = 0;
  int month2Drills = 0;

  @override
  void initState() {
    super.initState();
    selectedPreviousMonth = _getPreviousMonth();
    selectedCurrentMonth = _getCurrentMonth();

    fetchDrillsResultsByMonth();
    calculateImprovementPercentage();
  }

  void updateMonth1Result(String selectedMonth) {
    if (monthResultsOfAllDrills.isNotEmpty) {
      Map<String, dynamic>? targetResult = monthResultsOfAllDrills
          .where((result) => result['month'] == selectedMonth)
          .firstOrNull;

      setState(() {
        month1Drills = targetResult?['totalNumber'] ?? 0;
        month1Score = targetResult?['totalScore'] ?? 0;
      });

      if (targetResult == null) {
        SnackBarHelper.showSnackbar(context, "No results for $selectedMonth");
      }
    }
  }

  void updateMonth2Result(String selectedMonth) {
    if (monthResultsOfAllDrills.isNotEmpty) {
      Map<String, dynamic>? targetResult = monthResultsOfAllDrills
          .where((result) => result['month'] == selectedMonth)
          .firstOrNull;

      setState(() {
        month2Drills = targetResult?['totalNumber'] ?? 0;
        month2Score = targetResult?['totalScore'] ?? 0;
      });

      if (targetResult == null) {
        SnackBarHelper.showSnackbar(context, "No results for $selectedMonth");
      }
    }
  }

  String _getPreviousMonth() {
    final now = DateTime.now();
    final lastMonth = DateTime(now.year, now.month - 1, now.day);
    return DateFormat('MMM').format(lastMonth).toLowerCase();
  }

  String _getCurrentMonth() {
    final now = DateTime.now();
    final currentMonth = DateTime(now.year, now.month, now.day);
    return DateFormat('MMM').format(currentMonth).toLowerCase();
  }

  Future<void> fetchDrillsResultsByMonth() async {
    try {
      String studentId = widget.studentId;

      List<Map<String, dynamic>> results =
          await PerformanceLogic().getAllDrillsTotalResultsByMonth(studentId);

      for (var result in results) {
        monthResultsOfAllDrills.add({
          'month': result['month'],
          'totalScore': result['totalScore'],
          'totalNumber': result['totalNumber'],
        });
      }

      updateMonth1Result(selectedPreviousMonth);
      updateMonth2Result(selectedCurrentMonth);
    } catch (e) {
      print('Error fetching Drills Result: $e');
    }
  }

  double calculateImprovementPercentage() {
    if (month1Drills <= month2Drills) {
      return ((month2Drills - month1Drills) / month2Drills) * 100;
    } else if (month1Drills == month2Drills) {
      return 0.0;
    } else {
      return (-(month1Drills - month2Drills) / month1Drills) * 100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  width: 94.w,
                  height: 94.h,
                  decoration: const ShapeDecoration(
                    color: Color(0xFFAB7CE6),
                    shape: OvalBorder(),
                  ),
                  child: PreviousMonthDropDown(
                    options: months,
                    onOptionSelected: (value) {
                      setState(() {
                        selectedPreviousMonth = value!;
                        updateMonth1Result(selectedPreviousMonth);
                      });
                    },
                    selectedOption: selectedPreviousMonth,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  '$month1Drills drills',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  '$month1Score field score',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                )
              ],
            ),
            SizedBox(
              width: 18.w,
            ),
            Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'vs',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32.sp,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                )
              ],
            ),
            SizedBox(
              width: 18.w,
            ),
            Column(
              children: [
                Container(
                  width: 94.w,
                  height: 94.h,
                  decoration: const ShapeDecoration(
                    color: Color(0xFFAB7CE6),
                    shape: OvalBorder(),
                  ),
                  child: CurrentMonthDropDown(
                    options: months,
                    onOptionSelected: (value) {
                      setState(() {
                        selectedCurrentMonth = value!;
                        updateMonth2Result(selectedCurrentMonth);
                      });
                    },
                    selectedOption: selectedCurrentMonth,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  '$month2Drills drills',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  '$month2Score field score',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 15.h,
        ),
        month1Drills == month2Drills
            ? const SizedBox()
            : month1Drills > month2Drills
                ? const BadScore()
                : const GoodScore(),
        SizedBox(
          height: 8.h,
        ),
        Center(
          child: calculateImprovementPercentage() == 0
              ? Text(
                  'No Change',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFAB7CE6),
                    fontSize: 20.sp,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                )
              : calculateImprovementPercentage() > 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/imp2.png',
                        ),
                        Text(
                          'Improved ${calculateImprovementPercentage().abs().toStringAsFixed(2) == 'NaN' ? 0 : calculateImprovementPercentage().abs().toStringAsFixed(2)}%',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFFAB7CE6),
                            fontSize: 20.sp,
                            fontFamily: 'Jua',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        Image.asset(
                          'assets/images/imp1.png',
                        ),
                      ],
                    )
                  : Text(
                      'Declined ${calculateImprovementPercentage().abs().toStringAsFixed(2) == 'NaN' ? 0 : calculateImprovementPercentage().abs().toStringAsFixed(2)}%',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFFAB7CE6),
                        fontSize: 20.sp,
                        fontFamily: 'Jua',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
        ),
        SizedBox(
          height: 15.h,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "This year results",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: const Color(0xFF89898A),
                fontSize: 12.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Month')),
                  DataColumn(label: Text('Total Score')),
                  DataColumn(label: Text('Total Number')),
                ],
                rows: monthResultsOfAllDrills.map((result) {
                  return DataRow(cells: [
                    DataCell(Text(result['month'])),
                    DataCell(Text(result['totalScore'].toString())),
                    DataCell(Text(result['totalNumber'].toString())),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
