import 'package:basketball_coaching/Components/back_button.dart';
import 'package:basketball_coaching/Components/barchart.dart';
import 'package:basketball_coaching/Screens/Players/DrillProgress/Widgets/field_score.dart';
import 'package:basketball_coaching/Screens/Players/DrillProgress/Widgets/performance1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DrillProgress extends StatelessWidget {
  const DrillProgress({super.key});

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
                  Row(
                    children: [
                      const MyBackButton(),
                      SizedBox(
                        width: 29.w,
                      ),
                      Text(
                        'Cone Drill progress',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 46.h,
                  ),
                  // const BarChart(),
                  SizedBox(
                    height: 46.h,
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
                    height: 26.h,
                  ),
                  SizedBox(
                    width: 393.w,
                    height: 225.h,
                    child: Image.asset(
                      "assets/images/celebrate.gif",
                      width: 393.w,
                      height: 225.h,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  Center(
                    child: Text(
                      'let’s look into\nprevious months',
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
                    height: 26.h,
                  ),
                  const Performance1(),
                  SizedBox(
                    height: 26.h,
                  ),
                  const FieldScore(),
                  SizedBox(
                    height: 26.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/imp2.png',
                      ),
                      Text(
                        'Improved',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFFAB7CE6),
                          fontSize: 24.sp,
                          fontFamily: 'Jua',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      Image.asset(
                        'assets/images/imp1.png',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: Text(
                      'Here are some videos\nof your drills',
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
                    height: 26.h,
                  ),
                  Container(
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
                  Container(
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
                  SizedBox(
                    height: 20.h,
                  )
                ]))));
  }
}
