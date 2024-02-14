// messages_repository.dart
part of './cubit.dart';

class MessagesRepository {
  final MessagesDataProvider dataProvider = MessagesDataProvider();

  Future<List<Message>> getMessages() async {
    try {
      return await dataProvider.getMessages();
    } catch (e) {
      throw Exception("Error fetching messages: $e");
    }
  }

  Future<void> sendMessage(Message message) async {
    try {
      await dataProvider.sendMessage(message);
    } catch (e) {
      throw Exception("Error sending message: $e");
    }
  }

  Future<String> uploadImage(File image) async {
    try {
      return await dataProvider.uploadImage(image);
    } catch (e) {
      throw Exception("Error uploading image: $e");
    }
  }

  Future<String> uploadVideo(File video) async {
    try {
      return await dataProvider.uploadVideo(video);
    } catch (e) {
      throw Exception("Error uploading video: $e");
    }
  }
}
