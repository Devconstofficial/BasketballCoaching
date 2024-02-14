import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../../Components/firebaseImageWidget.dart';
import '../../../Components/firebase_video_player.dart';
import '../../../app_navigations/custom_navigate.dart';
import '../../../cubits/chat/cubit.dart';
import '../../../models/message.dart';
import '../../../providers/auth_provider.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  List<Message> oldMessages = [];
  Future<Uint8List?> _generateThumbnailFromUrl(String videoUrl) async {
    try {
      final thumbnailAsUint8List = await VideoThumbnail.thumbnailData(
        video: videoUrl,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 320,
        quality: 50,
      );
      return thumbnailAsUint8List;
    } catch (e) {
      print('Error generating thumbnail: $e');
      return null;
    }
  }

  @override
  initState() {
    super.initState();
    getMessages();
  }

  Future<void> getMessages() async {
    MessagesCubit messageCubit = BlocProvider.of<MessagesCubit>(context);
    List<Message> newMessages = await messageCubit.getMessages();

    setState(() {
      oldMessages.addAll(newMessages);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagesCubit, MessagesState>(
      builder: (context, state) {
        if (state is MessagesLoading) {
          return _buildMessages(oldMessages);
        } else if (state is MessagesLoaded) {
          return _buildMessages(state.messages);
        } else if (state is MessagesError) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        } else {
          return const Center(child: Text('Unknown state'));
        }
      },
    );
  }

  Widget _buildMessages(List<Message> messages) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: messages.reversed.map((message) {
        return _buildMessageCard(context, message);
      }).toList(),
    );
  }

  Widget _buildMessageCard(BuildContext context, Message message) {
    final UserAuthProvider authProvider =
        Provider.of<UserAuthProvider>(context, listen: false);
    final isYou = message.senderName == authProvider.userName;
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10),
      child: Align(
        alignment: isYou ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment:
                isYou ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isYou) _buildSenderAvatar(message.senderName),
              SizedBox(width: 8.w),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x3F000000),
                        blurRadius: 4.r,
                        offset: const Offset(0, 1),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w, left: 10.w, top: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isYou ? 'You' : '~${message.senderName}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: message.senderName == authProvider.userName
                                ? const Color(0xFFAB7CE6)
                                : const Color(0xFF8A898A),
                            fontSize: 12.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        if (message.videoUrl.isNotEmpty ||
                            message.imageUrl.isNotEmpty) ...[
                          if (message.videoUrl.isNotEmpty) ...[
                            _buildMediaWidget(context, message, "video"),
                          ] else if (message.imageUrl.isNotEmpty) ...[
                            _buildMediaWidget(context, message, "image"),
                          ]
                        ],
                        if (message.content.isNotEmpty)
                          Text(
                            message.content,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 12.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                            maxLines: 50,
                            overflow: TextOverflow.ellipsis,
                          ),
                        Padding(
                          padding: EdgeInsets.only(left: 180.w),
                          child: Text(
                            '${DateFormat('h:mm a').format(message.time)}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF8A898A),
                              fontSize: 10.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (isYou) SizedBox(width: 8.w),
              if (isYou) _buildSenderAvatar(message.senderName),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSenderAvatar(String senderName) {
    return Container(
      width: 44.w,
      height: 44.h,
      decoration: const ShapeDecoration(
        image: DecorationImage(
          image: ExactAssetImage('assets/images/profile.png'),
          fit: BoxFit.fill,
        ),
        shape: OvalBorder(),
      ),
    );
  }

  Widget _buildMediaWidget(BuildContext context, Message message, String type) {
    if (type == 'video') {
      return GestureDetector(
        onTap: () {
          CustomNavigate()
              .pushRoute(context, FirebaseVideoPlayerScreen(message.videoUrl));
        },
        child: Hero(
          tag: message.videoUrl,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FutureBuilder<Uint8List?>(
              future: _generateThumbnailFromUrl(message.videoUrl),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Stack(
                    children: [
                      ClipRRect(
                        child: Image.memory(
                          snapshot.data!,
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        child: Center(
                          child: IconButton(
                            icon: const Icon(
                              Icons.play_circle_fill,
                              color: Colors.black,
                              size: 80,
                            ),
                            onPressed: () {
                              CustomNavigate().pushRoute(context,
                                  FirebaseVideoPlayerScreen(message.videoUrl));
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      );
    } else if (type == 'image') {
      print("IMAGE FILE \n\n\n  ${message.imageUrl}");
      return Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: 250,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(211, 107, 56, 1),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/imageFile.jpg')),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: FirebaseNetworkImage(
            imagePath: message.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    return SizedBox();
  }
}
