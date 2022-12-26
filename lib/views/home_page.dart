import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/widgets/dialog_box.dart';
import 'package:to_do_app/widgets/to_do_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');

  final _controller = TextEditingController();

  ToDoDatabase db = ToDoDatabase();

//Hive Database Functionlity Below -|
  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      //If it's the 1st time ever opening the app, it will perfrom this function from Hive dart file
      db.createInitialData();
    } else {
      //If data is already there in the db, i.e. app changes are made already, and retreiving the data from local storage using Hive and from Hive dart file.
      db.loadData();
    }

    super.initState();
  }
//Hive DB Functionality ends...

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
      db.updateDatabase(); //To update the Hive Database from functionality logic in Hive dart file created.
    });
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase(); //To update the Hive Database from functionality logic in Hive dart file created.
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase(); //To update the Hive Database from functionality logic in Hive dart file created.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1e9acc),
      appBar: AppBar(
        backgroundColor: Color(0xff1a457c),
        elevation: 0,
        title: const Text("...Your TO-DO List..."),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) {
              checkBoxChanged(value, index);
            },
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff1a457c),
        onPressed: () {
          createNewTask();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
