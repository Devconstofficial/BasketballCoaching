import 'package:basketball_coaching/Components/my_snackbar.dart';
import 'package:basketball_coaching/Components/my_textfield.dart';
import 'package:basketball_coaching/Screens/Players/Drills/drills_screen.dart';
import 'package:basketball_coaching/Components/main_button.dart';
import 'package:basketball_coaching/Screens/Players/players_navbar.dart';
import 'package:basketball_coaching/app_navigations/custom_navigate.dart';
import 'package:basketball_coaching/cubits/students/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../models/student.dart';
import '../../../providers/auth_provider.dart';

class StudentRegistration extends StatefulWidget {
  const StudentRegistration({super.key});

  @override
  State<StudentRegistration> createState() => _StudentRegistrationState();
}

class _StudentRegistrationState extends State<StudentRegistration> {
  TextEditingController codeController = TextEditingController();
  Student? currentStudent;
  bool gotStudent = false;

  @override
  Widget build(BuildContext context) {
    final UserAuthProvider authProvider =
        Provider.of<UserAuthProvider>(context, listen: false);

    Future<void> getStudentInfo() async {
      StudentCubit studentCubit = BlocProvider.of<StudentCubit>(context);
      Student? student = await studentCubit.getStudentById(codeController.text);
      if (student!.studentId.isNotEmpty) {
        setState(() {
          gotStudent = true;
          currentStudent = student;
          authProvider.setUser(
            codeController.text,
            UserType.student,
            currentStudent!.name,
          );
        });
      } else {
        currentStudent = null;
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                height: 50.h,
              ),
              Text(
                "Enter Code",
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.black38),
              ),
              SizedBox(
                height: 20.h,
              ),
              MyTextField(
                label: "Code",
                controller: codeController,
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: InkWell(
                  onTap: () async {
                    if (codeController.text.isNotEmpty) {
                      await getStudentInfo();
                      if (gotStudent) {
                        CustomNavigate().popAllNavigateToRoute(
                            context,
                            PlayerNavBar(
                              userId: codeController.text,
                            ));
                        SnackBarHelper.showSnackbar(context, "Signed In");
                      } else {
                        SnackBarHelper.showSnackbar(
                            context, "Student does not exist");
                      }
                    } else {
                      SnackBarHelper.showSnackbar(context, "Enter Code");
                    }
                  },
                  child: const MainButton(
                    text: 'Get Started',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
