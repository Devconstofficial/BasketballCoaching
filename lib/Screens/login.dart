import 'package:basketball_coaching/Screens/Coach/coach_navbar.dart';
import 'package:basketball_coaching/Screens/Players/players_navbar.dart';
import 'package:basketball_coaching/Components/main_button.dart';
import 'package:basketball_coaching/Components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              width: 393.w,
              height: 305.h,
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
                  SizedBox(height: 25.h),
                  Text(
                    'Sign In',
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
            Padding(
              padding: EdgeInsets.only(left: 23.w, right: 23.w),
              child: Column(
                children: [
                  SizedBox(height: 52.h),
                  MyTextField(
                    label: 'Email...',
                  ),
                  SizedBox(height: 26.h),
                  MyTextField(
                    label: 'Password...',
                  ),
                  SizedBox(height: 60.h),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CoachNavBar()),
                        );
                      },
                      child: const MainButton(text: 'SIGN IN')),
                  SizedBox(height: 22.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Do not have an account? ',
                        style: TextStyle(
                          color: const Color(0xFF979595),
                          fontSize: 12.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PlayerNavBar()),
                          );
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            color: const Color(0xFFAB7CE6),
                            fontSize: 12.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 39.h),
                  Row(
                    children: [
                      Container(
                        width: 135.w,
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
                      SizedBox(width: 28.w),
                      Text(
                        'OR ',
                        style: TextStyle(
                          color: const Color(0xFF979595),
                          fontSize: 12.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      SizedBox(width: 28.w),
                      Container(
                        width: 135.w,
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
                    ],
                  ),
                  SizedBox(height: 22.h),
                  Image.asset(
                    'assets/images/google.png',
                  ),
                ],
              ),
            )
          ],
        )));
  }
}