import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrentMonthDropDown extends StatefulWidget {
  final List<String> options;
  final Function(String?) onOptionSelected;
  final String? selectedOption;

  const CurrentMonthDropDown({
    Key? key,
    required this.options,
    required this.onOptionSelected,
    this.selectedOption,
  }) : super(key: key);

  @override
  State<CurrentMonthDropDown> createState() => _DropDownState();
}

class _DropDownState extends State<CurrentMonthDropDown> {
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 95.w,
      height: 52.h,
      child: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 3.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: DropdownButton<String>(
                menuMaxHeight: 250,
                isExpanded: true,
                value: selectedOption,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.sp,
                  fontFamily: 'Jua',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Color.fromARGB(255, 243, 223, 248),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedOption = newValue;
                    widget.onOptionSelected(newValue);
                  });
                },
                items: [
                  ...widget.options
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: selectedOption == value
                                  ? const Color.fromARGB(255, 243, 223, 248)
                                  : const Color(0xFF7A797B),
                              fontSize: selectedOption == value ? 24.sp : 12.sp,
                              fontFamily: 'Jua',
                              fontWeight: selectedOption == value
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ],
                underline: Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
