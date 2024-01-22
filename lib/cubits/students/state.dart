// state.dart
part of 'cubit.dart';

class StudentState extends Equatable {
  final List<Student>? data; // Update the data type
  final String? message;
  final Student? newStudent;

  const StudentState({
    this.data,
    this.message,
    this.newStudent,
  });

  @override
  List<Object?> get props => [data, message, newStudent];
}

class StudentDefault extends StudentState {}

class StudentFetchLoading extends StudentState {
  const StudentFetchLoading();
}

class StudentFetchSuccess extends StudentState {
  const StudentFetchSuccess({required List<Student> data}) : super(data: data);
  // Update the constructor parameter type
}

class StudentCreationSuccess extends StudentState {
  final Student newStudent;

  const StudentCreationSuccess({required this.newStudent}) : super(newStudent: newStudent);

  @override
  List<Object?> get props => [newStudent];
}

class StudentFetchFailed extends StudentState {
  const StudentFetchFailed({String? message}) : super(message: message);
}
