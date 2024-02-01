import 'package:basketball_coaching/Screens/Players/DrillPerformance/drill_performance.dart';
import 'package:basketball_coaching/Screens/Players/DrillProgress/drill_progress.dart';
import 'package:basketball_coaching/app_navigations/custom_navigate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NewDrills extends StatefulWidget {
  final String drillName;
  final String studentId;
  final String text;
  final String? gifPath;
  final String? videoUrl;
  const NewDrills({
    super.key,
    required this.drillName,
    required this.studentId,
    required this.text,
    this.gifPath,
    this.videoUrl,
  });

  @override
  State<NewDrills> createState() => _NewDrillsState();
}

class _NewDrillsState extends State<NewDrills> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          child: Image.asset(
            widget.gifPath!,
            fit: BoxFit.cover,
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
                  widget.text,
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
                    GestureDetector(
                      onTap: () {
                        CustomNavigate().pushRoute(
                          context,
                          DrillProgress(
                            studentId: widget.studentId,
                            drillName: widget.drillName,
                          ),
                        );
                      },
                      child: Text(
                        'Progress Details',
                        style: TextStyle(
                          color: const Color(0xFFAB7CE6),
                          fontSize: 14.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 79.w,
                    ),
                    InkWell(
                      onTap: () {
                        CustomNavigate().pushRoute(
                            context,
                            DrillPerformance(
                              drillName: widget.drillName,
                              video: widget.videoUrl != null ||
                                      widget.videoUrl == ""
                                  ? widget.videoUrl
                                  : null,
                            ));
                      },
                      child: Row(
                        children: [
                          Text(
                            'Perform Drill',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFAB7CE6),
                              fontSize: 14.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                          SizedBox(
                            width: 7.w,
                          ),
                          SvgPicture.asset(
                            'assets/images/arrow.svg',
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
