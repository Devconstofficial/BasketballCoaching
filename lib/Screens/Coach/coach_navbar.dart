import 'package:basketball_coaching/Screens/Coach/Home/home_screen.dart';
import 'package:basketball_coaching/Screens/Coach/ProfileScreen/profile_screen.dart';
import 'package:basketball_coaching/Screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoachNavBar extends StatefulWidget {
  static const String id = 'MyNavBar';
  const CoachNavBar({Key? key});

  @override
  State<CoachNavBar> createState() => _CoachNavBarState();
}

class _CoachNavBarState extends State<CoachNavBar> {
  List<Widget> screens = [
    const ChatScreen(),
    HomeScreen(),
    const ProfileScreen(),
  ];

  int currentindex = 1;
  List<bool> isSelected = [
    false,
    true,
    false,
  ];
  @override
  void initState() {
    super.initState();
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
            icon: Icons.chat_bubble_outline,
            label: 'Chat',
          ),
          _buildNavBarItem(
            index: 1,
            icon: Icons.people,
            label: 'Team',
          ),
          _buildNavBarItem(
            index: 2,
            icon: Icons.person_outline_sharp,
            label: 'Me',
          ),
        ],
        onTap: (index) {
          setState(() {
            currentindex = index;
            isSelected = List.generate(3, (i) => i == index);
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
