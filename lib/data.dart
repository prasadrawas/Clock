import 'package:flutter_clock/enums.dart';

import 'models/alarm_info.dart';
import 'models/menu_info.dart';

List<MenuInfo> menuItems = [
  MenuInfo(MenuType.clock,
      title: 'Clock', imageSource: 'assets/logo_png/clock_logo.png'),
  MenuInfo(MenuType.alarm,
      title: 'Alarm', imageSource: 'assets/logo_png/alarm_logo.png'),
  MenuInfo(MenuType.timer,
      title: 'Timer', imageSource: 'assets/logo_png/timer_logo.png'),
  MenuInfo(MenuType.stopwatch,
      title: 'Stopwatch', imageSource: 'assets/logo_png/stopwatch_logo.png'),
];

List<AlarmInfo> alarmData = [
  AlarmInfo(
      hour: 10,
      minute: 20,
      period: 'am',
      status: 1,
      label: "Alarm",
      days: "Mon")
];
