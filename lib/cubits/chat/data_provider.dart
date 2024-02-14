// messages_data_provider.dart
part of './cubit.dart';

class MessagesDataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<Message>> getMessages() async {
    try {
      final querySnapshot = await _firestore
          .collection('messages')
          .orderBy('time', descending: true)
          .get();
      List<Message> messages = List.generate(
        querySnapshot.docs.length,
        (index) => Message.fromMap(
          querySnapshot.docs[index].id,
          querySnapshot.docs[index].data(),
        ),
      );
      print(messages);
      return messages;
    } catch (e) {
      print("Error fetching messages: $e");
      return [];
    }
  }

  Future<void> sendMessage(Message message) async {
    try {
      final messageMap = message.toMap();
      await _firestore.collection('messages').add(messageMap);
    } catch (e) {
      print("Error sending message: $e");
      throw Exception("Error sending message: $e");
    }
  }

  Future<String> uploadImage(File image) async {
    try {
      final String imageName =
          "messageImage_${DateTime.now().millisecondsSinceEpoch.toString()}.png";
      final Reference storageReference =
          _storage.ref().child('messagesImages/$imageName');

      final UploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.whenComplete(() => null);

      final String imageUrl = await storageReference.getDownloadURL();
      return imageName;
    } catch (e) {
      print("Error uploading image: $e");
      throw Exception("Error uploading image: $e");
    }
  }

  Future<String> uploadVideo(File videoFile) async {
    String fileName =
        "messageVideo_${DateTime.now().millisecondsSinceEpoch}.png";
    try {
      final storage = _storage.ref().child('videos/$fileName');
      await storage.putFile(videoFile);
      return await storage.getDownloadURL();
    } catch (e) {
      throw Exception("Error uploading video: $e");
    }
  }
}
