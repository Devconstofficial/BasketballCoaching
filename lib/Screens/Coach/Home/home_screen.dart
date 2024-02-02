import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Components/dialog_box.dart';
import '../../../cubits/students/cubit.dart';
import '../../../models/student.dart';
import 'Widgets/student_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentCubit()..getAllStudents(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: BlocBuilder<StudentCubit, StudentState>(
          builder: (context, state) {
            if (state is StudentFetchLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is StudentFetchSuccess) {
              final List<Student> studentsData = state.data!.toList();
              return buildStudentGrid(context, studentsData);
            } else if (state is StudentFetchFailed) {
              return Center(
                child: Text('Error: ${state.message}'),
              );
            } else {
              return const Center(
                child: Text('Unexpected state'),
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildStudentGrid(BuildContext context, List<Student> students) {
    return Padding(
      padding: const EdgeInsets.only(left: 19, right: 19, top: 55),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              'My Team',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontFamily: 'Jua',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () async {
                  final studentCubit = BlocProvider.of<StudentCubit>(context);

                  TextEditingController nameController =
                      TextEditingController();
                  String? studentName = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Enter Student Name"),
                      content: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "Enter name",
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(nameController.text);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );

                  if (studentName != null) {
                    final student = await studentCubit.createNewStudent(
                      studentName,
                      "C111222",
                    );
                    final String studentId = student.studentId;
                    showCustomDialog(context, 'Student ID: $studentId');
                    studentCubit.getAllStudents();
                  }
                },
                child: const Icon(
                  Icons.add,
                  color: Color(0xFFAB7CE6),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.9,
              ),
              itemCount: students.length,
              itemBuilder: (context, index) {
                return StudentsCard(
                  name: students[index].name,
                  studentId: students[index].studentId,
                  profile: students[index].profile,
                );
              },
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
