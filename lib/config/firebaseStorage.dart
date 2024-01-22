import 'package:firebase_storage/firebase_storage.dart';

final storageRef = FirebaseStorage.instance.ref();

Future<String> getImageUrl(String imagePath) async {
  try {
    final path = storageRef.child(imagePath);
    final downloadUrl = await path.getDownloadURL();
    return downloadUrl;
  } catch (e) {
    print('Error getting image URL: $e');
    throw Exception('Failed to get image URL');
  }
}
