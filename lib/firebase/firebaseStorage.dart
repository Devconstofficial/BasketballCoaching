import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final storageRef = FirebaseStorage.instance.ref();

Future<String> getImageUrl(String imagePath) async {
  try {
    final path = storageRef.child(imagePath);
    final downloadUrl = await path.getDownloadURL();
    return downloadUrl;
  } catch (e) {
    throw Exception('Failed to get image URL');
  }
}

Future<List<String>> getAllDrillsNames(String documentId) async {
  List<String> documentIds = [];

  try {
    CollectionReference mainCollectionRef =
        FirebaseFirestore.instance.collection('students');
    QuerySnapshot subCollectionSnapshot =
        await mainCollectionRef.doc(documentId).collection('performance').get();
    subCollectionSnapshot.docs.forEach((DocumentSnapshot document) {
      documentIds.add(document.id);
    });
    return documentIds;
  } catch (e) {
    return [];
  }
}

Future<List<String>> getOtherDrillsNames(String documentId) async {
  List<String> drillNames = [];

  try {
    CollectionReference mainCollectionRef =
        FirebaseFirestore.instance.collection('students');
    QuerySnapshot subCollectionSnapshot =
        await mainCollectionRef.doc(documentId).collection('performance').get();

    subCollectionSnapshot.docs.forEach((DocumentSnapshot document) {
      if (document.id != 'pull up' &&
          document.id != 'bank shot' &&
          document.id != 'cone') {
        drillNames.add(document.id);
      }
    });
    print(drillNames);
    return drillNames;
  } catch (e) {
    return [];
  }
}

Future<String> uploadVideo(File videoFile, String fileName) async {
  try {
    final storage = storageRef.child('videos/$fileName');
    await storage.putFile(videoFile);
    return await storage.getDownloadURL();
  } catch (e) {
    throw Exception("Error uploading video: $e");
  }
}

//uploading screenshot of score board
Future<String> uploadImageToFirebaseStorage(
    Uint8List imageBytes, String studentName) async {
  String fileName =
      'scoreboard_${studentName}_${DateTime.now().millisecondsSinceEpoch}.png';
  String storagePath = 'leaderboards/$fileName';
  final Reference storageRef =
      FirebaseStorage.instance.ref().child(storagePath);
  await storageRef.putData(imageBytes);
  String downloadURL = storagePath;
  return downloadURL;
}
