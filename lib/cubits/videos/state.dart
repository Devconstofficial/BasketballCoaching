// video_state.dart
part of './cubit.dart';

class VideoState extends Equatable {
  final List<VideoRecord>? data;
  final String? message;

  const VideoState({
    this.data,
    this.message,
  });

  @override
  List<Object?> get props => [data, message];
}

class VideoDefault extends VideoState {}

class VideoFetchLoading extends VideoState {
  const VideoFetchLoading();
}

class VideoFetchSuccess extends VideoState {
  const VideoFetchSuccess({required List<VideoRecord> data})
      : super(data: data);
}

class VideoFetchFailed extends VideoState {
  const VideoFetchFailed({String? message}) : super(message: message);
}
