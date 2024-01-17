import 'package:basketball_coaching/Screens/Players/Drills/Widgets/new_drills.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrillsScreen extends StatefulWidget {
  const DrillsScreen({super.key});

  @override
  State<DrillsScreen> createState() => _DrillsScreenState();
}

class _DrillsScreenState extends State<DrillsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Image.asset(
              'assets/images/boy.gif',
              height: 250.h,
              width: 160.w,
            ),
            Container(
              width: 226.w,
              height: 177.h,
              decoration: const BoxDecoration(color: Color(0xFFFEFEFE)),
              child: Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: Text(
                  'Let’s drill & rock \nJacob!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32.sp,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ]),
          Padding(
            padding: EdgeInsets.only(left: 18.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'New Videos and Challenges',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                const NewDrills(
                  text: 'Close Shot',
                  gifPath: 'assets/images/closeshot.gif',
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  'Existing Drills',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                const NewDrills(
                    text: 'Cone Drill', gifPath: 'assets/images/conedrill.gif'),
                SizedBox(
                  height: 16.h,
                ),
                const NewDrills(
                    text: 'Hook Shot', gifPath: 'assets/images/hookshot.gif'),
                SizedBox(
                  height: 16.h,
                ),
                const NewDrills(
                    text: 'Close Shot', gifPath: 'assets/images/closeshot.gif'),
                SizedBox(
                  height: 16.h,
                ),
              ],
            ),
          )
        ])));
  }
}
