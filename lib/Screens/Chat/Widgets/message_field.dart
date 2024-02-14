import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../../cubits/chat/cubit.dart';
import '../../../models/file_extension.dart';
import '../../../providers/auth_provider.dart';

class MessageField extends StatefulWidget {
  const MessageField({Key? key}) : super(key: key);

  @override
  _MessageFieldState createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedMedia = null;
  TextEditingController messageController = TextEditingController();

  // Future<void> _pickMedia(BuildContext context) async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? mediaFile =
  //       await picker.pickImage(source: ImageSource.gallery);

  //   if (mediaFile != null) {
  //     setState(() {
  //       _selectedMedia = File(mediaFile.path);
  //     });
  //   } else {
  //     final XFile? videoFile =
  //         await picker.pickVideo(source: ImageSource.gallery);

  //     if (videoFile != null) {
  //       setState(() {
  //         _selectedMedia = File(videoFile.path);
  //       });
  //     } else {
  //       // User canceled the picker
  //     }
  //   }
  // }
  Future<void> _pickImage(BuildContext context) async {
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedMedia = imageFile != null ? File(imageFile.path) : null;
    });
  }

  Future<void> _pickVideo(BuildContext context) async {
    final XFile? videoFile =
        await _picker.pickVideo(source: ImageSource.gallery);
    setState(() {
      _selectedMedia = videoFile != null ? File(videoFile.path) : null;
    });
  }

  Future<void> _sendMessage(BuildContext context, String messageText) async {
    MessagesCubit messagesCubit = BlocProvider.of<MessagesCubit>(context);
    final UserAuthProvider authProvider =
        Provider.of<UserAuthProvider>(context, listen: false);

    try {
      messageController.clear();
      if (_selectedMedia != null) {
        if (_selectedMedia!.path.endsWith('.jpg') ||
            _selectedMedia!.path.endsWith('.jpeg') ||
            _selectedMedia!.path.endsWith('.png')) {
          print("ENTERED\n\n\n MEDIA 1");
          // If selected media is an image
          if (messageText.isEmpty || messageText == "") {
            await messagesCubit.sendMessage(
              senderId: authProvider.userId!,
              senderName: authProvider.userName!,
              content: "",
              image: _selectedMedia,
              video: null,
            );
          } else {
            await messagesCubit.sendMessage(
              senderId: authProvider.userId!,
              senderName: authProvider.userName!,
              content: messageText,
              image: _selectedMedia,
              video: null,
            );
          }
        } else if (_selectedMedia!.path.endsWith('.mp4') ||
            _selectedMedia!.path.endsWith('.avi') ||
            _selectedMedia!.path.endsWith('.mov') ||
            _selectedMedia!.path.endsWith('.wmv')) {
          // If selected media is a video
          print("ENTERED\n\n\n MEDIA 1 VIDEO");
          if (messageText.isEmpty || messageText == "") {
            await messagesCubit.sendMessage(
              senderId: authProvider.userId!,
              senderName: authProvider.userName!,
              content: "",
              image: null,
              video: _selectedMedia,
            );
          } else {
            await messagesCubit.sendMessage(
              senderId: authProvider.userId!,
              senderName: authProvider.userName!,
              content: messageText,
              image: null,
              video: _selectedMedia,
            );
          }
        }
      } else if (messageText.isNotEmpty && messageText != "") {
        // If no media selected, send only text message
        print("ENTERED\n\n\n NO MEDIA ");
        await messagesCubit.sendMessage(
          senderId: authProvider.userId!,
          senderName: authProvider.userName!,
          content: messageText,
          image: null,
          video: null,
        );
      }
    } catch (e) {
      print('Error sending message: $e');
    } finally {
      setState(() {
        _selectedMedia = null;
        messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 56,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.camera_alt, color: const Color(0xFF979595)),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return bottomMenu();
                    });
              },
            ),
            Expanded(
              child: TextField(
                controller: messageController,
                decoration: const InputDecoration(
                  hintText: 'Enter Message...',
                  hintStyle: TextStyle(
                    color: const Color(0xFF979595),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                print("ENTERED MESSAGE TAP");
                _sendMessage(context, messageController.text);
              },
              child: Container(
                width: 46,
                height: 46,
                margin: EdgeInsets.only(right: 5),
                decoration: const ShapeDecoration(
                  color: Color(0xFFAB7CE6),
                  shape: OvalBorder(),
                ),
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomMenu() {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 170,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(
              Icons.image,
              color: Color(0xFFAB7CE6),
            ),
            title: const Text('Pick Image'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.video_call,
              color: Color(0xFFAB7CE6),
            ),
            title: const Text('Pick Video'),
            onTap: () {
              Navigator.pop(context);
              _pickVideo(context);
            },
          ),
        ],
      ),
    );
  }
}
