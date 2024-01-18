import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageField extends StatelessWidget {
  const MessageField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320.w,
      height: 46.h,
      child: SearchBar(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
        padding: MaterialStatePropertyAll(EdgeInsets.only(left: 20.w)),
        hintText: 'Enter Message...',
        hintStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(color: Color(0xFF979595))),
        leading: const Icon(
          Icons.camera_alt,
          color: Color(0xFF979595),
        ),
        backgroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
      ),
    );
  }
}
