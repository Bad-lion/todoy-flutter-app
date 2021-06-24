import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_todo/view/add_screen.dart';
import '../db/database.dart';
import '../model/model.dart';

class Controller extends ControllerMVC {
  factory Controller() {
    if (_this == null) _this = Controller._();
    return _this;
  }
  static Controller _this;

  Controller._();

  Future getTask() {
    return DBProvider.db.getTasks();
  }

  void deleteAll() {
    DBProvider.db.deleteAll();
  }

  void insertTask(dynamic value) {
    DBProvider.db.insertTask(Task(null, value));
  }

  void updateTask(List<Task> lst, dynamic value, int index) {
    DBProvider.db.updateTask(Task(lst[index].id, value));
  }

  void deleteTask(List<Task> lst, int index) {
    DBProvider.db.deleteOneTask(lst[index].id);
  }
}
