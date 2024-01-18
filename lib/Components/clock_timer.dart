import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ClockTimer extends StatelessWidget {
  const ClockTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
              children: [
                SvgPicture.asset(
                  'assets/images/clock.svg',
                ),
                SizedBox(width: 14.w),
                Container(
                  width: 51.w,
                  height: 59.h,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFEFEFE),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    shadows: [
                      BoxShadow(
                        color: const Color(0x3F000000),
                        blurRadius: 5.sp,
                        offset: const Offset(0, 1),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: Column(
                      children: [
                        Text(
                          '00',
                          style: TextStyle(
                            color: const Color(0xFFAB7CE6),
                            fontSize: 20.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                        Text(
                          'minutes',
                          style: TextStyle(
                            color: const Color(0xFF7A797B),
                            fontSize: 10.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                Container(
                  width: 12.w,
                  height: 3.h,
                  decoration: const BoxDecoration(color: Color(0xFFAB7CE6)),
                ),
                SizedBox(width: 4.w),
                Container(
                  width: 51.w,
                  height: 59.h,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFEFEFE),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    shadows: [
                      BoxShadow(
                        color: const Color(0x3F000000),
                        blurRadius: 5.sp,
                        offset: const Offset(0, 1),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: Column(
                      children: [
                        Text(
                          '00',
                          style: TextStyle(
                            color: const Color(0xFFAB7CE6),
                            fontSize: 20.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                        Text(
                          'seconds',
                          style: TextStyle(
                            color: const Color(0xFF7A797B),
                            fontSize: 10.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
  }
}