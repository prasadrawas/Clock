import 'dart:async';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock/db/alarmhelper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/alarm_info.dart';
import '../main.dart';

class AlarmScreen extends StatefulWidget {
  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>> _alarms;
  @override
  void initState() {
    _alarmHelper.initializeDatabase().then((value) => {loadAlarms()});
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 10, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Alarm',
            style: TextStyle(
                fontFamily: 'PassionOne',
                fontSize: 30,
                color: Colors.white,
                letterSpacing: 3),
          ),
          SizedBox(
            height: 30.0,
          ),
          Expanded(
            child: FutureBuilder<List<AlarmInfo>>(
              future: _alarms,
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return ListView(
                    children: snapshot.data.map((alarm) {
                      return ExpandableNotifier(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 20.0),
                              padding: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Color(0xFF3B3737),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 12, left: 12, right: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.label_important,
                                          color: Colors.white,
                                          size: 18.0,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          alarm.label,
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w100,
                                              fontFamily: 'PassionOne',
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                            flex: 4,
                                            fit: FlexFit.tight,
                                            child: Text(
                                              alarm.hour
                                                      .toString()
                                                      .padLeft(2, '0') +
                                                  " : " +
                                                  alarm.minute
                                                      .toString()
                                                      .padLeft(2, '0') +
                                                  " " +
                                                  alarm.period,
                                              style: TextStyle(
                                                  fontSize: 38,
                                                  fontFamily: 'PassionOne',
                                                  color: Colors.white),
                                            )),
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: Switch(
                                              value: alarm.status == 1
                                                  ? true
                                                  : false,
                                              onChanged: (value) {
                                                if (mounted) {
                                                  setState(() {
                                                    alarm.status =
                                                        value == true ? 1 : 0;
                                                    _alarmHelper.updateStatus(
                                                        alarm.id, alarm.status);
                                                    scheduleAlarm(alarm);
                                                  });
                                                }
                                              }),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Expandable(
                                      collapsed: ExpandableButton(
                                        child: Column(children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                flex: 8,
                                                fit: FlexFit.tight,
                                                child: Text(
                                                  alarm.days,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontFamily: 'PassionOne',
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Icon(
                                                  Icons.arrow_drop_down,
                                                  size: 24,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]),
                                      ),
                                      expanded: Column(children: [
                                        Container(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 15,
                                              ),
                                              GestureDetector(
                                                onTap: () {},
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .label_important_outline,
                                                      size: 20,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      alarm.label,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              'PassionOne',
                                                          fontSize: 20),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              GestureDetector(
                                                onTap: () {},
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .notifications_active_outlined,
                                                      size: 20,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      'Bella ciao',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'PassionOne',
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  if (mounted) {
                                                    setState(() {
                                                      _alarmHelper.deleteAlarm(
                                                          alarm.id);
                                                      loadAlarms();
                                                    });
                                                  }
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .delete_outline_rounded,
                                                      size: 20,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'PassionOne',
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ExpandableButton(
                                          child: Icon(
                                            Icons.arrow_drop_up,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                return Text(
                  '',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                );
              },
            ),
          ),
          Center(
            child: FlatButton.icon(
              onPressed: () async {
                TimeOfDay picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  builder: (BuildContext context, Widget child) {
                    return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(alwaysUse24HourFormat: false),
                      child: child,
                    );
                  },
                );
                AlarmInfo _alarm = AlarmInfo(
                  label: 'Alarm',
                  hour: picked.hour > 12 ? picked.hour - 12 : picked.hour,
                  minute: picked.minute,
                  period: picked.period.toString().split('.').last,
                  status: 1,
                  days: 'Today',
                );

                _alarmHelper.insetAlarm(_alarm);
                if (mounted) {
                  setState(() {
                    loadAlarms();
                  });
                }
                scheduleAlarm(_alarm);
              },
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.white,
                size: 50,
              ),
              label: Text(''),
            ),
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }

  void scheduleAlarm(AlarmInfo alarmInfo) async {
    var t = DateTime.now();
    var scheduledDate = DateTime(
        t.year,
        t.month,
        t.day,
        alarmInfo.period == "pm" ? alarmInfo.hour + 12 : alarmInfo.hour,
        alarmInfo.minute);
    print(scheduledDate);
    var androidPlatform = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Alarm',
      priority: Priority.High,
      importance: Importance.Max,
      icon: 'alarm_logo',
      largeIcon: DrawableResourceAndroidBitmap('alarm_logo'),
      color: Color(0xFF3B3737),
      enableVibration: true,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('ringtone'),
    );

    var iosPlatform = IOSNotificationDetails();
    var platformSpecific = NotificationDetails(androidPlatform, iosPlatform);
    await fPlugin.schedule(
        1, 'Alarm', 'Alarm notification body', scheduledDate, platformSpecific);
  }
}
