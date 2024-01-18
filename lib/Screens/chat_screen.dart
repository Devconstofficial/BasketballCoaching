import 'package:basketball_coaching/Components/message_field.dart';
import 'package:basketball_coaching/Components/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: 393.w,
              height: 130.h,
              decoration: ShapeDecoration(
                color: const Color(0xFFAB7CE6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 70.h),
                child: Text(
                  'Team Chat',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFFEFEFE),
                    fontSize: 20.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 410.h,
                  ),
                  const Messages(),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      const MessageField(),
                      SizedBox(
                        width: 4.w,
                      ),
                      Container(
                        width: 46.w,
                        height: 46.h,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFAB7CE6),
                          shape: OvalBorder(),
                        ),
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            )
          ]),
        ));
  }
}
