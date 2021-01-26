import 'package:flutter_clock/models/alarm_info.dart';
import 'package:sqflite/sqflite.dart';

final String tableName = 'alarm';
final String columnId = 'id';
final String columnLabel = 'label';
final String columnHour = 'hour';
final String columnMinute = 'minute';
final String columnPeriod = 'period';
final String columnStatus = 'status';
final String columnDay = 'days';

class AlarmHelper {
  static Database _database;
  static AlarmHelper _alarmHelper;

  AlarmHelper._createInstance();
  factory AlarmHelper() {
    if (_alarmHelper == null) {
      _alarmHelper = AlarmHelper._createInstance();
    }

    return _alarmHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "alarm.db";

    var database =
        await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''
        CREATE TABLE $tableName(
          $columnId integer primary key autoincrement,
          $columnLabel text not null,
          $columnHour integer not null,
          $columnMinute integer not null,
          $columnPeriod text not null,
          $columnDay text not null,
          $columnStatus integer not null
        )
      ''');
    });
    return database;
  }

  void insetAlarm(AlarmInfo alarmInfo) async {
    var db = await this.database;
    var result = await db.insert(tableName, alarmInfo.toJson());
  }

  Future<List<AlarmInfo>> getAlarms() async {
    List<AlarmInfo> _alarms = [];
    var db = await this.database;
    var result = await db.query(tableName);
    result.forEach((element) {
      var alarmInfo = AlarmInfo.fromJson(element);
      _alarms.add(alarmInfo);
    });
    return _alarms;
  }

  Future<int> deleteAlarm(int id) async {
    var db = await this.database;
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> getTotalRowsValue() async {
    var db = await this.database;
    String sql = '''select * from $tableName''';
    var res = await db.rawQuery(sql);
  }

  updateStatus(int id, int status) async {
    var db = await this.database;
    await db.rawQuery(
        '''update $tableName set $columnStatus = $status where $columnId = $id''');
  }
}
