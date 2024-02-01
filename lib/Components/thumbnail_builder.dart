import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';

class ThumbnailBuilder extends StatefulWidget {
  final String? file;

  const ThumbnailBuilder({
    required this.file,
    Key? key,
  });

  @override
  State<ThumbnailBuilder> createState() => _ThumbnailBuilderState();
}

class _ThumbnailBuilderState extends State<ThumbnailBuilder> {
  Future<Uint8List?> _generateThumbnailFromLocalVideo(
      String localVideoPath) async {
    try {
      final thumbnailAsUint8List = await VideoThumbnail.thumbnailData(
        video: localVideoPath,
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

  Future<String> _downloadVideo(String videoUrl) async {
    try {
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.refFromURL(videoUrl);

      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final String videoPath = '${appDocDir.path}/video.mp4';

      await ref.writeToFile(File(videoPath));

      return videoPath;
    } catch (e) {
      print('Error downloading video: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _downloadVideo(widget.file!),
      builder: (context, downloadSnapshot) {
        if (downloadSnapshot.connectionState == ConnectionState.done) {
          final localVideoPath = downloadSnapshot.data;

          return FutureBuilder<Uint8List?>(
            future: _generateThumbnailFromLocalVideo(localVideoPath!),
            builder: (context, thumbnailSnapshot) {
              if (thumbnailSnapshot.data != null) {
                return Image.memory(
                  thumbnailSnapshot.data!,
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  fit: BoxFit.cover,
                );
              } else {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 250,
                  child: const Center(child: CircularProgressIndicator()),
                );
              }
            },
          );
        } else {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 250,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
