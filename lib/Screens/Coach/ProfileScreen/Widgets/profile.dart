import 'dart:math';

import 'package:basketball_coaching/Screens/login.dart';
import 'package:basketball_coaching/app_navigations/custom_navigate.dart';
import 'package:basketball_coaching/firebase/coach_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/coach.dart';
import '../../../../providers/auth_provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool logOut = false;
  bool loaded = false;
  String? id;
  String? name;
  int? students;
  String? email;
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');
    Coach? coach = await CoachAuth().getCoachDataByCoachId(userId!);
    setState(() {
      id = coach!.coachId;
      name = coach!.fullName;
      students = coach!.students.length;
      email = coach!.email;
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserAuthProvider authProvider =
        Provider.of<UserAuthProvider>(context, listen: false);

    Future<void> signOut() async {
      try {
        await FirebaseAuth.instance.signOut();
        authProvider.clearUser();
        setState(() {
          logOut = true;
        });
        CustomNavigate().pushReplacement(
          context,
          const LoginScreen(),
        );
      } catch (e) {
        print(e);
      }
    }

    return loaded
        ? Stack(
            children: [
              Container(
                height: 560.h,
                width: 357.w,
                color: Colors.transparent,
                child: Stack(
                  children: [
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
                              name!,
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
                              email!,
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
                                  "Students: ${students!.toInt()}",
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
                                        email!,
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
                                  GestureDetector(
                                    onTap: () async {
                                      await signOut();
                                    },
                                    child: Row(
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
                  ],
                ),
              )
            ],
          )
        : Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Image.asset(
                  "assets/images/loader.gif",
                  height: 200.h,
                  width: 200.h,
                ),
              ),
            ),
          );
  }
}
