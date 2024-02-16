import 'dart:typed_data';

import 'package:basketball_coaching/Components/back_button.dart';
import 'package:basketball_coaching/Components/barchart.dart';
import 'package:basketball_coaching/Screens/Players/DrillProgress/Widgets/good_score_images.dart';
import 'package:basketball_coaching/Screens/Players/DrillProgress/Widgets/performance1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../app_navigations/custom_navigate.dart';
import '../../../cubits/performance/cubit.dart';
import '../../../cubits/videos/cubit.dart';
import '../../../firebase/firebaseStorage.dart';
import '../../Coach/DrillResults/fielddrill_results.dart';
import 'Widgets/drop_down.dart';

class DrillProgress extends StatefulWidget {
  final String studentId;
  final String? drillName;
  const DrillProgress({
    required this.studentId,
    this.drillName,
    super.key,
  });

  @override
  State<DrillProgress> createState() => _DrillProgressState();
}

class _DrillProgressState extends State<DrillProgress> {
  List<String> documentIds = [];
  bool screenFlag = false;
  bool hasVideos = false;

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
    setState(() {
      screenFlag = false;
    });
    widget.drillName != null ? fetchAllVideos() : null;
    widget.drillName != null ? daysPerformanceResult() : null;
    setState(() {});
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

  Future<void> fetchAllVideos() async {
    VideoCubit videoCubit = BlocProvider.of<VideoCubit>(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');
    await videoCubit.getAllVideos(userId!, widget.drillName!);
  }

  Future<void> daysPerformanceResult() async {
    final PerformanceCubit cubit = BlocProvider.of<PerformanceCubit>(context);
    await cubit.getLast7DaysTotalNumbers(widget.studentId, widget.drillName!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.drillName != null
          ? AppBar(
              toolbarHeight: 40,
              backgroundColor: const Color(0xFFF5F5F5),
              foregroundColor: const Color(0xFFF5F5F5),
              surfaceTintColor: const Color(0xFFF5F5F5),
              shadowColor: Colors.white,
              elevation: 0,
              leading: MyBackButton(
                onTapFunction: () {
                  CustomNavigate().popToFirst(context);
                },
              ),
              leadingWidth: 100,
            )
          : null,
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(children: [
          widget.drillName == null
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  color: const Color.fromRGBO(255, 160, 0, 1),
                )
              : const SizedBox(),
          widget.drillName == null
              ? Image.asset(
                  'assets/images/players.gif',
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  fit: BoxFit.cover,
                )
              : const SizedBox(),
          widget.drillName == null
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  color: const Color.fromRGBO(255, 160, 0, 1),
                  child: Center(
                    child: Text(
                      "Look who's here",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.sp,
                        fontFamily: 'Jua',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          Center(
            child: Text(
              widget.drillName == null ? '' : '${widget.drillName} progress',
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
          SizedBox(
            height: 26.h,
          ),
          widget.drillName != null
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 23.w, right: 23.w),
                    child: Column(
                      children: [
                        BlocBuilder<PerformanceCubit, PerformanceState>(
                            builder: (context, state) {
                          if (state is PerformanceListLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is PerformanceListFetchSuccess) {
                            return BarChart(data: state.dataList);
                          } else if (state is PerformanceListFetchFailed) {
                            return Text(
                              'Error loading Performance of ${widget.drillName}: ${state.message}',
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
                        }),
                        SizedBox(
                          height: 26.h,
                        ),
                        SizedBox(
                          width: 393.w,
                          height: 225.h,
                          child: Image.asset(
                            "assets/images/celebrate.gif",
                            width: 393.w,
                            height: 225.h,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          height: 26.h,
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
          Center(
            child: Text(
              widget.drillName != null
                  ? 'let’s look into\nprevious months'
                  : "Let's see what \n you achieved",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: widget.drillName != null ? 28.sp : 20.sp,
                fontFamily: widget.drillName != null ? 'Jua' : 'Inter',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
          SizedBox(
            height: 26.h,
          ),
          PerformanceStudent(
            studentId: widget.studentId,
          ),
          SizedBox(
            height: 10.h,
          ),
          widget.drillName != null
              ? Padding(
                  padding: EdgeInsets.all(20.w),
                  child: BlocBuilder<VideoCubit, VideoState>(
                    builder: (context, state) {
                      if (state is VideoFetchLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is VideoFetchSuccess) {
                        hasVideos = state.data!.isNotEmpty;
                        return Column(
                          children: [
                            Text(
                              'Here are some videos \nof your drills',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28.sp,
                                fontFamily: 'Jua',
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
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
                                                          return SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.85,
                                                            height: 200,
                                                            child: const Center(
                                                                child:
                                                                    CircularProgressIndicator()),
                                                          );
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
                                                          DateFormat(
                                                                  'yyyy-MM-dd')
                                                              .format(
                                                                  video.date),
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
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
                                    'You don\'t have any videos',
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
                )
              : const SizedBox(),
        ]),
      ),
    );
  }
}
