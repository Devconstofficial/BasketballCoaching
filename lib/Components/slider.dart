import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySlider extends StatefulWidget {
  const MySlider({super.key});

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  double sliderValue = 0.1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 210.w,
          child: Slider(
            value: sliderValue,
            onChanged: (double value) {
              setState(() {
                sliderValue = value;
              });
            },
            min: 0,
            max: 1,
            divisions: 100,
            label: '${(sliderValue * 100).toInt()}',
            activeColor: const Color(0xFFAB7CE6),
            inactiveColor: const Color(0xFFAB7CE6),
          ),
        ),
      ],
    );
  }
}