import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileContainer extends StatefulWidget {
  final Function(String) onImageSelected;

  const ProfileContainer({Key? key, required this.onImageSelected})
      : super(key: key);

  @override
  State<ProfileContainer> createState() => _ProfileContainerState();
}

class _ProfileContainerState extends State<ProfileContainer> {
  int? _selectedImageIndex;
  String? selected;

  void _onItemSelected(String item) {
    setState(() {
      selected = item;
      widget.onImageSelected(selected!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 353.w,
      height: 150.h,
      decoration: ShapeDecoration(
        color: const Color(0xFFFEFEFE),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        shadows: [
          BoxShadow(
            color: const Color(0x3F000000),
            blurRadius: 5.r,
            offset: const Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 15.h,
          ),
          Text(
            'Select display avatar',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          SizedBox(
            height: 17.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 20.w,
              ),
              GestureDetector(
                onTap: () {
                  _onItemSelected('boy');
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/cardimage.png',
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
              GestureDetector(
                onTap: () {
                  _onItemSelected('girl');
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/elipse1.png',
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
            ],
          ),
        ],
      ),
    );
  }
}
