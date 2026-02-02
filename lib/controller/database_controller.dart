import 'package:flutter/material.dart';
import 'package:sample_project/model/task_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseController with ChangeNotifier {
  static late Database database;
  List<Map> myDataList = [];

  //open db
  static Future<void> initDb() async {
    database = await openDatabase(
      'myDb.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, name TEXT, description TEXT, duration Text)',
        );
      },
    );
  }

  //get Tasks
  Future<void> getTasks() async {
    List<Map> list = await database.rawQuery('SELECT * FROM Tasks');
    myDataList = list;
    notifyListeners();
  }

  //add tasks
  Future<void> addTasks({required TaskModel tasks}) async {
    await database.rawInsert(
      'INSERT INTO Tasks (name,description,duration) VALUES (?,?,?)',
      [tasks.title, tasks.description, tasks.duration],
    );
    getTasks();
    notifyListeners();
  }

  //delete tasks
  Future<void> deleteTasks({required TaskModel tasks}) async {
    await database.rawDelete('DELETE FROM Tasks WHERE id = ?', [tasks.id]);
    getTasks();
    notifyListeners();
  }

  //update tasks
  Future<void> updateTask({required TaskModel tasks}) async {
    await database.rawUpdate(
      'UPDATE Tasks SET name = ?, description = ?, duration = ? WHERE id = ?',
      [tasks.title, tasks.description, tasks.duration, tasks.id],
    );
    getTasks();
    notifyListeners();
  }
}
