import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];
  final _myBox = Hive.box('mybox');

  //Data which will be shown when the App is opened for the 1st time ever!
  void createInitialData() {
    toDoList = [
      ["Write a Task", false],
      ["Complete the Task", false],
    ];
  }

  //Data which will be shows when the app is opened next time, i.e. load the data
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  //Data in the database which will be updated, if we make any changes in the app {ex. checkingBox, deleteTask, addTask}
  void updateDatabase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
