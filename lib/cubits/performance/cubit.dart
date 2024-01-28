import 'dart:io';
import 'package:basketball_coaching/firebase/firebaseStorage.dart';
import 'package:basketball_coaching/cubits/videos/cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../models/performance.dart';
import '../../models/video_record.dart';
part './state.dart';
part './data_provider.dart';
part './repository.dart';

class PerformanceCubit extends Cubit<PerformanceState> {
  final PerformanceRepository repository = PerformanceRepository();

  PerformanceCubit() : super(PerformanceDefault());

  Future<void> fetchPerformanceRecords(
      String studentId, String drillName) async {
    emit(PerformanceFetchLoading());
    try {
      final data = await repository.getPerformanceRecords(studentId, drillName);
      emit(PerformanceFetchSuccess(data: data));
    } catch (e) {
      emit(PerformanceFetchFailed(
          message: 'Error fetching performance records'));
    }
  }

  Future<void> addPerformanceRecord(
    String studentId,
    File videoFile,
    String fileName,
    int selectedMinutes,
    int selectedSeconds,
    String selectedDrill,
    String leaderboard,
    int number,
    List<int> scores,
  ) async {
    try {
      await repository.addPerformanceRecord(
          studentId,
          videoFile,
          fileName,
          selectedMinutes,
          selectedSeconds,
          selectedDrill,
          leaderboard,
          number,
          scores);
    } catch (e) {
      emit(PerformanceAddRecordFailed(message: e.toString()));
    }
  }

  Future<void> getLast7DaysTotalNumbers(
      String studentId, String drillName) async {
    emit(PerformanceListLoading());
    try {
      final data =
          await repository.getLast7DaysTotalNumbers(studentId, drillName);
      emit(PerformanceListFetchSuccess(dataList: data));
    } catch (e) {
      emit(PerformanceListFetchFailed(message: e.toString()));
    }
  }
}
