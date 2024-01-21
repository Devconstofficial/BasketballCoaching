// performance_state.dart
part of 'cubit.dart';

class PerformanceState extends Equatable {
  final List<PerformanceRecord>? data;
  final String? message;

  PerformanceState({
    this.data,
    this.message,
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


