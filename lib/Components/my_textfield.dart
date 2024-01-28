import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class MyTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  MyTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.keyboardType,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 347.w,
      height: 51.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        cursorColor: const Color(0xFF979595),
        style: const TextStyle(
          color: Color(0xFF979595),
        ),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
          ),
          hintText: widget.label,
          hintStyle: TextStyle(
            color: const Color(0xFF979595),
            fontSize: 14.sp,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
