import 'package:basketball_coaching/Screens/Coach/DrillResults/fielddrill_results.dart';
import 'package:basketball_coaching/Components/back_button.dart';
import 'package:basketball_coaching/Components/barchart.dart';
import 'package:basketball_coaching/Components/drop_down.dart';
import 'package:basketball_coaching/Screens/Coach/Progress/Widgets/performance_comparison.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ViewProgress extends StatefulWidget {
  const ViewProgress({super.key});

  @override
  State<ViewProgress> createState() => _ViewProgressState();
}

class _ViewProgressState extends State<ViewProgress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: Padding(
            padding: EdgeInsets.only(left: 23.w, right: 23.w, top: 60.h),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MyBackButton(),
                    Center(
                      child: Text(
                        'Progress',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32.sp,
                          fontFamily: 'Jua',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 35.w, top: 31.h),
                      child: const Performance(),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Center(
                      child: Text(
                        'Overall Improved 20%',
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
                      height: 27.h,
                    ),
                    Text(
                      'Check selectively',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF89898A),
                        fontSize: 12.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: const DropDown(),
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    Text(
                      'This week progress',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF89898A),
                        fontSize: 12.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    const BarChart(),
                    SizedBox(
                      height: 19.h,
                    ),
                    Center(
                      child: Text(
                        'overall 20%\nimprovement',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32.sp,
                          fontFamily: 'Jua',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 21.h,
                    ),
                    Text(
                      'previous videos',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF89898A),
                        fontSize: 12.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(
                      height: 21.h,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FieldDrill()),
                        );
                      },
                      child: Container(
                        width: 357.w,
                        height: 153.h,
                        decoration: const ShapeDecoration(
                          color: Color(0x7F151517),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FieldDrill()),
                        );
                      },
                      child: Container(
                        width: 357.w,
                        height: 70.h,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFFEFEFE),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )),
                          shadows: [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.w, top: 10.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Close Shot',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/chart.svg',
                                  ),
                                  SizedBox(
                                    width: 7.w,
                                  ),
                                  Text(
                                    'check results of drill here',
                                    style: TextStyle(
                                      color: const Color(0xFFAB7CE6),
                                      fontSize: 14.sp,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    )
                  ]),
            )));
  }
}
