import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock/models/stopwatch_info.dart';
import 'package:provider/provider.dart';

class StopwatchScreen extends StatefulWidget {
  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  var Sec = 0;
  bool play = false;
  bool pause = true;
  bool reset = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 10, right: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Stopwatch',
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
                      Consumer<Stopwatch_Info>(
                        builder: (context, value, child) {
                          return Text(
                            reset ? '0' : value.startTime.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'PassionOne',
                              fontSize: 50,
                            ),
                          );
                        },
                      ),
                      Text(
                        ' S',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'PassionOne',
                          fontSize: 20,
                        ),
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
              child: Text(''),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: pause
                  ? FlatButton.icon(
                      onPressed: () {
                        if (mounted) {
                          setState(() {
                            reset = false;
                            pause = false;
                            play = true;
                          });
                        }
                        update();
                      },
                      icon: Icon(
                        Icons.play_arrow_rounded,
                        size: 50,
                        color: Colors.white,
                      ),
                      label: Text(''),
                    )
                  : FlatButton.icon(
                      onPressed: () {
                        if (mounted) {
                          setState(() {
                            reset = false;
                            play = false;
                            pause = true;
                          });
                        }
                        update();
                      },
                      icon: Icon(
                        Icons.pause,
                        size: 50,
                        color: Colors.white,
                      ),
                      label: Text('')),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: FlatButton(
                onPressed: () {
                  if (mounted) {
                    setState(() {
                      reset = true;
                      play = false;
                      pause = true;
                    });
                  }
                  update();
                },
                child: Text(
                  'Reset',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'PassionOne'),
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }

  void update() {
    var stopwatch_info = Provider.of<Stopwatch_Info>(context, listen: false);
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (reset) {
        stopwatch_info.resetTime();
        timer.cancel();
      } else if (play) {
        stopwatch_info.updateTime();
      } else if (pause) {
        stopwatch_info.stopTime();
        timer.cancel();
      }
    });
  }
}
