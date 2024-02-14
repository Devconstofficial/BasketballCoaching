import 'Widgets/message_field.dart';
import 'Widgets/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  reverse: true,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 68),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Messages(),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: const MessageField(),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
