import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Performance extends StatelessWidget {
  const Performance({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'nov',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.sp,
                      fontFamily: 'Jua',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  SvgPicture.asset(
                    'assets/images/down.svg',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
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
              height: 4.h,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'dec',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.sp,
                      fontFamily: 'Jua',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  SvgPicture.asset(
                    'assets/images/down.svg',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              '20 drills',
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
              '20 field score',
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
        )
      ],
    );
  }
}
