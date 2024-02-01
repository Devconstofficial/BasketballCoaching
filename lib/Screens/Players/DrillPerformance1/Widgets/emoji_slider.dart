// EmojiSlider widget

import 'package:basketball_coaching/Components/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmojiSlider extends StatefulWidget {
  final ValueChanged<double> onValueChanged;

  const EmojiSlider({required this.onValueChanged, Key? key}) : super(key: key);

  @override
  _EmojiSliderState createState() => _EmojiSliderState();
}

class _EmojiSliderState extends State<EmojiSlider> {
  double sliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MySlider(
          onSliderChanged: (value) {
            setState(() {
              sliderValue = value;
            });
            widget.onValueChanged(value);
          },
        ),
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
