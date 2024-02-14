import 'package:basketball_coaching/Components/my_snackbar.dart';
import 'package:basketball_coaching/Screens/login.dart';
import 'package:basketball_coaching/Components/main_button.dart';
import 'package:basketball_coaching/Components/my_textfield.dart';
import 'package:basketball_coaching/app_navigations/custom_navigate.dart';
import 'package:basketball_coaching/firebase/coach_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool success = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _teamNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> signUp() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      CoachAuth().addCoachDocument(_emailController.text,
          _fullNameController.text, _teamNameController.text);
      setState(() {
        success = true;
      });
    } catch (e) {
      print("error signing up $e");
    }
  }

  void signUpSuccess() {
    SnackBarHelper.showSnackbar(context, "Sign Up Success");
    CustomNavigate().pushRoute(context, const LoginScreen());
  }

  void signUpfail() {
    SnackBarHelper.showSnackbar(context, "Sign Up failed");
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

  String? _validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return 'all fields required';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  bool _validateFields() {
    return (_validateEmail(_emailController.text) == null &&
        _validatePassword(_passwordController.text) == null &&
        _validatePassword(_confirmPasswordController.text) == null &&
        _validateTextField(_fullNameController.text) == null &&
        _validateTextField(_teamNameController.text) == null &&
        (_passwordController.text == _confirmPasswordController.text));
  }

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
                    'Sign Up',
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
                  SizedBox(height: 34.h),
                  MyTextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    label: 'Email...',
                  ),
                  SizedBox(height: 7.h),
                  MyTextField(
                    controller: _fullNameController,
                    keyboardType: TextInputType.text,
                    label: 'Full name...',
                  ),
                  SizedBox(height: 7.h),
                  MyTextField(
                    controller: _teamNameController,
                    keyboardType: TextInputType.text,
                    label: 'Team name...',
                  ),
                  SizedBox(height: 7.h),
                  MyTextField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    label: 'Password...',
                  ),
                  SizedBox(height: 7.h),
                  MyTextField(
                    controller: _confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    label: 'Confirm password...',
                  ),
                  SizedBox(height: 31.h),
                  InkWell(
                      onTap: () async {
                        try {
                          if (_validateFields()) {
                            await signUp();
                            if (success) {
                              signUpSuccess();
                            } else {
                              signUpfail();
                            }
                          } else {
                            SnackBarHelper.showSnackbar(
                                context, "Enter all valid fields");
                          }
                        } catch (e) {
                          print("sign up failed");
                        }
                      },
                      child: const MainButton(text: 'SIGN UP')),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
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
                              .pushReplacement(context, const LoginScreen());
                        },
                        child: Text(
                          'Sign in',
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
                  SizedBox(height: 26.h),
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
                  SizedBox(height: 15.h),
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
