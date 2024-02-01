import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoodScore extends StatelessWidget {
  const GoodScore({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Row(
        children: [
          Image.asset('assets/images/kobesad.png', width: 184.w, height: 200.h),
          SizedBox(
            width: 3.w,
          ),
          Image.asset('assets/images/kobehap.png', width: 184.w, height: 200.h),
        ],
      ),
    );
  }
}
