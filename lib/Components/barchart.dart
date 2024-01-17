import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BarChart extends StatefulWidget {
  const BarChart({super.key});

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          children: [
            Container(
              width: 46.w,
              height: 94.h,
              decoration: const BoxDecoration(color: Color(0x4CAB7CE6)),
            ),
            SizedBox(
              height: 11.h,
            ),
            Text(
              'mon',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 10.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            )
          ],
        ),
        SizedBox(
          width: 3.w,
        ),
        Column(
          children: [
            Text(
              '10 times',
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
              height: 4.h,
            ),
            Text(
              'improve',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF89898A),
                fontSize: 10.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Container(
              width: 33.w,
              height: 33.w,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/4.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Container(
              width: 45.w,
              height: 128.h,
              decoration: const BoxDecoration(color: Color(0x99AB7CE6)),
            ),
            SizedBox(
              height: 11.h,
            ),
            Text(
              'tue',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 10.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            )
          ],
        ),
        SizedBox(
          width: 3.w,
        ),
        Column(
          children: [
            Text(
              '5 times',
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
              height: 4.h,
            ),
            Text(
              'decline',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF89898A),
                fontSize: 10.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Container(
              width: 33.w,
              height: 33.w,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/4.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Container(
              width: 46.w,
              height: 94.h,
              decoration: const BoxDecoration(color: Color(0x4CAB7CE6)),
            ),
            SizedBox(
              height: 11.h,
            ),
            Text(
              'wed',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 10.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            )
          ],
        ),
        SizedBox(
          width: 3.w,
        ),
        Column(
          children: [
            Text(
              '8 times',
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
              height: 4.h,
            ),
            Text(
              'improve',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF89898A),
                fontSize: 10.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Container(
              width: 33.w,
              height: 33.w,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/4.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Container(
              width: 45.w,
              height: 124.h,
              decoration: const BoxDecoration(color: Color(0xFFC9ACEC)),
            ),
            SizedBox(
              height: 11.h,
            ),
            Text(
              'thu',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 10.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            )
          ],
        ),
        SizedBox(
          width: 3.w,
        ),
        Column(
          children: [
            Text(
              '10 times',
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
              height: 4.h,
            ),
            Text(
              'improve',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF89898A),
                fontSize: 10.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Container(
              width: 33.w,
              height: 33.w,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/4.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Container(
              width: 46.w,
              height: 140.h,
              decoration: const BoxDecoration(color: Color(0xCCAB7CE6)),
            ),
            SizedBox(
              height: 11.h,
            ),
            Text(
              'fri',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 10.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            )
          ],
        ),
        SizedBox(
          width: 3.w,
        ),
        Column(
          children: [
            Text(
              '7 times',
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
              height: 4.h,
            ),
            Text(
              'decline',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF89898A),
                fontSize: 10.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Container(
              width: 33.w,
              height: 33.w,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/4.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Container(
              width: 42.w,
              height: 113.h,
              decoration: const BoxDecoration(color: Color(0x7FAB7CE6)),
            ),
            SizedBox(
              height: 11.h,
            ),
            Text(
              'sat',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 10.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            )
          ],
        ),
        SizedBox(
          width: 3.w,
        ),
        Column(
          children: [
            Text(
              '15 times',
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
              height: 4.h,
            ),
            Text(
              'improve',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF89898A),
                fontSize: 10.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Container(
              width: 33.w,
              height: 33.w,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/5.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Container(
              width: 46.w,
              height: 154.h,
              decoration: const BoxDecoration(color: Color(0xFFAB7CE6)),
            ),
            SizedBox(
              height: 11.h,
            ),
            Text(
              'sun',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 10.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            )
          ],
        ),
      ],
    );
  }
}
