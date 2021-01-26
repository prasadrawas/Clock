import 'package:flutter/widgets.dart';

class Stopwatch_Info extends ChangeNotifier {
  int startTime = 0;

  updateTime() {
    startTime++;
    notifyListeners();
  }

  stopTime() {
    startTime = startTime;
    notifyListeners();
  }

  resetTime() {
    startTime = 0;
    notifyListeners();
  }
}
