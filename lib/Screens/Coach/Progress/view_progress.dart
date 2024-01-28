import 'dart:io';
import 'dart:typed_data';
import 'package:basketball_coaching/Screens/Coach/coach_navbar.dart';
import 'package:http/http.dart' as http;
import 'package:basketball_coaching/Screens/Coach/DrillResults/fielddrill_results.dart';
import 'package:basketball_coaching/Components/back_button.dart';
import 'package:basketball_coaching/Screens/Coach/Home/home_screen.dart';
import 'package:basketball_coaching/Screens/Coach/Progress/Widgets/performance_comparison.dart';
import 'package:basketball_coaching/app_navigations/custom_navigate.dart';
import 'package:basketball_coaching/firebase/firebaseStorage.dart';
import 'package:basketball_coaching/cubits/videos/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'Widgets/drop_down.dart';

class ViewProgress extends StatefulWidget {
  final String studentId;
  const ViewProgress({
    super.key,
    required this.studentId,
  });

  @override
  State<ViewProgress> createState() => _ViewProgressState();
}

class _ViewProgressState extends State<ViewProgress> {
  String? selectedDrill;
  bool resultsFetched = false;
  bool hasVideos = false;
  List<String> documentIds = [];

  Future<void> drillNames() async {
    var drills = await getAllDrillsNames(widget.studentId);
    setState(() {
      documentIds = drills;
    });
  }

  @override
  initState() {
    super.initState();
    drillNames();
  }

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
  Widget build(BuildContext context) {
    Future<void> fetchAllVideos() async {
      VideoCubit videoCubit = BlocProvider.of<VideoCubit>(context);
      await videoCubit.getAllVideos(widget.studentId, selectedDrill!);
    }

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          backgroundColor: const Color(0xFFF5F5F5),
          foregroundColor: const Color(0xFFF5F5F5),
          surfaceTintColor: const Color(0xFFF5F5F5),
          shadowColor: Colors.white,
          elevation: 0,
          leading: MyBackButton(
            onTapFunction: () {
              CoachNavBar.navBarKey.currentState?.setState(() {});
              CustomNavigate().popToFirst(context);
            },
          ),
          leadingWidth: 100,
        ),
        backgroundColor: const Color(0xFFF5F5F5),
        body: Padding(
          padding: EdgeInsets.only(left: 23.w, right: 23.w, top: 10.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Progress',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32.sp,
                      fontFamily: 'Jua',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
                Performance(
                  studentId: widget.studentId,
                ),
                SizedBox(
                  height: 27.h,
                ),
                Text(
                  'Check selectively',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF89898A),
                    fontSize: 12.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                SizedBox(
                  height: 11.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: DropDown(
                    options: documentIds,
                    onOptionSelected: (selectedOption) {
                      setState(() {
                        selectedDrill = selectedOption;
                        resultsFetched = false;
                        hasVideos = false;
                        fetchAllVideos();
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 28.h,
                ),
                BlocBuilder<VideoCubit, VideoState>(
                  builder: (context, state) {
                    if (state is VideoFetchLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is VideoFetchSuccess) {
                      hasVideos = state.data!.isNotEmpty;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Previous Videos Results',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: const Color(0xFF89898A),
                              fontSize: 12.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          hasVideos
                              ? Column(
                                  children: state.data!
                                      .map(
                                        (video) => InkWell(
                                          onTap: () {
                                            CustomNavigate().pushRoute(
                                                context,
                                                FieldDrill(
                                                  videoFile: video.file,
                                                  leaderboard:
                                                      video.leaderboard,
                                                ));
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.95,
                                            height: 280.h,
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            decoration: const ShapeDecoration(
                                              color: Color(0xFFFEFEFE),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10.w),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 6.h,
                                                  ),
                                                  FutureBuilder<Uint8List?>(
                                                    future:
                                                        _generateThumbnailFromUrl(
                                                            video.file),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.data !=
                                                          null) {
                                                        return Image.memory(
                                                          snapshot.data!,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.85,
                                                          height: 200,
                                                          fit: BoxFit.cover,
                                                        );
                                                      } else {
                                                        return const Center(
                                                            child:
                                                                CircularProgressIndicator());
                                                      }
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        video.type!,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16.sp,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 0,
                                                        ),
                                                      ),
                                                      Text(
                                                        DateFormat('yyyy-MM-dd')
                                                            .format(video.date),
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[600],
                                                          fontSize: 14.sp,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/images/chart.svg',
                                                      ),
                                                      SizedBox(
                                                        width: 7.w,
                                                      ),
                                                      Text(
                                                        'Check Drill results here',
                                                        style: TextStyle(
                                                          color: const Color(
                                                              0xFFAB7CE6),
                                                          fontSize: 14.sp,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 0,
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                )
                              : Text(
                                  'No videos available for the selected drill.',
                                  style: TextStyle(
                                    color: const Color(0xFFAB7CE6),
                                    fontSize: 14.sp,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                ),
                        ],
                      );
                    } else if (state is VideoFetchFailed) {
                      return Text(
                        'Error loading videos: ${state.message}',
                        style: TextStyle(
                          color: const Color(0xFFAB7CE6),
                          fontSize: 14.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ));
  }
}
