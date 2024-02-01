import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DropDown extends StatefulWidget {
  final List<String> options;
  final Function(String?) onOptionSelected;

  const DropDown({
    Key? key,
    required this.options,
    required this.onOptionSelected,
  }) : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 52.h,
      decoration: ShapeDecoration(
        color: Colors.white,
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
      child: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 23.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedOption,
                icon: SvgPicture.asset('assets/images/dropdown.svg'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedOption = newValue;
                    widget.onOptionSelected(newValue);
                  });
                },
                items: [
                  DropdownMenuItem<String>(
                    value: null,
                    child: Text(
                      'Select an option',
                      style: TextStyle(
                        color: const Color(0xFF7A797B),
                        fontSize: 12.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  ...widget.options
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: const Color(0xFF7A797B),
                              fontSize: 12.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
