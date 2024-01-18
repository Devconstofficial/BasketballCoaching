import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Performance1 extends StatelessWidget {
  const Performance1({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 55.w,
        ),
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
          width: 16.w,
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
        ),
        SizedBox(
          width: 16.w,
        ),
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
      ],
    );
  }
}
