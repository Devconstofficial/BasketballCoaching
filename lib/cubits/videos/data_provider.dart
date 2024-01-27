// video_data_provider.dart
part of './cubit.dart';

class VideoDataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<VideoRecord>> getAllVideos(String studentId, String type) async {
    try {
      final querySnapshot =
          await _firestore.collection('videos').doc(studentId).get();
      List data = querySnapshot['videos'];
      List<VideoRecord> videos = List.generate(data.length, (index) {
        DateTime dateTime = (data[index]['date'] as Timestamp).toDate();

        String date = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
        return VideoRecord.fromMap(
          data[index]..['dateTime'] = date,
        );
      });

      videos =
          videos.where((video) => video.type == type.toLowerCase()).toList();
      return videos;
    } catch (e) {
      print("Error fetching videos: $e");
      return [];
    }
  }

  Future<void> uploadVideo(VideoRecord videoRecord, String studentId) async {
    try {
      final studentDocRef = _firestore.collection('videos').doc(studentId);

      final newVideoMap = {
        'date': Timestamp.fromDate(videoRecord.date),
        'file': videoRecord.file,
        'leaderboard': videoRecord.leaderboard,
        'type': videoRecord.type,
      };

      final studentDocSnapshot = await studentDocRef.get();

      if (studentDocSnapshot.exists) {
        await studentDocRef.update({
          'videos': FieldValue.arrayUnion([newVideoMap]),
        });
      } else {
        await studentDocRef.set({
          'videos': [newVideoMap],
        });
      }
    } catch (e) {
      throw Exception("Error uploading video: $e");
    }
  }
}
