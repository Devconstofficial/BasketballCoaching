// video_data_provider.dart
part of './cubit.dart';

class VideoDataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<VideoRecord>> getAllVideos(String studentId, String type) async {
    try {
      final querySnapshot =
          await _firestore.collection('videos').doc(studentId).get();
      List data = querySnapshot['videos'];
      List<VideoRecord> videos = List.generate(
          data.length, (index) => VideoRecord.fromMap(data[index]));
      if (type.isNotEmpty) {
        videos = videos.where((video) => video.type == type).toList();
      }
      return videos;
    } catch (e) {
      print("Error fetching videos: $e");
      return [];
    }
  }

  Future<void> uploadVideo(VideoRecord videoRecord, String studentId) async {
    try {
      final documentRef = _firestore.collection('videos').doc(studentId);

      final videoList = await documentRef
          .get()
          .then((snapshot) => snapshot['videos'] as List?);

      if (videoList != null) {
        videoList.add(videoRecord.toMap());
        await documentRef.update({'videos': videoList});
      } else {
        await documentRef.set({
          'videos': [videoRecord.toMap()]
        });
      }
    } catch (e) {
      throw Exception("Error uploading video: $e");
    }
  }
}
