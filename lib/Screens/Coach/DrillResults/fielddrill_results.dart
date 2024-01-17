import 'package:basketball_coaching/Components/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FieldDrill extends StatelessWidget {
  const FieldDrill({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: Padding(
            padding: EdgeInsets.only(left: 23.w, right: 23.w, top: 60.h),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const MyBackButton(),
              SizedBox(
                height: 26.h,
              ),
              Container(
                width: 398.w,
                height: 265.h,
                decoration: ShapeDecoration(
                  image: const DecorationImage(
                    image: AssetImage("assets/images/video.png"),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              SizedBox(
                height: 19.h,
              ),
              Center(
                child: Text(
                  'Field Statistics',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32.sp,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              SizedBox(
                height: 19.h,
              ),
              Container(
                width: 398.w,
                height: 265.h,
                decoration: ShapeDecoration(
                  image: const DecorationImage(
                    image: AssetImage("assets/images/board.png"),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ])));
  }
}
