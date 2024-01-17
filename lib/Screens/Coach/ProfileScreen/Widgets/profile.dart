import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          height: 560.h,
          width: 357.w,
          color: Colors.transparent,
          child: Stack(children: [
            Positioned(
              top: 75,
              child: Container(
                width: 357.w,
                height: 600.h,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  shadows: [
                    BoxShadow(
                      color: const Color(0x3F000000),
                      blurRadius: 4.r,
                      offset: const Offset(0, 1),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 80.h,
                    ),
                    Text(
                      'Yacob',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Text(
                      'yacob123@gmail.com',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF89898A),
                        fontSize: 12.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/group.svg',
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        Text(
                          '20 students',
                          style: TextStyle(
                            color: const Color(0xFF979595),
                            fontSize: 12.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 36.h,
                    ),
                    Container(
                      width: 332.w,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1.w,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: const Color(0xFFD9D9D9),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 58.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 36.w),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/email.svg',
                              ),
                              SizedBox(
                                width: 42.w,
                              ),
                              Text(
                                'yacob123@gmail.com',
                                style: TextStyle(
                                  color: const Color(0xFF979595),
                                  fontSize: 12.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 27.h,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/number.svg',
                              ),
                              SizedBox(
                                width: 42.w,
                              ),
                              Text(
                                '+000 00 00 00 00',
                                style: TextStyle(
                                  color: const Color(0xFF979595),
                                  fontSize: 12.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 27.h,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/pass.svg',
                              ),
                              SizedBox(
                                width: 42.w,
                              ),
                              Text(
                                'Change password',
                                style: TextStyle(
                                  color: const Color(0xFF979595),
                                  fontSize: 12.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 27.h,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/out.svg',
                              ),
                              SizedBox(
                                width: 42.w,
                              ),
                              Text(
                                'logout',
                                style: TextStyle(
                                  color: const Color(0xFF979595),
                                  fontSize: 12.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 1.h,
              left: 100.w,
              child: Container(
                width: 146,
                height: 146,
                decoration: ShapeDecoration(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(73),
                  ),
                ),
                child: Image.asset(
                  'assets/images/profilescreen.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ]))
    ]);
  }
}
