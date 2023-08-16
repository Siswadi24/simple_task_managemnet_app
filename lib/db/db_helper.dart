import 'package:managemen_task_app/models/task_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = 'task_table';

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'task.db';
      _db =
          await openDatabase(_path, version: _version, onCreate: (db, version) {
        print('DB Created');
        return db.execute(
          'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING, note TEXT, isComplete INTEGER, date STRING, startTime STRING, endTime STRING, color INTEGER, reminder INTEGER, repeatRemind STRING)',
        );
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insertTask(TaskModel? taskModel) async {
    print("Insert Function Called");
    return await _db?.insert(_tableName, taskModel!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("Query Function Called");
    return await _db!.query(_tableName);
  }

  static delete(TaskModel taskModel) async {
    return await _db!
        .delete(_tableName, where: 'id = ?', whereArgs: [taskModel.id]);
  }

  static update(int id) async {
    return await _db!.rawUpdate('''
      UPDATE task_table
      SET isComplete = ?
      WHERE id = ?
  ''', [1, id]);
  }
}
