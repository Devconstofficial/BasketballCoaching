import 'package:basketball_coaching/Screens/Players/DrillProgress/drill_progress.dart';
import 'package:basketball_coaching/Screens/Players/Drills/drills_screen.dart';
import 'package:basketball_coaching/Screens/Players/StudentProfiles/student_profile.dart';
import 'package:basketball_coaching/Screens/Chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerNavBar extends StatefulWidget {
  static const String id = 'MyNavBar';
  final String userId;
  const PlayerNavBar({
    Key? key,
    required this.userId,
  });

  @override
  State<PlayerNavBar> createState() => _PlayerNavBarState();
}

class _PlayerNavBarState extends State<PlayerNavBar> {
  String? user;
  List<Widget> screens = [];

  int currentindex = 0;
  List<bool> isSelected = [true, false, false, false];
  @override
  void initState() {
    super.initState();
    getUser();
    screens = [
      DrillsScreen(studentId: widget.userId),
      const ChatScreen(),
      DrillProgress(studentId: widget.userId),
      const StudentProfile(),
    ];
  }

  Future<void> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');
    setState(() {
      user = userId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: screens[currentindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentindex,
        items: [
          _buildNavBarItem(
            index: 0,
            icon: Icons.sports_basketball_outlined,
            label: 'Drills',
          ),
          _buildNavBarItem(
            index: 1,
            icon: Icons.chat_bubble_outline,
            label: 'Chat',
          ),
          _buildNavBarItem(
            index: 2,
            icon: Icons.show_chart,
            label: 'Progress',
          ),
          _buildNavBarItem(
            index: 3,
            icon: Icons.person_outline_sharp,
            label: 'Me',
          ),
        ],
        onTap: (index) {
          setState(() {
            currentindex = index;
            isSelected = List.generate(4, (i) => i == index);
          });
        },
      ),
    );
  }

  BottomNavigationBarItem _buildNavBarItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected[index] ? const Color(0xFFAB7CE6) : Colors.white,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Icon(
            icon,
            color: isSelected[index] ? Colors.white : const Color(0xFF979595),
          ),
        ),
      ),
      label: isSelected[index] ? '' : label,
      backgroundColor: Colors.white,
    );
  }
}
