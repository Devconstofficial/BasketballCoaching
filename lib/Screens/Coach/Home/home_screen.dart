import 'package:basketball_coaching/cubits/students/cubit.dart';
import 'package:basketball_coaching/models/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:basketball_coaching/screens/coach/home/widgets/student_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    final studentCubit = BlocProvider.of<StudentCubit>(context);
    if (studentCubit.state.data == null ||
        studentCubit.state.data!.isEmpty) {
      studentCubit.getAllStudents();
    }
    
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    backgroundColor: const Color(0xFFF5F5F5),
    body: BlocBuilder<StudentCubit, StudentState>(
      builder: (context, state) {
        if (state is StudentFetchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is StudentFetchSuccess) {
          final List<Student> studentsData = state.data!.toList(); 
          return buildStudentGrid(studentsData);
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
  );
  }

  Widget buildStudentGrid(List<Student> students) {
    return SingleChildScrollView(
      child: Padding(
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
            SizedBox(
              height: 700,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
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
      ),
    );
  }
}
