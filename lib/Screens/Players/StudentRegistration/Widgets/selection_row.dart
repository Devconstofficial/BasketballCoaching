import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectionRow extends StatefulWidget {
  const SelectionRow({Key? key}) : super(key: key);

  @override
  State<SelectionRow> createState() => _SelectionRowState();
}

class _SelectionRowState extends State<SelectionRow> {
  String selected = ''; 

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            _onItemSelected('boy');
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/boy.png',
              ),
              if (selected == 'boy')
                SvgPicture.asset(
                  'assets/images/select.svg',
                  width: 30.w,
                  height: 30.h,
                ),
            ],
          ),
        ),
        SizedBox(
          width: 21.w,
        ),
        Text(
          'Boy',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontFamily: 'Jua',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
        SizedBox(
          width: 60.w,
        ),
        GestureDetector(
          onTap: () {
            _onItemSelected('girl');
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/girl.png',
              ),
              if (selected == 'girl')
                SvgPicture.asset(
                  'assets/images/select.svg',
                  width: 30.w,
                  height: 30.h,
                ),
            ],
          ),
        ),
        SizedBox(
          width: 21.w,
        ),
        Text(
          'Girl',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontFamily: 'Jua',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
      ],
    );
  }

  void _onItemSelected(String item) {
    setState(() {
      selected = item;
    });
  }
}
