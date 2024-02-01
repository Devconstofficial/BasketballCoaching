// video_repository.dart
part of './cubit.dart';

class VideoRepository {
  final VideoDataProvider dataProvider = VideoDataProvider();

  Future<List<VideoRecord>> getAllVideos(String studentId, String type) async {
    try {
      return await dataProvider.getAllVideos(studentId, type);
    } catch (e) {
      throw Exception("Error fetching videos: $e");
    }
  }

  Future<void> uploadVideo(VideoRecord videoRecord, String studentId) async {
    try {
      await dataProvider.uploadVideo(videoRecord, studentId);
    } catch (e) {
      throw Exception("Error uploading video: $e");
    }
  }

  Future<List<VideoChallenge>> getOtherVideoChallenges(
      String studentId, List<String> types) async {
    try {
      return await dataProvider.getOtherVideoChallenges(studentId, types);
    } catch (e) {
      throw Exception("Error fetching challenges$e");
    }
  }
}
