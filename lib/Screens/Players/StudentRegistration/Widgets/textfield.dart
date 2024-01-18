import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainTextField extends StatefulWidget {
  final String label;
  const MainTextField({
    super.key,
    required this.label,
  });

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 324.w,
      height: 52.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.r),
        ),
        shadows: [
          BoxShadow(
            color: const Color(0x3F000000),
            blurRadius: 5.w,
            offset: Offset(0.w, 1.h),
            spreadRadius: 0,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          cursorColor: const Color(0xFF7A797B),
          style: const TextStyle(color: Color(0xFF7A797B)),
          decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: widget.label,
            hintStyle: TextStyle(
              color: const Color(0xFF7A797B),
              fontSize: 14.sp,
              fontFamily: 'Red Hat Display',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
