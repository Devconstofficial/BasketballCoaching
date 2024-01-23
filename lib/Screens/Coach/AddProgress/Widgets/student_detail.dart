import 'package:basketball_coaching/Components/firebaseImageWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentDetails extends StatelessWidget {
  final String name;
  final String studentId;
  final String profile;
  const StudentDetails({
    Key? key,
    required this.name,
    required this.studentId,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
                    width: 58,
                    height: 58,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle, 
                      color: Colors.white, 
                    ),
                    child: FirebaseNetworkImage(
                      imagePath: profile,
                      width: 58,
                      height: 58, 
                    ),
                  ),
            SizedBox(
              width: 8.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                // Text(
                //   '12 year old boy',
                //   style: TextStyle(
                //     color: const Color(0xFF979595),
                //     fontSize: 16.sp,
                //     fontFamily: 'Inter',
                //     fontWeight: FontWeight.w600,
                //     height: 0,
                //   ),
                // )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 25.w,
        ),
        Container(
          width: 332.w,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1.w,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: const Color(0xFFD9D9D9),
              ),
            ),
          ),
        )
      ],
    );
  }
}
