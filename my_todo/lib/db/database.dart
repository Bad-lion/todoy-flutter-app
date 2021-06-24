import 'dart:io';
import '../model/model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  String tasksTable = 'Students';
  String columnId = 'id';
  String columnName = 'name';
  // String columnDone = 'isDone';

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'Task.db';
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $tasksTable($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT)',
    );
  }

  // READ
  Future<List<Task>> getTasks() async {
    Database db = await this.database;
    final List<Map<String, dynamic>> tasksMapList = await db.query(tasksTable);
    final List<Task> tasksList = [];
    tasksMapList.forEach((taskMap) {
      tasksList.add(Task.fromMap(taskMap));
    });

    return tasksList;
  }

  // INSERT
  Future<Task> insertTask(Task task) async {
    Database db = await this.database;
    task.id = await db.insert(tasksTable, task.toMap());
    return task;
  }

  // UPDATE
  Future<int> updateTask(Task task) async {
    Database db = await this.database;
    return await db.update(
      tasksTable,
      task.toMap(),
      where: '$columnId = ?',
      whereArgs: [task.id],
    );
  }

  // DELETE
  Future<int> deleteOneTask(int id) async {
    Database db = await this.database;
    return await db.delete(
      tasksTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAll() async {
    Database db = await this.database;
    return await db.delete(
      tasksTable,
    );
  }

  getCount() async {
    Database db = await this.database;
    var list = await db.rawQuery('SELECT * FROM Test');
    return list.length;
  }
}
