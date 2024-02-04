import 'dart:math';

import 'package:basketball_coaching/Components/main_button.dart';
import 'package:basketball_coaching/Screens/Players/StudentProfiles/Widgets/profile_container.dart';
import 'package:basketball_coaching/Screens/Players/StudentProfiles/Widgets/score_container.dart';
import 'package:basketball_coaching/Screens/login.dart';
import 'package:basketball_coaching/app_navigations/custom_navigate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  bool logout = false;
  @override
  Widget build(BuildContext context) {
    Future<void> _logout() async {
      final UserAuthProvider authProvider =
          Provider.of<UserAuthProvider>(context, listen: false);
      authProvider.clearUser();
      setState(() {
        logout = true;
      });
    }

    return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: 393.w,
            height: 334.h,
            decoration: ShapeDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/images/studentprofile.png"),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, top: 11.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ScoreContainer(),
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: Text(
                    'Keep doing good',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Jacob',
                    textAlign: TextAlign.center,
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
                  height: 10.h,
                ),
                const ProfileContainer(),
                SizedBox(
                  height: 17.h,
                ),
                const MainButton(text: 'Save Changes'),
                SizedBox(
                  height: 23.h,
                ),
                GestureDetector(
                  onTap: () {
                    _logout();
                    if (logout) {
                      CustomNavigate()
                          .pushReplacement(context, const LoginScreen());
                    }
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/2.png',
                      ),
                      SizedBox(
                        width: 18.w,
                      ),
                      Text(
                        'delete profile',
                        style: TextStyle(
                          color: const Color(0xFFAB7CE6),
                          fontSize: 16.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ])));
  }
}
