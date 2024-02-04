import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UserType { coach, student }

class UserAuthProvider extends ChangeNotifier {
  String? _userId;
  UserType? _userType;
  String? _userName;

  String? get userId => _userId;
  UserType? get userType => _userType;
  String? get userName => _userName;

  static const String _userIdKey = 'user_id';
  static const String _userTypeKey = 'user_type';
  static const String _userNameKey = 'user_name';

  UserAuthProvider() {
    _loadUserData();
  }

  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString(_userIdKey);
    _userType = prefs.getString(_userTypeKey)?.toUserType();
    _userName = prefs.getString(_userNameKey);

    notifyListeners();
  }

  void setUser(String userId, UserType userType, String userName) async {
    _userId = userId;
    _userType = userType;
    _userName = userName;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_userIdKey, userId);
    prefs.setString(_userTypeKey, userType.toString());
    prefs.setString(_userNameKey, userName);

    notifyListeners();
  }

  void clearUser() async {
    _userId = null;
    _userType = null;
    _userName = null;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_userIdKey);
    prefs.remove(_userTypeKey);
    prefs.remove(_userNameKey);

    notifyListeners();
  }
}

extension UserTypeExtension on String {
  UserType? toUserType() {
    switch (this) {
      case 'coach':
        return UserType.coach;
      case 'student':
        return UserType.student;
      default:
        return null;
    }
  }
}
