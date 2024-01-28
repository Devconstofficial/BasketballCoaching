// performance_state.dart
part of 'cubit.dart';

class PerformanceState extends Equatable {
  final List<PerformanceRecord>? data;
  final String? message;
  final List<Map<String, dynamic>>? daysPerformance;

  PerformanceState({
    this.data,
    this.message,
    this.daysPerformance,
  });

  @override
  List<Object?> get props => [data, message];
}

class PerformanceDefault extends PerformanceState {}

class PerformanceFetchLoading extends PerformanceState {
  PerformanceFetchLoading();
}

class PerformanceFetchFailed extends PerformanceState {
  PerformanceFetchFailed({String? message}) : super(message: message);
}

class PerformanceAddRecordFailed extends PerformanceState {
  PerformanceAddRecordFailed({String? message}) : super(message: message);
}

class PerformanceFetchSuccess extends PerformanceState {
  final List<PerformanceRecord> data;

  PerformanceFetchSuccess({required this.data}) : super(data: data);
}

// New states for handling List<int> data
class PerformanceListLoading extends PerformanceState {
  PerformanceListLoading();
}

class PerformanceListFetchFailed extends PerformanceState {
  PerformanceListFetchFailed({String? message}) : super(message: message);
}

class PerformanceListFetchSuccess extends PerformanceState {
  final List<Map<String, dynamic>> dataList;

  PerformanceListFetchSuccess({required this.dataList})
      : super(daysPerformance: dataList);

  @override
  List<Object?> get props => [dataList];
}
