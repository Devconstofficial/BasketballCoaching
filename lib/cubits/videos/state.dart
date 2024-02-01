// video_state.dart
part of './cubit.dart';

class VideoState extends Equatable {
  final List<VideoRecord>? data;
  final List<VideoChallenge>? videoChallenges;
  final String? message;

  const VideoState({
    this.data,
    this.videoChallenges,
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

class ChallengeFetchLoading extends VideoState {
  const ChallengeFetchLoading();
}

class ChallengeFetchSuccess extends VideoState {
  const ChallengeFetchSuccess({required List<VideoChallenge> data})
      : super(videoChallenges: data);
}

class ChallengeFetchFailed extends VideoState {
  const ChallengeFetchFailed({String? message}) : super(message: message);
}

class VideoChallenge {
  String? video;
  String type;
  VideoChallenge({
    this.video,
    required this.type,
  });
}
