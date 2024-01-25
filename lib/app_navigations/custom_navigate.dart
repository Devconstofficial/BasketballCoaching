import 'package:flutter/material.dart';

class CustomNavigate {
  void popAllNavigateToRoute(BuildContext context, Widget screen) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => screen),
      (route) => false,
    );
  }

  void pushRoute(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
