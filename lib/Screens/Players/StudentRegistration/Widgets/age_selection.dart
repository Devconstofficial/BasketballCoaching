import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AgeSelection extends StatefulWidget {
  const AgeSelection({Key? key});

  @override
  State<AgeSelection> createState() => _AgeSelectionState();
}

class _AgeSelectionState extends State<AgeSelection> {
  int age = 12;

  void _decreaseAge() {
    setState(() {
      if (age > 0) {
        age--;
      }
    });
  }

  void _increaseAge() {
    setState(() {
      age++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 195.w,
      height: 52.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        shadows: [
          BoxShadow(
            color: const Color(0x3F000000),
            blurRadius: 5.r,
            offset: const Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 30.w,
          ),
          GestureDetector(
            onTap: _decreaseAge,
            child: SvgPicture.asset(
              'assets/images/minus.svg',
            ),
          ),
          SizedBox(
            width: 54.w,
          ),
          Text(
            '$age',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          SizedBox(
            width: 54.w,
          ),
          GestureDetector(
            onTap: _increaseAge,
            child: SvgPicture.asset(
              'assets/images/plus.svg',
            ),
          )
        ],
      ),
    );
  }
}
