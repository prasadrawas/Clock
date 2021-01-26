import 'package:flutter/material.dart';
import 'package:flutter_clock/screens/alarm_screen.dart';
import 'package:flutter_clock/db/alarmhelper.dart';
import 'package:flutter_clock/screens/clock_screen.dart';
import 'package:flutter_clock/data.dart';
import 'package:flutter_clock/models/stopwatch_info.dart';
import 'package:flutter_clock/screens/stopwatch_screen.dart';
import 'package:flutter_clock/models/timer_info.dart';
import 'package:flutter_clock/screens/timer_screen.dart';
import 'package:provider/provider.dart';

import 'enums.dart';
import 'models/menu_info.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Object _selectedMenu = ClockScreen();
  @override
  Widget build(BuildContext context) {
    print('Widget rebuilt\n');
    return SafeArea(
      child: Scaffold(
        body: Container(
            alignment: Alignment.center,
            color: Color(0xFF464141),
            child: Column(
              children: [
                Expanded(
                  child: Consumer<MenuInfo>(
                    builder:
                        (BuildContext context, MenuInfo value, Widget child) {
                      if (value.menuType == MenuType.clock) {
                        return ClockScreen();
                      } else if (value.menuType == MenuType.alarm) {
                        return AlarmScreen();
                      } else if (value.menuType == MenuType.timer) {
                        return ChangeNotifierProvider(
                            create: (context) => Timer_Info(),
                            child: TimerScreen());
                      } else if (value.menuType == MenuType.stopwatch) {
                        return ChangeNotifierProvider(
                            create: (context) => Stopwatch_Info(),
                            child: StopwatchScreen());
                      }
                    },
                  ),
                ),
                Container(
                  height: 85,
                  decoration: BoxDecoration(
                    color: Color(0xFF3B3737),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: createMunuButtons(menuItems[0]),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: createMunuButtons(menuItems[1]),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: createMunuButtons(menuItems[2]),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: createMunuButtons(menuItems[3]),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  createMunuButtons(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget child) {
        return FlatButton(
          onPressed: () {
            var menuInfo = Provider.of<MenuInfo>(context, listen: false);
            menuInfo.updateMenuInfo(currentMenuInfo);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                currentMenuInfo.imageSource,
                height: 30,
                width: 30,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                currentMenuInfo.title ?? '',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'PassionOne',
                    fontSize: 15),
              ),
              currentMenuInfo.menuType == value.menuType
                  ? Container(
                      width: 50,
                      height: 2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
            ],
          ),
        );
      },
    );
  }
}
