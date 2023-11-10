import 'package:flutter/material.dart';
import 'package:to_do_application/utils/To_Do_Tile.dart';
import 'package:to_do_application/utils/dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controller
  final _controller = TextEditingController();

  List toDoList = [
  ];
  void checkboxChanged(bool? value,int index){
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }
  void saveNewTask(){
    setState(() {
      toDoList.add([_controller.text,false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
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
      toDoList.removeAt(index);
    });
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
        itemCount: toDoList.length,
        itemBuilder: (context, index){
          return ToDoTile(
            taskName: toDoList[index][0], 
            taskComplete: toDoList[index][1], 
            onChanged: (value) => checkboxChanged(value,index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
        
      ),
    );
  }
}