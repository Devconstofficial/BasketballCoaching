import 'package:flutter/material.dart';

import '../models/coach.dart';

class CoachProvider extends ChangeNotifier {
  Coach? _coach;

  Coach? get coach => _coach;

  void setCoach(Coach coach) {
    _coach = coach;
    notifyListeners();
  }

  void clearCoach() {
    _coach = null;
    notifyListeners();
  }
}
