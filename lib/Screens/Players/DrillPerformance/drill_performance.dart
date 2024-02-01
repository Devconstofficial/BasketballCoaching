import 'package:basketball_coaching/Components/my_snackbar.dart';
import 'package:basketball_coaching/Components/thumbnail_builder.dart';
import 'package:basketball_coaching/Screens/Players/DrillPerformance/timer_screen.dart';
import 'package:basketball_coaching/Screens/Players/DrillPerformance1/drill_performance1.dart';
import 'package:basketball_coaching/Components/back_button.dart';
import 'package:basketball_coaching/Components/clock_timer.dart';
import 'package:basketball_coaching/Components/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Components/firebase_video_player.dart';
import '../../../app_navigations/custom_navigate.dart';

class DrillPerformance extends StatefulWidget {
  final String drillName;
  final String? video;
  const DrillPerformance({
    super.key,
    this.video,
    required this.drillName,
  });

  @override
  State<DrillPerformance> createState() => _DrillPerformanceState();
}

class _DrillPerformanceState extends State<DrillPerformance> {
  int selectedMinutes = 0;
  int selectedSeconds = 0;
  TextEditingController drillsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MyBackButton(),
        leadingWidth: 100,
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 18.w, top: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.drillName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              SizedBox(
                height: 20.w,
              ),
              widget.video == null || widget.video == ""
                  ? const Center(
                      child: Text(
                        "NO VIDEO AVAILABLE",
                        style: TextStyle(
                          color: const Color(0xFFAB7CE6),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 250.h,
                      decoration: ShapeDecoration(
                        color: const Color(0x7F151517),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Stack(
                        children: [
                          ThumbnailBuilder(file: widget.video),
                          Positioned.fill(
                            child: Center(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.play_circle_fill,
                                  color: Colors.black,
                                  size: 50,
                                ),
                                onPressed: () {
                                  CustomNavigate().pushRoute(
                                      context,
                                      FirebaseVideoPlayerScreen(
                                        widget.video!,
                                      ));
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              SizedBox(
                height: 25.h,
              ),
              Center(
                child: Text(
                  'Enter your target',
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
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Set Timer and Challenge yourself',
                        style: TextStyle(
                          color: const Color(0xFF7A787B),
                          fontSize: 12.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      SizedBox(
                        height: 22.h,
                      ),
                      ClockTimer(
                        onTimeSelected: (minutes, seconds) {
                          setState(() {
                            selectedMinutes = minutes;
                            selectedSeconds = seconds;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Stack(
                    children: [
                      Image.asset(
                        'assets/images/selection.png',
                      ),
                      Positioned.fill(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 15.w, bottom: 160.w, right: 85.w),
                          child: TextField(
                            controller: drillsController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(fontSize: 10),
                            decoration: const InputDecoration(
                                hintText: 'e.g:10', border: InputBorder.none),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 81.h,
              ),
              InkWell(
                  onTap: () {
                    if ((selectedMinutes == 0 && selectedSeconds == 0) ||
                        drillsController.text.isEmpty) {
                      SnackBarHelper.showSnackbar(
                          context, "Enter Targeted minutes and Drill Numbers");
                    } else {
                      CustomNavigate().pushReplacement(
                          context,
                          TimerScreen(
                              drillName: widget.drillName,
                              initialMinutes: selectedMinutes,
                              initialSeconds: selectedSeconds));
                    }
                  },
                  child: const MainButton(text: 'Start Challange'))
            ],
          ),
        ),
      ),
    );
  }
}
