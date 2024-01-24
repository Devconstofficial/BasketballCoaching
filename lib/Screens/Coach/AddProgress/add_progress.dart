import 'dart:io';
import 'dart:typed_data';
import 'package:basketball_coaching/Components/back_button.dart';
import 'package:basketball_coaching/Components/clock_timer.dart';
import 'package:basketball_coaching/Components/drop_down.dart';
import 'package:basketball_coaching/Components/main_button.dart';
import 'package:basketball_coaching/Components/my_snackbar.dart';
import 'package:basketball_coaching/Components/slider.dart';
import 'package:basketball_coaching/Components/video_player_screen.dart';
import 'package:basketball_coaching/Screens/Coach/AddProgress/Widgets/student_detail.dart';
import 'package:basketball_coaching/Screens/Coach/Progress/view_progress.dart';
import 'package:basketball_coaching/config/firebaseStorage.dart';
import 'package:basketball_coaching/models/file_extension.dart';
import 'package:flutter/material.dart';
import '../../../cubits/performance/cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class AddProgress extends StatefulWidget {
  final String name;
  final String studentId;
  final String profile;
  const AddProgress({
    Key? key,
    required this.name,
    required this.studentId,
    required this.profile,
  }) : super(key: key);

  @override
  State<AddProgress> createState() => _AddProgressState();
}

class _AddProgressState extends State<AddProgress> {
  int sliderValue = 0;
  String? selectedDrill = "";
  List<String> documentIds = [];
  int selectedMinutes = 0;
  int selectedSeconds = 0;
  int drillNumbers = 0;
  String leaderboard = "";
  List<int> scores = [];

  final ImagePicker picker = ImagePicker();
  File? file;
  final PerformanceCubit _performanceCubit = PerformanceCubit();
  @override
  initState() {
    super.initState();
    drillNames();
  }

  Future<void> drillNames() async {
    var drills = await getAllDrillsNames(widget.studentId);
    setState(() {
      documentIds = drills;
    });
  }

  Future<void> pickMedia() async {
    final mediaFile = await picker.pickVideo(source: ImageSource.gallery);

    if (mediaFile != null) {
      final file = File(mediaFile.path);
      setState(() {
        this.file = file;
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

  Future<void> addPerformance() async {
    _performanceCubit.addPerformanceRecord(
        widget.studentId,
        file!,
        file!.path.split('/').last,
        selectedMinutes,
        selectedSeconds,
        selectedDrill!,
        leaderboard,
        drillNumbers,
        scores);
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
            padding: EdgeInsets.only(left: 23.w, right: 23.w, top: 10.h),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              StudentDetails(
                name: widget.name,
                studentId: widget.studentId,
                profile: widget.profile,
              ),
              SizedBox(
                height: 22.h,
              ),
              Row(
                children: [
                  Text(
                    'Drill video',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  SizedBox(
                    width: 215.w,
                  ),
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
                  )
                ],
              ),
              SizedBox(
                height: 13.h,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 28.0,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                child: file == null
                    ? const NoMediaPicked()
                    : GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPlayerScreen(file!),
                            ),
                          );
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
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(9),
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              VideoPlayerScreen(file!),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: 10.h,
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
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Progress',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              SizedBox(
                height: 17.h,
              ),
              DropDown(
                options: documentIds,
                onOptionSelected: (selectedOption) {
                  setState(() {
                    selectedDrill = selectedOption;
                  });
                },
              ),
              SizedBox(
                height: 17.h,
              ),
              Text(
                'No of times performed',
                style: TextStyle(
                  color: const Color(0xFF7A787B),
                  fontSize: 12.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              SizedBox(height: 19.h),
              MySlider(
                onSliderChanged: (value) => {
                  setState(() {
                    sliderValue = (value * 100).toInt();
                    drillNumbers = sliderValue;
                  })
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              ClockTimer(
                onTimeSelected: (minutes, seconds) {
                  setState(() {
                    selectedMinutes = minutes;
                    selectedSeconds = seconds;
                  });
                },
              ),
              SizedBox(
                height: 25.h,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/add.svg',
                  ),
                  SizedBox(
                    width: 27.w,
                  ),
                  Text(
                    'Add score board',
                    style: TextStyle(
                      color: const Color(0xFF979595),
                      fontSize: 12.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 27.h,
              ),
              InkWell(
                  onTap: () {
                    if (drillNumbers == 0 ||
                        selectedDrill == "" ||
                        selectedMinutes == 0 ||
                        selectedSeconds == 0) {
                      print(
                          "$drillNumbers, \n $selectedDrill,\n $selectedMinutes\n $selectedSeconds");
                      SnackBarHelper.showSnackbar(context,
                          "Drill, Time and No. of times performed is required");
                    } else {
                      addPerformance();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ViewProgress()),
                      );
                    }
                  },
                  child: const MainButton(text: 'Add to Profile')),
              SizedBox(
                height: 22.h,
              ),
            ]),
          ),
        ));
  }
}

class NoMediaPicked extends StatelessWidget {
  const NoMediaPicked({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(9)),
      child: const Center(child: Text('Click attach button to pick video')),
    );
  }
}
