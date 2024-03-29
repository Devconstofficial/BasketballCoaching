import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MyBackButton extends StatelessWidget {
  final VoidCallback? onTapFunction;

  const MyBackButton({Key? key, this.onTapFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: InkWell(
        onTap: () {
          if (onTapFunction != null) {
            onTapFunction!();
          } else {
            Navigator.pop(context);
          }
        },
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/images/backicon.svg',
            ),
            SizedBox(
              width: 16.w,
            ),
            Text(
              'Back',
              style: TextStyle(
                color: const Color(0xFFAB7CE6),
                fontSize: 12.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
