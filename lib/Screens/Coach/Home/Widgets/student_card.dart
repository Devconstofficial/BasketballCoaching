import 'package:basketball_coaching/Components/firebaseImageWidget.dart';
import 'package:basketball_coaching/Screens/Coach/AddProgress/add_progress.dart';
import 'package:basketball_coaching/Screens/Coach/Home/Widgets/card_button.dart';
import 'package:flutter/material.dart';

class StudentsCard extends StatelessWidget {
  final String name;
  final String studentId;
  final String profile;

  const StudentsCard({
    Key? key,
    required this.name,
    required this.studentId,
    required this.profile,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 172,
      height: 253,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        shadows: const [
          BoxShadow(
            color:Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(1, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 57, top: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle, 
                    color: Colors.white, 
                  ),
                  child: FirebaseNetworkImage(
                    imagePath: profile,
                    width: 58,
                    height: 58, 
                  ),
                ),
                const SizedBox(
                  width: 33,
                ),
                const Icon(Icons.delete),
              ],
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Jua',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            'Add today’s progress\n+',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFAB7CE6),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          InkWell(
            onTap: () {
              // Navigate to AddProgress screen with student information
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProgress(
                    name: name,
                    studentId: studentId,
                    profile: profile,
                  ),
                ),
              );
            },
            child: const CardButton(),
          ),
        ],
      ),
    );
  }
}