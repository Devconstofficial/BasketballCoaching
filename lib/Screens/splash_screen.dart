import 'dart:async';
import 'package:basketball_coaching/Screens/Coach/AddProgress/leaderboard.dart';
import 'package:basketball_coaching/Screens/Coach/coach_navbar.dart';
import 'package:basketball_coaching/Screens/login.dart';
import 'package:basketball_coaching/wrappers/auth_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    movetoNextScreen();
    super.initState();
  }

  movetoNextScreen() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthenticationWrapper(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserAuthProvider authProvider =
        Provider.of<UserAuthProvider>(context, listen: false);
    print(
        "USER AUTH \n\n ${authProvider.userId} \n\n ${authProvider.userName} \n\n ${authProvider.userType.toString()}");

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/splash.gif'),
              Padding(
                padding: EdgeInsets.only(top: 22.h),
                child: Text(
                  'Let’s Play some \nBasketball',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32.sp,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
