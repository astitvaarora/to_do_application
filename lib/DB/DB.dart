import 'package:hive_flutter/hive_flutter.dart';

class TODODatabase{

  List toDoList = [];
  


  //reference the box
  final _mybox = Hive.openBox('mybox');

}