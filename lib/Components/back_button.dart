import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      
      onTap: () {
        Navigator.pop(context);
      },
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/images/backicon.svg',
          ),
          SizedBox(
            width: 16.w,
          ),
          Text(
            'Back',
            style: TextStyle(
              color: const Color(0xFFAB7CE6),
              fontSize: 12.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          )
        ],
      ),
    );
  }
}
