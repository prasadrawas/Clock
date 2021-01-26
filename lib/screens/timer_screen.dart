import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clock/models/timer_info.dart';
import 'package:provider/provider.dart';

class TimerScreen extends StatefulWidget {
  static int lim = 1;
  static String sec = "", min = "", hour = "";
  static bool play = false, isStart = false, pause = true, reset = false;
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  var timer_info;

  @override
  void initState() {
    timer_info = Provider.of<Timer_Info>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TimerScreen.isStart
          ? timerManager()
          : Container(
              padding: EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Timer',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'PassionOne',
                        fontSize: 30),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  CreateNumDisplay(),
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                createNumButton(1),
                                createNumButton(2),
                                createNumButton(3),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                createNumButton(4),
                                createNumButton(5),
                                createNumButton(6),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                createNumButton(7),
                                createNumButton(8),
                                createNumButton(9),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                createNumButton(0),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: FlatButton.icon(
                      onPressed: () {
                        if (mounted) {
                          setState(() {
                            TimerScreen.play = true;
                            TimerScreen.pause = false;
                            TimerScreen.isStart = true;
                            startTimer();
                          });
                        }
                      },
                      icon: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 50,
                      ),
                      label: Text(''),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  createNumButton(int val) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: FlatButton(
          onPressed: () {
            if (TimerScreen.lim >= 1 && TimerScreen.lim <= 2) {
              TimerScreen.sec += val.toString();
              TimerScreen.lim++;
              timer_info.updateSec(TimerScreen.sec);
            } else if (TimerScreen.lim > 2 && TimerScreen.lim <= 4) {
              TimerScreen.min += val.toString();
              TimerScreen.lim++;
              timer_info.updateMin(TimerScreen.min);
            } else if (TimerScreen.lim > 4 && TimerScreen.lim <= 6) {
              TimerScreen.hour += val.toString();
              TimerScreen.lim++;
              timer_info.updateHour(TimerScreen.hour);
            }
          },
          child: Text(
            val.toString(),
            style: TextStyle(
                fontSize: 40, fontFamily: 'PassionOne', color: Colors.white),
          )),
    );
  }

  timerManager() {
    return Container(
      padding: EdgeInsets.only(top: 15, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Timer',
            style: TextStyle(
                fontFamily: 'PassionOne',
                fontSize: 30,
                color: Colors.white,
                letterSpacing: 3),
          ),
          Expanded(
            child: Center(
              child: Container(
                child: Container(
                  height: 220,
                  width: 220,
                  decoration: BoxDecoration(
                      color: Color(0xFF3B3737),
                      borderRadius: BorderRadius.circular(150),
                      border: Border.all(color: Colors.white, width: 6)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Consumer<Timer_Info>(
                          builder: (context, value, child) {
                            return Text(
                              (value.hour.toString().padLeft(2, '0') +
                                  " : " +
                                  value.min.toString().padLeft(2, '0') +
                                  " : " +
                                  value.sec.toString().padLeft(2, '0')),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'PassionOne',
                                fontSize: 40,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: FlatButton(
                  onPressed: () {
                    TimerScreen.sec = "";
                    TimerScreen.min = "";
                    TimerScreen.hour = "";
                    timer_info.clearValues();
                    if (mounted) {
                      setState(() {
                        TimerScreen.play = false;
                        TimerScreen.pause = false;
                        TimerScreen.isStart = false;
                      });
                    }
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'PassionOne'),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: TimerScreen.play
                    ? FlatButton.icon(
                        onPressed: TimerScreen.reset
                            ? null
                            : () {
                                if (mounted) {
                                  setState(() {
                                    TimerScreen.play = false;
                                    TimerScreen.pause = true;
                                  });
                                }
                                startTimer();
                              },
                        icon: Icon(
                          Icons.pause,
                          color: Colors.white,
                          size: 50,
                        ),
                        label: Text(''),
                      )
                    : FlatButton.icon(
                        onPressed: TimerScreen.reset
                            ? null
                            : () {
                                if (mounted) {
                                  setState(() {
                                    TimerScreen.play = true;
                                    TimerScreen.pause = false;
                                  });
                                }
                                startTimer();
                              },
                        icon: Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 50,
                        ),
                        label: Text(''),
                      ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: FlatButton(
                  onPressed: () {
                    TimerScreen.sec = "";
                    TimerScreen.min = "";
                    TimerScreen.hour = "";
                    timer_info.clearValues();
                    if (mounted) {
                      setState(() {
                        TimerScreen.reset = true;
                        TimerScreen.play = false;
                        TimerScreen.pause = true;
                      });
                    }
                  },
                  child: Text(
                    'Reset',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'PassionOne'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void startTimer() {
    if (timer_info == null) timer_info = Timer_Info();

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (TimerScreen.play) {
        bool isEnd = timer_info.startTimer();
        if (isEnd) {
          timer.cancel();
          TimerScreen.sec = "";
          TimerScreen.min = "";
          TimerScreen.hour = "";
          timer_info.clearValues();
        }
      } else if (TimerScreen.pause) {
        timer_info.stopTimer();
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer_info.clearValues();
    TimerScreen.sec = "";
    TimerScreen.min = "";
    TimerScreen.hour = "";
    super.dispose();
  }
}

class CreateNumDisplay extends StatefulWidget {
  @override
  _CreateNumDisplayState createState() => _CreateNumDisplayState();
}

class _CreateNumDisplayState extends State<CreateNumDisplay> {
  var timer_info;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Color(0xFF3B3737),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Flexible(
                flex: 4,
                fit: FlexFit.tight,
                child: Center(
                  child: Consumer<Timer_Info>(
                    builder: (context, value, child) {
                      return Text(
                        value.hour.toString().padLeft(2, '0') +
                            " : " +
                            value.min.toString().padLeft(2, '0') +
                            " : " +
                            value.sec.toString().padLeft(2, '0'),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'PassionOne',
                          fontSize: 48,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Flexible(
                  child: FlatButton.icon(
                      onPressed: () {
                        if (timer_info == null)
                          timer_info =
                              Provider.of<Timer_Info>(context, listen: false);

                        timer_info.clearTime();
                      },
                      icon: Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: 16,
                      ),
                      label: Text('')))
            ],
          ),
        ),
      ],
    );
  }
}
