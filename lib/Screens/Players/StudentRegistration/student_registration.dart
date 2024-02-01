import 'package:basketball_coaching/Screens/Players/Drills/drills_screen.dart';
import 'package:basketball_coaching/Screens/Players/StudentRegistration/Widgets/age_selection.dart';
import 'package:basketball_coaching/Components/main_button.dart';
import 'package:basketball_coaching/Screens/Players/StudentRegistration/Widgets/selection_row.dart';
import 'package:basketball_coaching/Screens/Players/StudentRegistration/Widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentRegistration extends StatefulWidget {
  const StudentRegistration({super.key});

  @override
  State<StudentRegistration> createState() => _StudentRegistrationState();
}

class _StudentRegistrationState extends State<StudentRegistration> {
  String studentId = "STD1006345";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: 393.w,
            height: 345.h,
            decoration: const ShapeDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [Color(0xFF982DD1), Color(0xFFE9A6F3)],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 86.h),
                Image.asset(
                  'assets/images/basketball.png',
                ),
                SizedBox(height: 65.h),
                Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 26.h,
          ),
          const Center(child: MainTextField(label: 'Full Name...')),
          Padding(
            padding: EdgeInsets.only(left: 35.w, top: 22.h, bottom: 11.h),
            child: Text(
              'Gender',
              style: TextStyle(
                color: const Color(0xFF7A797B),
                fontSize: 14.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 22.w),
            child: const SelectionRow(),
          ),
          Padding(
            padding: EdgeInsets.only(left: 35.w, top: 31.h, bottom: 11.h),
            child: Text(
              'Age',
              style: TextStyle(
                color: const Color(0xFF7A797B),
                fontSize: 14.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 34.w, bottom: 59.h),
            child: const AgeSelection(),
          ),
          Padding(
            padding: EdgeInsets.only(left: 24.w),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DrillsScreen(
                              studentId: studentId,
                            )),
                  );
                },
                child: const MainButton(text: 'Get Started')),
          ),
          SizedBox(
            height: 20.h,
          )
        ])));
  }
}
