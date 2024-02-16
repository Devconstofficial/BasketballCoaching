// video_cubit.dart
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/video_record.dart';

part './data_provider.dart';
part './repository.dart';
part './state.dart';

class VideoCubit extends Cubit<VideoState> {
  final VideoRepository repository = VideoRepository();

  VideoCubit() : super(VideoDefault());

  Future<void> getAllVideos(String studentId, String type) async {
    emit(const VideoFetchLoading());
    try {
      final data = await repository.getAllVideos(studentId, type);
      emit(VideoFetchSuccess(data: data));
    } catch (e) {
      emit(VideoFetchFailed(message: e.toString()));
    }
  }

  Future<void> uploadVideo(VideoRecord videoRecord, String studentId) async {
    try {
      await repository.uploadVideo(videoRecord, studentId);
      getAllVideos(studentId, videoRecord.type!);
    } catch (e) {
      emit(VideoFetchFailed(message: e.toString()));
    }
  }

  Future<void> getOtherVideoChallenges(
      String studentId, List<String> types) async {
    emit(const ChallengeFetchLoading());
    try {
      final data = await repository.getOtherVideoChallenges(studentId, types);
      emit(ChallengeFetchSuccess(challenges: data));
    } catch (e) {
      emit(ChallengeFetchFailed(message: e.toString()));
    }
  }
}
