import 'dart:math';

import 'package:basketball_coaching/Components/firebaseImageWidget.dart';
import 'package:basketball_coaching/Components/main_button.dart';
import 'package:basketball_coaching/Components/my_snackbar.dart';
import 'package:basketball_coaching/Screens/Players/StudentProfiles/Widgets/profile_container.dart';
import 'package:basketball_coaching/Screens/Players/StudentProfiles/Widgets/score_container.dart';
import 'package:basketball_coaching/Screens/login.dart';
import 'package:basketball_coaching/app_navigations/custom_navigate.dart';
import 'package:basketball_coaching/cubits/students/cubit.dart';
import 'package:basketball_coaching/models/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../providers/auth_provider.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  bool logout = false;
  String? name;
  bool loaded = false;
  String? profile;
  String? newProfile;
  String? currentProfile;
  @override
  initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    StudentCubit studentCubit = BlocProvider.of<StudentCubit>(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');
    Student? student = await studentCubit.getStudentById(userId!);
    setState(() {
      name = student!.name;
      loaded = true;
      profile = student!.profile == "avatars/avatar1.png"
          ? "assets/images/studentprofile.png"
          : "assets/images/girlbitmoji.png";
      currentProfile = student.profile;
    });
  }

  void handleImageSelection(String selectedImage) {
    if (selectedImage == 'boy') {
      setState(() {
        newProfile = "avatars/avatar1.png";
        profile = "assets/images/studentprofile.png";
      });
    } else if (selectedImage == 'girl') {
      setState(() {
        newProfile = "avatars/avatar2.png";
        profile = "assets/images/girlbitmoji.png";
      });
    }
  }

  Future<void> updateProfile() async {
    StudentCubit studentCubit = BlocProvider.of<StudentCubit>(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');
    await studentCubit.updateProfile(userId!, newProfile!);
  }

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

    return loaded
        ? Scaffold(
            backgroundColor: const Color(0xFFF5F5F5),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 393.w,
                    height: 334.h,
                    decoration: ShapeDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                        image: AssetImage(profile!),
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
                            name!,
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
                        ProfileContainer(
                          onImageSelected: handleImageSelection,
                        ),
                        SizedBox(
                          height: 17.h,
                        ),
                        GestureDetector(
                            onTap: () async {
                              if (newProfile != null &&
                                  newProfile != currentProfile) {
                                await updateProfile();
                                SnackBarHelper.showSnackbar(
                                    context, "Profile Updated Successfully");
                              } else {
                                SnackBarHelper.showSnackbar(
                                    context, "Profile already the same");
                              }
                            },
                            child: const MainButton(text: 'Save Changes')),
                        SizedBox(
                          height: 23.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            _logout();
                            if (logout) {
                              CustomNavigate().pushReplacement(
                                  context, const LoginScreen());
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
                                'logout profile',
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
                ],
              ),
            ),
          )
        : Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Image.asset(
                "assets/images/loader.gif",
                height: 200.h,
                width: 200.h,
              ),
            ),
          );
  }
}
