import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_application/DB/DB.dart';
import 'package:to_do_application/utils/To_Do_Tile.dart';
import 'package:to_do_application/utils/dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hove box
  final _mybox = Hive.box('mybox');
  TODODatabase db = TODODatabase();

  @override
  void initState() {
    // initial db
    if(_mybox.get("TODOLIST") == null){
      db.createInitialData();
    }else{
      // there are already a db
      db.loadData(); 
    }
    super.initState();
  }

  // text controller
  final _controller = TextEditingController();

  void checkboxChanged(bool? value,int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text,false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask(){
    showDialog(
      context: context,
      builder: (context){
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: ()=> Navigator.of(context).pop(),

        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text("TO DO"),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index){
          return ToDoTile(
            taskName: db.toDoList[index][0], 
            taskComplete: db.toDoList[index][1], 
            onChanged: (value) => checkboxChanged(value,index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}