// performance_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/performance.dart';

part './state.dart';
part './data_provider.dart';
part './repository.dart';

class PerformanceCubit extends Cubit<PerformanceState> {
  final PerformanceRepository repository = PerformanceRepository();

  PerformanceCubit() : super(PerformanceDefault());

  Future<void> fetchPerformanceRecords(String studentId, String drillName) async {
    emit(PerformanceFetchLoading());
    try {
      final data = await repository.getPerformanceRecords(studentId, drillName);
      emit(PerformanceFetchSuccess(data: data));
    } catch (e) {
      emit(PerformanceFetchFailed(message: 'Error fetching performance records'));
    }
  }

  Future<void> addPerformanceRecord(String studentId, String drillName, PerformanceRecord record) async {
    try {
      await repository.addPerformanceRecord(studentId, drillName, record);
    } catch (e) {
      emit(PerformanceAddRecordFailed(message: e.toString()));
    }
  }
}
