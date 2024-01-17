import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 44.w,
              height: 44.h,
              decoration: const ShapeDecoration(
                image: DecorationImage(
                  image: ExactAssetImage('assets/images/cardimage.png'),
                  fit: BoxFit.fill,
                ),
                shape: OvalBorder(),
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Container(
              width: 237.w,
              height: 75.h,
              decoration: ShapeDecoration(
                color: const Color(0xFFFEFEFE),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                shadows: [
                  BoxShadow(
                    color: const Color(0x3F000000),
                    blurRadius: 4.r,
                    offset: const Offset(0, 1),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(8.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '~Sarah',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFFAB7CE6),
                        fontSize: 12.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    Text(
                      'It’s a bit hard to practice, will you guide\nus in physical session as well?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 180.w),
                      child: Text(
                        '9:35 pm',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF8A898A),
                          fontSize: 10.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 159.w,
              height: 58.h,
              decoration: ShapeDecoration(
                color: const Color(0xFFAB7CE6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r)),
                shadows: [
                  BoxShadow(
                    color: const Color(0x3F000000),
                    blurRadius: 4.r,
                    offset: const Offset(0, 1),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(10.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Yes, i will',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 100.w, top: 10.h),
                      child: Text(
                        '9:35 pm',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Container(
              width: 44.w,
              height: 44.h,
              decoration: const ShapeDecoration(
                image: DecorationImage(
                  image: ExactAssetImage('assets/images/cardimage.png'),
                  fit: BoxFit.fill,
                ),
                shape: OvalBorder(),
              ),
            )
          ],
        )
      ],
    );
  }
}
