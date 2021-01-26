import 'package:flutter/widgets.dart';
import 'package:flutter_clock/screens/timer_screen.dart';

class Timer_Info extends ChangeNotifier {
  int sec = 0, min = 0, hour = 0;

  updateSec(String s) {
    sec = int.parse(s);
    if (sec >= 60) {
      min++;
      sec = sec - 60;
      TimerScreen.lim++;
    }
    notifyListeners();
  }

  updateMin(String m) {
    print(min);
    if (m.length == 1) {
      min = (min * 10) + int.parse(m);
    } else if (m.length == 2) {
      min = (min * 10) + int.parse(m.substring(1));
    }
    print(min);
    if (min >= 60) {
      hour++;
      min -= 60;
      TimerScreen.lim++;
    }

    notifyListeners();
  }

  updateHour(String h) {
    if (hour == 0) {
      hour = int.parse(h);
    } else {
      hour = int.parse(hour.toString() + h);
    }
    notifyListeners();
  }

  clearValues() {
    if (sec != 0 || min != 0 || hour != 0) {
      sec = 0;
      min = 0;
      hour = 0;
      TimerScreen.lim = 1;
    }
  }

  clearTime() {
    if (hour != 0) {
      if (hour <= 9) {
        hour = 0;
        TimerScreen.lim--;
        TimerScreen.hour = "";
      } else {
        hour = int.parse(hour.toString().substring(0, 1));
        TimerScreen.lim--;
        TimerScreen.hour = hour.toString();
      }
    } else if (min != 0) {
      if (min <= 9) {
        min = 0;
        TimerScreen.lim--;
        TimerScreen.min = "";
      } else {
        min = int.parse(min.toString().substring(0, 1));
        TimerScreen.lim--;
        TimerScreen.min = min.toString();
      }
    } else if (sec != 0) {
      if (sec <= 9) {
        sec = 0;
        TimerScreen.lim = 1;
        TimerScreen.sec = "";
      } else {
        sec = int.parse(sec.toString().substring(0, 1));
        TimerScreen.lim = 2;
        TimerScreen.sec = sec.toString();
      }
    }
    notifyListeners();
  }

  startTimer() {
    if (hour == 0 && min == 0 && sec == 0) {
      notifyListeners();
      return true;
    } else {
      if (min != 0 || sec != 0) {
        sec--;
      }

      if (sec == 0 && min != 0) {
        min--;
        sec = 60;
      }

      if (min == 0 && hour != 0) {
        hour--;
        min = 60;
      }

      notifyListeners();
      return false;
    }
  }

  stopTimer() {
    sec = sec;
    min = min;
    hour = hour;
    notifyListeners();
  }
}
