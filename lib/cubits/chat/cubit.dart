// messages_cubit.dart
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/message.dart';

part './state.dart';
part './data_provider.dart';
part './repository.dart';

class MessagesCubit extends Cubit<MessagesState> {
  final MessagesRepository repository = MessagesRepository();

  MessagesCubit() : super(MessagesInitial());

  Future<List<Message>> getMessages() async {
    emit(MessagesLoading());

    try {
      final messages = await repository.getMessages();
      emit(MessagesLoaded(messages: messages));
      return messages;
    } catch (e) {
      emit(MessagesError(errorMessage: e.toString()));
      return [];
    }
  }

  Future<void> sendMessage({
    required String senderId,
    required String senderName,
    required String content,
    required File? image,
    required File? video,
  }) async {
    try {
      print("ENTERED\n\n MESSAGE \n\nCUBIT");
      final imageUrl = image != null ? await repository.uploadImage(image) : '';
      final videoUrl = video != null ? await repository.uploadVideo(video) : '';
      final urlImage = image != null ? "messagesImages/$imageUrl" : "";

      final message = Message(
        messageId: '',
        senderId: senderId,
        senderName: senderName,
        content: content,
        imageUrl: urlImage,
        videoUrl: videoUrl,
        time: DateTime.now(),
      );

      await repository.sendMessage(message);
      await getMessages();
    } catch (e) {
      emit(MessagesError(errorMessage: e.toString()));
    }
  }
}
