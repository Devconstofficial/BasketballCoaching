import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 353.w,
      height: 217.h,
      decoration: ShapeDecoration(
        color: const Color(0xFFFEFEFE),
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
      child: Column(
        children: [
          SizedBox(
            height: 15.h,
          ),
          Text(
            'select display avatar',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          SizedBox(
            height: 17.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 35.w,
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/images/elipse1.png',
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  Image.asset(
                    'assets/images/elipse1.png',
                    fit: BoxFit.fill,
                  ),
                ],
              ),
              SizedBox(
                width: 17.w,
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/images/elipse1.png',
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  Image.asset(
                    'assets/images/elipse1.png',
                    fit: BoxFit.fill,
                  ),
                ],
              ),
              SizedBox(
                width: 17.w,
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/images/elipse1.png',
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  Image.asset(
                    'assets/images/elipse1.png',
                    fit: BoxFit.fill,
                  ),
                ],
              ),
              SizedBox(
                width: 17.w,
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/images/elipse1.png',
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  Image.asset(
                    'assets/images/elipse1.png',
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
