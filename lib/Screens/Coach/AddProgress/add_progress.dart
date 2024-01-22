import 'package:basketball_coaching/Components/back_button.dart';
import 'package:basketball_coaching/Components/clock_timer.dart';
import 'package:basketball_coaching/Components/drop_down.dart';
import 'package:basketball_coaching/Components/main_button.dart';
import 'package:basketball_coaching/Components/slider.dart';
import 'package:basketball_coaching/Screens/Coach/AddProgress/Widgets/student_detail.dart';
import 'package:basketball_coaching/Screens/Coach/Progress/view_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

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
  
  double sliderValue = 0.1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: Padding(
          padding: EdgeInsets.only(left: 23.w, right: 23.w, top: 60.h),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const MyBackButton(),
            SizedBox(
              height: 16.h,
            ),
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
            Container(
              width: 331.w,
              height: 162.h,
              decoration: ShapeDecoration(
                color: const Color(0x7F151517),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
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
                Text(
                  'attach video',
                  style: TextStyle(
                    color: const Color(0xFF979595),
                    fontSize: 12.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                )
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
            const DropDown(),
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
            const MySlider(),
            SizedBox(
              height: 20.h,
            ),
            const ClockTimer(),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ViewProgress()),
                  );
                },
                child: const MainButton(text: 'Add to Profile'))
          ]),
        ));
  }
}
