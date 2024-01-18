import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainButton extends StatelessWidget {
  final String text;
  const MainButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 347.w,
      height: 51.h,
      decoration: ShapeDecoration(
        color: const Color(0xFFAB7CE6),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
      child: Center(
          child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          height: 0,
        ),
      )),
    );
  }
}
