import 'package:flutter/material.dart';
import 'package:flutter_clock/enums.dart';
import 'package:flutter_clock/models/menu_info.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'homepage.dart';

final FlutterLocalNotificationsPlugin fPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var androidSetting = AndroidInitializationSettings('alarm_logo');

  var iosSetting = new IOSInitializationSettings();

  var initializeSetting =
      new InitializationSettings(androidSetting, iosSetting);

  await fPlugin.initialize(initializeSetting,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('Notificatioin payload ' + payload);
    }
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
        create: (context) => MenuInfo(MenuType.clock),
        child: HomePage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
