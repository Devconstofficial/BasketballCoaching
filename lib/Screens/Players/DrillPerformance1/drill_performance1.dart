import 'dart:io';
import 'dart:typed_data';

import 'package:basketball_coaching/Components/back_button.dart';
import 'package:basketball_coaching/Components/clock_timer.dart';
import 'package:basketball_coaching/Components/no_media_picked.dart';
import 'package:basketball_coaching/Screens/Players/DrillPerformance1/Widgets/emoji_slider.dart';
import 'package:basketball_coaching/Components/main_button.dart';
import 'package:basketball_coaching/Screens/Players/DrillProgress/drill_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../Components/my_snackbar.dart';
import '../../../Components/video_player_screen.dart';
import '../../../app_navigations/custom_navigate.dart';
import '../../../cubits/performance/cubit.dart';
import '../../../models/file_extension.dart';

class DrillPerformance1 extends StatefulWidget {
  final int? coveredMinutes;
  final int? coveredSeconds;
  final String drillName;
  const DrillPerformance1({
    this.coveredMinutes,
    this.coveredSeconds,
    required this.drillName,
    super.key,
  });

  @override
  State<DrillPerformance1> createState() => _DrillPerformance1State();
}

class _DrillPerformance1State extends State<DrillPerformance1> {
  String studentId = "STD1006345";
  int selectedMinutes = 0;
  int selectedSeconds = 0;
  double emojiSliderValue = 0.0;
  bool hasVideo = false;

  File? file;
  final PerformanceCubit _performanceCubit = PerformanceCubit();
  final ImagePicker picker = ImagePicker();
  TextEditingController drillsController = TextEditingController();

  Future<void> pickMedia() async {
    final mediaFile = await picker.pickVideo(source: ImageSource.gallery);

    if (mediaFile != null) {
      final file = File(mediaFile.path);
      setState(() {
        this.file = file;
        hasVideo = true;
      });
    } else {
      // User canceled the picker
    }
  }

  Future<Uint8List?> _generateThumbnail(File file) async {
    final thumbnailAsUint8List = await VideoThumbnail.thumbnailData(
      video: file.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 320,
      quality: 50,
    );
    return thumbnailAsUint8List!;
  }

  Future<ImageProvider<Object>>? _imageProvider(File file) async {
    if (file.fileType == FileType.video) {
      final thumbnail = await _generateThumbnail(file);
      return MemoryImage(thumbnail!);
    } else if (file.fileType == FileType.image) {
      return FileImage(file);
    } else {
      throw Exception("Unsupported media format");
    }
  }

  Future<void> addPerformance(BuildContext context) async {
    String filePath = file?.path ?? "";
    try {
      await _performanceCubit.addPerformanceRecord(
        studentId,
        file ?? File(""),
        (filePath.isNotEmpty) ? filePath.split('/').last : "",
        selectedMinutes,
        selectedSeconds,
        widget.drillName,
        "",
        (emojiSliderValue * 100).toInt(),
        [],
      );
      print(emojiSliderValue * 100);
      SnackBarHelper.showSnackbar(context, "Record added Successfully");
    } catch (e) {
      SnackBarHelper.showSnackbar(context, "Error Adding Records");
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.coveredMinutes != 0) {
      setState(() {
        selectedMinutes = widget.coveredMinutes!;
      });
    }
    if (widget.coveredSeconds != null) {
      setState(() {
        selectedSeconds = widget.coveredSeconds!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MyBackButton(),
        leadingWidth: 100.w,
        title: Padding(
          padding: EdgeInsets.only(left: 7.w),
          child: Text(
            "${widget.drillName} performance",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
        ),
        toolbarHeight: 50,
        backgroundColor: const Color(0xFFF5F5F5),
        surfaceTintColor: const Color(0xFFF5F5F5),
        shadowColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 10.w,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (hasVideo == true) {
                        setState(() {
                          hasVideo = !hasVideo;
                          file!.path == null;
                          file == null;
                        });
                      }
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            'assets/images/delete.svg',
                          ),
                          SizedBox(
                            width: 8.5.w,
                          ),
                          Text(
                            'delete',
                            style: TextStyle(
                              color: const Color(0xFFA43434),
                              fontSize: 10.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: !hasVideo
                        ? const NoMediaPicked()
                        : GestureDetector(
                            onTap: () {
                              CustomNavigate()
                                  .pushRoute(context, VideoPlayerScreen(file!));
                            },
                            child: Hero(
                              tag: file!.path,
                              child: Stack(
                                children: [
                                  FutureBuilder<ImageProvider>(
                                    future: _imageProvider(file!),
                                    builder: (context, snapshot) {
                                      if (snapshot.data != null &&
                                          snapshot.connectionState ==
                                              ConnectionState.done) {
                                        return Container(
                                          height: 220,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(9),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: snapshot.data!,
                                            ),
                                          ),
                                        );
                                      }
                                      return const NoMediaPicked();
                                    },
                                  ),
                                  Positioned.fill(
                                    child: Center(
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.play_circle_fill,
                                          color: Colors.black,
                                          size: 50,
                                        ),
                                        onPressed: () {
                                          CustomNavigate().pushRoute(context,
                                              VideoPlayerScreen(file!));
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/attach.svg',
                      ),
                      SizedBox(
                        width: 9.w,
                      ),
                      TextButton(
                        onPressed: pickMedia,
                        child: Text(
                          'attach video',
                          style: TextStyle(
                            color: const Color(0xFF979595),
                            fontSize: 12.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                'Did you do well ??',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontFamily: 'Jua',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Center(
              child: Text(
                'Enter what you achieved today',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontFamily: 'Jua',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            SizedBox(
              height: 14.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Text(
                        'How many times did you \nperformed the drill?',
                        style: TextStyle(
                          color: const Color(0xFF7A787B),
                          fontSize: 12.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                    EmojiSlider(
                      onValueChanged: (value) {
                        setState(() {
                          emojiSliderValue = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Text(
                        'Time Out',
                        style: TextStyle(
                          color: const Color(0xFF7A787B),
                          fontSize: 12.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: ClockTimer(
                        initialMinutes: widget.coveredMinutes,
                        initialSeconds: widget.coveredSeconds,
                        onTimeSelected: (minutes, seconds) {
                          setState(() {
                            selectedMinutes = minutes;
                            selectedSeconds = seconds;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                  ],
                ),
                SizedBox(
                  width: 1.w,
                ),
                Stack(
                  children: [
                    Image.asset(
                      'assets/images/selection.png',
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Image.asset(
                'assets/images/sorry.png',
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            InkWell(
              onTap: () {
                if (emojiSliderValue * 100 == 0 ||
                    widget.drillName == "" ||
                    (selectedMinutes == 0 && selectedSeconds == 0)) {
                  SnackBarHelper.showSnackbar(context,
                      "Drill, Time and No. of times performed is required");
                } else {
                  addPerformance(context);
                  CustomNavigate().pushRoute(
                      context,
                      DrillProgress(
                        studentId: studentId,
                        drillName: widget.drillName,
                      ));
                }
              },
              child: const MainButton(text: 'Add Progress'),
            ),
            SizedBox(
              height: 20.w,
            )
          ]),
        ),
      ),
    );
  }
}
