import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'clockview.dart';

class ClockScreen extends StatelessWidget {
  var time = DateFormat('hh : mm ' + 'a'.toLowerCase()).format(DateTime.now());
  var date = DateFormat('EEE, d MMM').format(DateTime.now());
  var timezone = DateTime.now().timeZoneOffset.toString().split('.').first;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Container(
                  padding: EdgeInsets.only(left: 20.0, top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Clock',
                        style: TextStyle(
                            fontFamily: 'PassionOne',
                            fontSize: 30,
                            color: Colors.white,
                            letterSpacing: 3),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        time,
                        style: TextStyle(
                            fontSize: 50,
                            fontFamily: 'PassionOne',
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        date,
                        style: TextStyle(
                            fontFamily: 'PassionOne',
                            fontSize: 22,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: Center(child: ClockView())),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Container(
                  padding: EdgeInsets.only(
                    left: 30.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40.0,
                      ),
                      Text(
                        'Timezone',
                        style: TextStyle(
                            fontFamily: 'PassionOne',
                            fontSize: 18,
                            color: Colors.white),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.language,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            ' UTF + ' + timezone,
                            style: TextStyle(
                                fontFamily: 'PassionOne',
                                fontSize: 25,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
