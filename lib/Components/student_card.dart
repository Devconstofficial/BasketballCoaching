import 'package:basketball_coaching/Screens/Coach/AddProgress/add_progress.dart';
import 'package:basketball_coaching/Screens/Coach/Home/Widgets/card_button.dart';
import 'package:basketball_coaching/Screens/chat_screen.dart';
import 'package:basketball_coaching/Screens/Players/StudentRegistration/student_registration.dart';
import 'package:basketball_coaching/Screens/Coach/Progress/view_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StudentsCard extends StatefulWidget {
  final String text;
  const StudentsCard({Key? key, required this.text}) : super(key: key);

  @override
  State<StudentsCard> createState() => _StudentsCardState();
}

class _StudentsCardState extends State<StudentsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 172.w,
      height: 253.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.r),
        ),
        shadows: [
          BoxShadow(
            color: const Color(0x3F000000),
            blurRadius: 4.r,
            offset: const Offset(1, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 57.w, top: 16.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatScreen()),
                    );
                  },
                  child: Container(
                    width: 58.w,
                    height: 58.h,
                    decoration: ShapeDecoration(
                      image: const DecorationImage(
                        image: ExactAssetImage('assets/images/cardimage.png'),
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(29.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 33.w,
                ),
                InkWell(
                  onTap:  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StudentRegistration()),
                    );
                  },

                  child: SvgPicture.asset(
                    'assets/images/delete.svg',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontFamily: 'Jua',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddProgress()),
              );
            },
            child: Text(
              'Add today’s progress\n+',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFFAB7CE6),
                fontSize: 14.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
          InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewProgress()),
                );
              },
              child: const CardButton()),
        ],
      ),
    );
  }
}
