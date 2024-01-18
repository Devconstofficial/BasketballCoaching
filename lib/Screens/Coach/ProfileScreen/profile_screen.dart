import 'package:basketball_coaching/Screens/Coach/ProfileScreen/Widgets/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: EdgeInsets.only(left: 347.w, top: 87.h),
            child: SvgPicture.asset(
              'assets/images/edit.svg',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.w,
            ),
            child: const Profile(),
          ),
        ])));
  }
}
