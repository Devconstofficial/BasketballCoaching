import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScoreContainer extends StatelessWidget {
  const ScoreContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.w,
      height: 23.h,
      decoration: ShapeDecoration(
        color: const Color(0xFFAB7CE6),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFAB7CE6)),
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Score:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          Text(
            '320',
            style: TextStyle(
              color: const Color(0xFFFCF7F4),
              fontSize: 10.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          )
        ],
      ),
    );
  }
}
