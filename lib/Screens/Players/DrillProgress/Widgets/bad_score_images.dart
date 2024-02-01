import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BadScore extends StatelessWidget {
  const BadScore({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Row(
        children: [
          Image.asset('assets/images/goodScore.png',
              width: 184.w, height: 200.h),
          SizedBox(
            width: 3.w,
          ),
          Image.asset('assets/images/badScore.png',
              width: 184.w, height: 200.h),
        ],
      ),
    );
  }
}
