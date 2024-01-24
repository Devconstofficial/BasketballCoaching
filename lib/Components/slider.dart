import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySlider extends StatefulWidget {
  final ValueChanged<double>? onSliderChanged;

  const MySlider({Key? key, required this.onSliderChanged}) : super(key: key);

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  double sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 210.w,
          child: Slider(
            value: sliderValue,
            onChanged: (value) {
              setState(() {
                sliderValue = value;
              });

              if (widget.onSliderChanged != null) {
                widget.onSliderChanged!(sliderValue);
              }
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
