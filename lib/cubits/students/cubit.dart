// cubit.dart
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  Future<void> deleteStudent(String studentId) async {
    try {
      await repository.deleteStudent(studentId);
      getAllStudents(); 
    } catch (e) {
      emit(StudentFetchFailed(message: e.toString()));
    }
  }

  Future<void> updateProfile(String studentId, String newProfile) async {
    try {
      await repository.updateProfile(studentId, newProfile);
      getAllStudents(); 
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

  Future<void> createNewStudent() async {
    try {
      final newStudent = await repository.createNewStudent();
      getAllStudents(); 
      emit(StudentCreationSuccess(newStudent: newStudent));
    } catch (e) {
      emit(StudentFetchFailed(message: e.toString()));
    }
  }
}
