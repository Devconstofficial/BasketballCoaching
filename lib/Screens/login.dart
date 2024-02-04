import 'package:basketball_coaching/Components/my_snackbar.dart';
import 'package:basketball_coaching/Screens/Coach/coach_navbar.dart';
import 'package:basketball_coaching/Components/main_button.dart';
import 'package:basketball_coaching/Components/my_textfield.dart';
import 'package:basketball_coaching/Screens/Players/StudentRegistration/student_registration.dart';
import 'package:basketball_coaching/Screens/signup.dart';
import 'package:basketball_coaching/app_navigations/custom_navigate.dart';
import 'package:basketball_coaching/firebase/coach_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../models/coach.dart';
import '../providers/auth_provider.dart';
import '../providers/coach_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool signInSuccess = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  bool _validateFields() {
    return (_validateEmail(_emailController.text) == null &&
        _validatePassword(_passwordController.text) == null);
  }

  void signInNavigate() {
    SnackBarHelper.showSnackbar(context, "Logged In");
    CustomNavigate().pushReplacement(context, const CoachNavBar());
  }

  @override
  Widget build(BuildContext context) {
    final CoachProvider coachProvider =
        Provider.of<CoachProvider>(context, listen: false);
    final UserAuthProvider authProvider =
        Provider.of<UserAuthProvider>(context);

    void setCoach(Coach coachData) async {
      coachProvider.setCoach(coachData);
      authProvider.setUser(
        coachData.coachId,
        UserType.coach,
        coachData.fullName,
      );
    }

    Future<void> signIn() async {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        if (userCredential.user != null) {
          signInSuccess = true;
        }

        Coach? coachData =
            await CoachAuth().getCoachDataByEmail(_emailController.text);

        if (coachData != null) {
          setCoach(coachData);
          authProvider.setUser(
            coachData.coachId,
            UserType.coach,
            coachData.fullName,
          );
        }
      } catch (e) {
        print("Sign in failed $e");
      }
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      label: 'Email...',
                    ),
                    SizedBox(height: 26.h),
                    MyTextField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      label: 'Password...',
                    ),
                    SizedBox(height: 60.h),
                    InkWell(
                      onTap: () async {
                        try {
                          if (_validateFields()) {
                            await signIn();
                            if (signInSuccess) {
                              signInNavigate();
                            }
                          } else {
                            SnackBarHelper.showSnackbar(
                                context, "Enter all fields");
                          }
                        } catch (e) {
                          SnackBarHelper.showSnackbar(
                              context, "Sign In failed");
                        }
                      },
                      child: const MainButton(text: 'SIGN IN'),
                    ),
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
                            CustomNavigate()
                                .pushRoute(context, const SignupScreen());
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
                    GestureDetector(
                      onTap: () {
                        CustomNavigate()
                            .pushRoute(context, const StudentRegistration());
                      },
                      child: Text(
                        'SIGN IN AS STUDENT',
                        style: TextStyle(
                          color: const Color(0xFFAB7CE6),
                          fontSize: 14.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ))),
    );
  }
}
