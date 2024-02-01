import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BarChart extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  const BarChart({Key? key, required this.data}) : super(key: key);

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: List.generate(
            widget.data.length,
            (index) => buildBar(
              widget.data[index]['height'],
              widget.data[index]['day'],
              index == 0 ? 0 : widget.data[index - 1]['height'],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBar(int height, String day, int prevHeight) {
    double totalHeight = 250.0;
    double containerHeight = height.toDouble() * 2;
    String image = determineImage(height, prevHeight);

    return Column(
      children: [
        Text(
          '${height.toInt()} times',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF89898A),
            fontSize: 12.sp,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        Text(
          height == 0
              ? 'decline'
              : height >= prevHeight
                  ? 'improve'
                  : 'decline',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF89898A),
            fontSize: 10.sp,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        Container(
          width: 30.w,
          height: 30.w,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          height: 6.h,
        ),
        Container(
          width: 40.w,
          height: height == 0 ? 10 : containerHeight / totalHeight * 250,
          decoration: BoxDecoration(
            color: Color(0x4CAB7CE6),
          ),
        ),
        SizedBox(
          height: 11.h,
        ),
        Text(
          day,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 10.sp,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
      ],
    );
  }

  String determineImage(int height, int prevHeight) {
    if (height >= 0 && height <= 5) {
      return 'assets/images/1.png';
    } else if (height > 5 && height <= 20) {
      return 'assets/images/2.png';
    } else if (height > 20 && height <= 40) {
      if (height > prevHeight) {
        return 'assets/images/3.png';
      } else {
        return 'assets/images/2.png';
      }
    } else if (height > 40 && height <= 70) {
      if (height > prevHeight) {
        return 'assets/images/4.png';
      } else {
        return 'assets/images/2.png';
      }
    } else if (height > 70) {
      if (height > prevHeight) {
        return 'assets/images/5.png';
      } else {
        return 'assets/images/4.png';
      }
    } else {
      return 'assets/images/2.png';
    }
  }
}
