// cubit.dart
import 'dart:async';
import 'dart:math';

import 'package:basketball_coaching/firebase/coach_methods.dart';
import 'package:basketball_coaching/models/coach.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/student.dart';

part 'data_provider.dart';
part 'repository.dart';
part 'state.dart';

class StudentCubit extends Cubit<StudentState> {
  final StudentRepository repository = StudentRepository();

  StudentCubit() : super(StudentDefault());

  Future<void> getAllStudents() async {
    emit(const StudentFetchLoading());
    try {
      final data = await repository.getAllStudents();
      print('Inside Cubit');
      emit(StudentFetchSuccess(data: data));
    } catch (e) {
      emit(StudentFetchFailed(message: e.toString()));
    }
  }

  Future<Student?> getStudentById(String studentId) async {
    emit(const StudentFetchLoading());
    try {
      final data = await repository.getStudentById(studentId);
      return data;
    } catch (e) {
      emit(StudentFetchFailed(message: e.toString()));
      return null;
    }
  }

  Future<void> deleteStudent(String studentId) async {
    try {
      await repository.deleteStudent(studentId);
      await repository.removeStudentFromCoach(studentId);
      getAllStudents();
    } catch (e) {
      emit(StudentFetchFailed(message: e.toString()));
    }
  }

  Future<void> updateProfile(String studentId, String newProfile) async {
    try {
      await repository.updateProfile(studentId, newProfile);
    } catch (e) {
      emit(StudentFetchFailed(message: e.toString()));
    }
  }

  Future<void> updateTotalScore(String studentId, double newTotalScore) async {
    try {
      await repository.updateTotalScore(studentId, newTotalScore);
      getAllStudents();
    } catch (e) {
      emit(StudentFetchFailed(message: e.toString()));
    }
  }

  Future<Student> createNewStudent(String name, String coachId) async {
    try {
      final newStudent = await repository.createNewStudent(name, coachId);
      getAllStudents();
      emit(StudentCreationSuccess(newStudent: newStudent));
      return newStudent;
    } catch (e) {
      emit(StudentFetchFailed(message: e.toString()));
      throw Exception(e);
    }
  }
}
