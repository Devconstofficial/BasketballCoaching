import 'package:basketball_coaching/Screens/Players/DrillPerformance/drill_performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NewDrills extends StatefulWidget {
  final String text;
  final String gifPath;
  const NewDrills({super.key, required this.text, required this.gifPath});

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
            widget.gifPath,
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
                    Text(
                      'Progress Details',
                      style: TextStyle(
                        color: const Color(0xFFAB7CE6),
                        fontSize: 14.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(
                      width: 79.w,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DrillPerformance()),
                        );
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
