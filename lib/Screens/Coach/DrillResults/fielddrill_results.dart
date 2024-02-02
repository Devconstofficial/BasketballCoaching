import 'dart:typed_data';

import 'package:basketball_coaching/Components/back_button.dart';
import 'package:basketball_coaching/Components/firebase_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../../Components/firebaseImageWidget.dart';
import '../../../app_navigations/custom_navigate.dart';

class FieldDrill extends StatefulWidget {
  final String videoFile;
  final String? leaderboard;
  const FieldDrill({
    super.key,
    required this.videoFile,
    this.leaderboard,
  });

  @override
  State<FieldDrill> createState() => _FieldDrillState();
}

class _FieldDrillState extends State<FieldDrill> {
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
    _generateThumbnailFromUrl(widget.videoFile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: const Color(0xFFF5F5F5),
        foregroundColor: const Color(0xFFF5F5F5),
        surfaceTintColor: const Color(0xFFF5F5F5),
        shadowColor: Colors.white,
        elevation: 0,
        leading: const MyBackButton(),
        leadingWidth: 100,
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  CustomNavigate().pushRoute(
                      context, FirebaseVideoPlayerScreen(widget.videoFile));
                },
                child: Hero(
                  tag: widget.videoFile,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: FutureBuilder<Uint8List?>(
                      future: _generateThumbnailFromUrl(widget.videoFile),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return Stack(
                            children: [
                              ClipRRect(
                                child: Image.memory(
                                  snapshot.data!,
                                  width: MediaQuery.of(context).size.width * 1,
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
                                      CustomNavigate().pushRoute(
                                          context,
                                          FirebaseVideoPlayerScreen(
                                              widget.videoFile));
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 19.h,
              ),
              Center(
                child: Text(
                  'Field Statistics',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26.sp,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
              SizedBox(
                height: 19.h,
              ),
              widget.leaderboard == null || widget.leaderboard!.isEmpty
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 100,
                      child: const Center(
                        child: Text(
                          "No Leaderboard",
                          style: TextStyle(
                            color: Color(0xFFAB7CE6),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: 600,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(211, 107, 56, 1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 600,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(211, 107, 56, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: FirebaseNetworkImage(
                              imagePath: widget.leaderboard!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(
                height: 30.w,
              )
            ],
          ),
        ),
      ),
    );
  }
}
