import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FieldScore extends StatelessWidget {
  const FieldScore({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Image.asset('assets/images/kobesad.png',
                width: 170.w, height: 200.h),
            SizedBox(
              height: 6.h,
            ),
            Text(
              '50 drills',
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
              height: 6.h,
            ),
            Text(
              '80 field score',
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
          width: 7.w,
        ),
        Column(
          children: [
            Image.asset('assets/images/kobehap.png',
                width: 170.w, height: 200.h),
            SizedBox(
              height: 6.h,
            ),
            Text(
              '50 drills',
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
              height: 6.h,
            ),
            Text(
              '80 field score',
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
      ],
    );
  }
}
