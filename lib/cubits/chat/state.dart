// messages_state.dart
part of './cubit.dart';

class MessagesState extends Equatable {
  final List<Message>? messages;
  final String? errorMessage;

  const MessagesState({
    this.messages,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [messages, errorMessage];
}

class MessagesInitial extends MessagesState {}

class MessagesLoading extends MessagesState {}

class MessagesLoaded extends MessagesState {
  final List<Message> messages;

  MessagesLoaded({required this.messages});

  @override
  List<Object?> get props => [messages];
}

class MessagesError extends MessagesState {
  final String errorMessage;

  MessagesError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
