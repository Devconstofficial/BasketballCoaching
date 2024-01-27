import 'package:basketball_coaching/Components/back_button.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class FirebaseVideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const FirebaseVideoPlayerScreen(this.videoUrl, {Key? key}) : super(key: key);

  @override
  _FirebaseVideoPlayerScreenState createState() =>
      _FirebaseVideoPlayerScreenState();
}

class _FirebaseVideoPlayerScreenState extends State<FirebaseVideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController,
            autoPlay: true,
            looping: false,
            allowFullScreen: true,
            aspectRatio: _videoPlayerController.value.aspectRatio,
          );
        });
      });

    // Initialize _chewieController to avoid LateInitializationError
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      allowFullScreen: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.black,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.black,
        shadowColor: Colors.black,
        elevation: 0,
        leading: const MyBackButton(),
        leadingWidth: 100,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: _chewieController != null
            ? Chewie(
                controller: _chewieController,
              )
            : const CircularProgressIndicator(),
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
