import 'package:basketball_coaching/Components/back_button.dart';
import 'package:basketball_coaching/Components/clock_timer.dart';
import 'package:basketball_coaching/Screens/Players/DrillPerformance1/Widgets/emoji_slider.dart';
import 'package:basketball_coaching/Components/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DrillPerformance1 extends StatefulWidget {
  const DrillPerformance1({super.key});

  @override
  State<DrillPerformance1> createState() => _DrillPerformance1State();
}

class _DrillPerformance1State extends State<DrillPerformance1> {
  int selectedMinutes = 0;
  int selectedSeconds = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(left: 18.w, top: 50.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const MyBackButton(),
                          SizedBox(
                            width: 74.w,
                          ),
                          Text(
                            'Cone Drill',
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
                        height: 28.h,
                      ),
                      Container(
                        width: 357.w,
                        height: 207.h,
                        decoration: ShapeDecoration(
                          color: const Color(0x7F151517),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Center(
                        child: Text(
                          'Did you do well ??',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontFamily: 'Jua',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Center(
                        child: Text(
                          'Enter what you achieved today',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontFamily: 'Jua',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 230.w),
                        child: Text(
                          'Drills you want to perform?',
                          style: TextStyle(
                            color: const Color(0xFF7A797B),
                            fontSize: 10.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.5.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 230.w),
                        child: SvgPicture.asset(
                          'assets/images/pointer.svg',
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15.w),
                                child: Text(
                                  'How many times did you \nperformed the drill?',
                                  style: TextStyle(
                                    color: const Color(0xFF7A787B),
                                    fontSize: 12.sp,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                              const EmojiSlider(),
                              SizedBox(
                                height: 28.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15.w),
                                child: Text(
                                  'Time Out',
                                  style: TextStyle(
                                    color: const Color(0xFF7A787B),
                                    fontSize: 12.sp,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 28.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 12.w),
                                child: ClockTimer(
                                  onTimeSelected: (minutes, seconds) {
                                    setState(() {
                                      selectedMinutes = minutes;
                                      selectedSeconds = seconds;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 25.h,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  SvgPicture.asset(
                                    'assets/images/plus1.svg',
                                  ),
                                  SizedBox(
                                    width: 18.w,
                                  ),
                                  Text(
                                    'add you video',
                                    style: TextStyle(
                                      color: const Color(0xFF7A787B),
                                      fontSize: 12.sp,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'assets/images/selection.png',
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Center(
                        child: Image.asset(
                          'assets/images/sorry.png',
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      const MainButton(text: 'Add Progress'),
                      SizedBox(
                        height: 20.w,
                      )
                    ]))));
  }
}
