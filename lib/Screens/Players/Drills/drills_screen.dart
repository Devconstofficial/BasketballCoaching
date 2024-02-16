import 'dart:typed_data';

import 'package:basketball_coaching/Screens/Players/Drills/Widgets/new_drills.dart';
import 'package:basketball_coaching/cubits/videos/cubit.dart';
import 'package:basketball_coaching/firebase/firebaseStorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../app_navigations/custom_navigate.dart';
import '../../../cubits/students/cubit.dart';
import '../../../models/student.dart';
import '../DrillPerformance/drill_performance.dart';
import '../DrillProgress/drill_progress.dart';

class DrillsScreen extends StatefulWidget {
  final String studentId;
  const DrillsScreen({
    required this.studentId,
    super.key,
  });

  @override
  State<DrillsScreen> createState() => _DrillsScreenState();
}

class _DrillsScreenState extends State<DrillsScreen> {
  bool hasOtherDrills = false;
  List<String> challenges = [];
  String? name;
  bool loaded = false;

  Future<void> getChallenges() async {
    VideoCubit videoChallengeCubit = BlocProvider.of<VideoCubit>(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');
    await videoChallengeCubit.getOtherVideoChallenges(userId!, challenges);
  }

  Future<void> challengesNames() async {
    List<String>? types = await getOtherDrillsNames(widget.studentId);
    setState(() {
      if (types.isNotEmpty) {
        challenges = types;
      }
    });
  }

  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');
    StudentCubit studentCubit = BlocProvider.of<StudentCubit>(context);
    Student? student = await studentCubit.getStudentById(userId!);
    setState(() {
      name = student!.name;
      loaded = true;
    });
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
  void initState() {
    super.initState();
    getUserData();
    challengesNames().then((_) {
      getChallenges();
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return loaded
        ? Scaffold(
            backgroundColor: const Color(0xFFF5F5F5),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Image.asset(
                      'assets/images/boy.gif',
                      height: 250.h,
                      width: 160.w,
                    ),
                    Container(
                      width: 226.w,
                      height: 177.h,
                      decoration: const BoxDecoration(color: Color(0xFFFEFEFE)),
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: Text(
                          'Let’s drill & rock \n $name!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 32.sp,
                            fontFamily: 'Jua',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ]),
                  Padding(
                    padding: EdgeInsets.only(left: 18.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Existing Drills',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        NewDrills(
                            drillName: "cone",
                            studentId: widget.studentId,
                            text: 'Cone Drill',
                            gifPath: 'assets/images/conedrill.gif',
                            videoUrl:
                                'https://firebasestorage.googleapis.com/v0/b/devconst-basketball-coaching.appspot.com/o/videos%2Fcone.mp4?alt=media&token=0686a8b5-69a6-461a-b19c-f0c041921682'),
                        SizedBox(
                          height: 16.h,
                        ),
                        NewDrills(
                            drillName: "pull up",
                            studentId: widget.studentId,
                            text: 'Pull up Drill',
                            gifPath: 'assets/images/hookshot.gif',
                            videoUrl:
                                'https://firebasestorage.googleapis.com/v0/b/devconst-basketball-coaching.appspot.com/o/videos%2Fpull%20up.mp4?alt=media&token=3457ac7c-5a63-48ab-99f1-f62adadb3199'),
                        SizedBox(
                          height: 16.h,
                        ),
                        NewDrills(
                            drillName: "bank shot",
                            studentId: widget.studentId,
                            text: 'Bank shot',
                            gifPath: 'assets/images/closeshot.gif',
                            videoUrl:
                                'https://firebasestorage.googleapis.com/v0/b/devconst-basketball-coaching.appspot.com/o/videos%2Fbank%20shot.mp4?alt=media&token=c28af89c-97a4-4659-961a-98fd2ea8225d'),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          'New Videos and Challenges',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        BlocBuilder<VideoCubit, VideoState>(
                            builder: (context, state) {
                          if (state is ChallengeFetchLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is ChallengeFetchFailed) {
                            return Text(
                              'Error loading Challenges: ${state.message}',
                              style: TextStyle(
                                color: const Color(0xFFAB7CE6),
                                fontSize: 14.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            );
                          } else if (state is ChallengeFetchSuccess) {
                            print(state.videoChallenges);
                            hasOtherDrills = state.videoChallenges!.isNotEmpty;
                            return Column(
                              children: state.videoChallenges!
                                  .map(
                                    (video) => InkWell(
                                      onTap: () {
                                        CustomNavigate().pushRoute(
                                            context,
                                            DrillPerformance(
                                              video: video.video,
                                              drillName: video.type,
                                            ));
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.95,
                                        height: 280.h,
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
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
                                              video.video != null
                                                  ? FutureBuilder<Uint8List?>(
                                                      future:
                                                          _generateThumbnailFromUrl(
                                                              video.video!),
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
                                                    )
                                                  : Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.85,
                                                      height: 200,
                                                      child: const Center(
                                                          child: Text(
                                                        "No video for this Drill",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFFAB7CE6),
                                                          fontSize: 16,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 0,
                                                        ),
                                                      )),
                                                    ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text(
                                                video.type,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.sp,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                  height: 0,
                                                ),
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
                                                  GestureDetector(
                                                    onTap: () {
                                                      CustomNavigate()
                                                          .pushRoute(
                                                        context,
                                                        DrillProgress(
                                                          studentId:
                                                              widget.studentId,
                                                          drillName: video.type,
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      'Progress Details',
                                                      style: TextStyle(
                                                        color: const Color(
                                                            0xFFAB7CE6),
                                                        fontSize: 14.sp,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 0,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 79.w,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      CustomNavigate()
                                                          .pushRoute(
                                                              context,
                                                              DrillPerformance(
                                                                drillName:
                                                                    video.type,
                                                                video: video.video !=
                                                                            null ||
                                                                        video.video ==
                                                                            ""
                                                                    ? video
                                                                        .video
                                                                    : null,
                                                              ));
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Perform Drill',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: const Color(
                                                                0xFFAB7CE6),
                                                            fontSize: 14.sp,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 7.w,
                                                        ),
                                                        SvgPicture.asset(
                                                          'assets/images/arrow.svg',
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            );
                          } else {
                            return Center(
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Image.asset(
                                    "assets/images/loader.gif",
                                    height: 200.h,
                                    width: 200.h,
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                        SizedBox(
                          height: 16.h,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        : Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Image.asset(
                "assets/images/loader.gif",
                height: 200.h,
                width: 200.h,
              ),
            ),
          );
  }
}
