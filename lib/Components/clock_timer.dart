import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ClockTimer extends StatefulWidget {
  final int? initialMinutes;
  final int? initialSeconds;
  final void Function(int minutes, int seconds) onTimeSelected;

  const ClockTimer({
    Key? key,
    this.initialMinutes,
    this.initialSeconds,
    required this.onTimeSelected,
  }) : super(key: key);

  @override
  _ClockTimerState createState() => _ClockTimerState();
}

class _ClockTimerState extends State<ClockTimer> {
  int selectedMinutes = 0;
  int selectedSeconds = 0;
  @override
  void initState() {
    super.initState();
    if (widget.initialMinutes == null && widget.initialSeconds == null) {
      setState(() {});
    } else if (widget.initialMinutes == null && widget.initialSeconds != null) {
      setState(() {
        selectedSeconds = widget.initialSeconds!;
      });
    } else if (widget.initialMinutes != null) {
      setState(() {
        selectedMinutes = widget.initialMinutes!;
        selectedSeconds =
            widget.initialSeconds == null ? 0 : widget.initialSeconds!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/images/clock.svg',
        ),
        SizedBox(width: 14.w),
        _buildTimeContainer('minutes', selectedMinutes, (value) {
          setState(() {
            selectedMinutes = value as int;
            widget.onTimeSelected(selectedMinutes, selectedSeconds);
          });
        }),
        SizedBox(width: 4.w),
        Container(
          width: 12.w,
          height: 3.h,
          decoration: const BoxDecoration(color: Color(0xFFAB7CE6)),
        ),
        SizedBox(width: 4.w),
        _buildTimeContainer('seconds', selectedSeconds, (value) {
          setState(() {
            selectedSeconds = value as int;
            widget.onTimeSelected(selectedMinutes, selectedSeconds);
          });
        }),
      ],
    );
  }

  Widget _buildTimeContainer(
      String label, int selectedValue, Function(dynamic) onChanged) {
    return Container(
      width: 60.w,
      height: 80.h,
      decoration: ShapeDecoration(
        color: const Color(0xFFFEFEFE),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        shadows: [
          BoxShadow(
            color: const Color(0x3F000000),
            blurRadius: 5.sp,
            offset: const Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 0.h, left: 5),
        child: Column(
          children: [
            DropdownButton<int>(
              menuMaxHeight: 150,
              value: selectedValue,
              onChanged: (int? newValue) {
                onChanged(newValue);
              },
              items: List.generate(61, (index) => index)
                  .map<DropdownMenuItem<int>>(
                    (int value) => DropdownMenuItem<int>(
                      value: value,
                      child: Text(
                        value.toString().padLeft(2, '0'),
                        style: TextStyle(
                          color: const Color(0xFFAB7CE6),
                          fontSize: 20.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            Text(
              label,
              style: TextStyle(
                color: const Color(0xFF7A797B),
                fontSize: 10.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
