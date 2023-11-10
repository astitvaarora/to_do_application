import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TODODatabase{
  List toDoList = [];
    //reference the box
    final _mybox = Hive.box('mybox');

  // first time opening the app default data
  void createInitialData(){
    toDoList = [
      ["Default task 1",false],
      ["Default task 2",false],
    ];
  }

  // laod the database
  void loadData(){
    toDoList = _mybox.get("TODOLIST");

  }
  // update the databse
  void updateDataBase(){
    _mybox.put("TODOLIST", toDoList);
  }
}