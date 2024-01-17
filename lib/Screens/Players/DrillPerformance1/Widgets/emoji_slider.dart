import 'package:basketball_coaching/Components/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmojiSlider extends StatefulWidget {
  const EmojiSlider({super.key});

  @override
  State<EmojiSlider> createState() => _EmojiSliderState();
}

class _EmojiSliderState extends State<EmojiSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MySlider(),
        Padding(
          padding: EdgeInsets.only(left: 25.w),
          child: Row(
            children: [
              Image.asset(
                'assets/images/1.png',
              ),
              SizedBox(
                width: 15.w,
              ),
              Image.asset(
                'assets/images/2.png',
              ),
              SizedBox(
                width: 15.w,
              ),
              Image.asset(
                'assets/images/3.png',
              ),
              SizedBox(
                width: 15.w,
              ),
              Image.asset(
                'assets/images/4.png',
              ),
              SizedBox(
                width: 15.w,
              ),
              Image.asset(
                'assets/images/5.png',
              ),
            ],
          ),
        )
      ],
    );
  }
}
