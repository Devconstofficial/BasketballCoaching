import 'package:basketball_coaching/Components/firebaseImageWidget.dart';
import 'package:basketball_coaching/Screens/Coach/AddProgress/add_progress.dart';
import 'package:basketball_coaching/Screens/Coach/Home/Widgets/card_button.dart';
import 'package:basketball_coaching/Screens/Coach/Progress/view_progress.dart';
import 'package:basketball_coaching/app_navigations/custom_navigate.dart';
import 'package:basketball_coaching/firebase/coach_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../cubits/students/cubit.dart';

class StudentsCard extends StatelessWidget {
  final String name;
  final String studentId;
  final String profile;

  const StudentsCard({
    Key? key,
    required this.name,
    required this.studentId,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(1, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 57, top: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: FirebaseNetworkImage(
                    imagePath: profile,
                    width: 58,
                    height: 58,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () {
                    _showDeleteConfirmationDialog(context);
                  },
                  child: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Jua',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              CustomNavigate().pushRoute(
                context,
                AddProgress(
                  name: name,
                  studentId: studentId,
                  profile: profile,
                ),
              );
            },
            child: const Text(
              'Add today’s progress\n+',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFAB7CE6),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              CustomNavigate().pushRoute(
                  context,
                  ViewProgress(
                    studentId: studentId,
                  ));
            },
            child: const CardButton(),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Delete Student"),
          content: const Text("Are you sure you want to delete this student?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _onDeletePressed(context);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _onDeletePressed(BuildContext context) async {
    final studentCubit = BlocProvider.of<StudentCubit>(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');
    studentCubit.deleteStudent(studentId);
    CoachAuth().deleteStudentFromCoach(userId!, studentId);
  }
}
