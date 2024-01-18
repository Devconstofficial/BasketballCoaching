import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardButton extends StatelessWidget {
  const CardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155.w,
      height: 30.h,
      decoration: ShapeDecoration(
        color: const Color(0xFFAB7CE6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 6.h),
        child: Text(
          'view progress',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
      ),
    );
  }
}
