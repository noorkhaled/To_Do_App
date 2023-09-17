import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/task.dart';

class DBHelper {
  final int version = 1;
  final String tablename = 'tasks';
  Database? db;
  Future<void> initDb() async {
    if (db != null) {
      debugPrint('not null db');
      return;
    } else {
      try {
        String path = '${await getDatabasesPath()}task.db';
        db = await openDatabase(
            path,
            version: version,
            onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE $tablename('
              'id INTEGER PRIMARY KEY AUTOINCREMENT,'
              'title STRING, note TEXT, date STRING,'
              'startTime STRING,endtime STRING,'
              'remind INTEGER, repeat STRING'
              'color INTEGER,'
              'isCompleted INTEGER)');
        });
      } catch (err) {
        print(err);
      }
    }
  }

  static Future<int> insert(Task? task) async {
    print('insert');
    return await DBHelper().db!.insert(DBHelper().tablename, task!.toJson());
  }

  static Future<int> delete(Task task) async {
    print('delete');
    return await DBHelper()
        .db!
        .delete(DBHelper().tablename, where: 'id = ?', whereArgs: [task.id]);
  }

  static Future<List<Map<String, Object?>>> query() async {
    print('query');
    return await DBHelper().db!.query(DBHelper().tablename);
  }

  static Future<int> update(int id) async {
    print('update');
    return await DBHelper().db!.rawUpdate('''
    UPDATE tasks
    SET isCompleted = ?
    WHERE id = ?

   ''', [1, id]);
  }
}
