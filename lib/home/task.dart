// Import MaterialApp and other widgets which we can use to quickly create a material app
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'addTask.dart';
import 'package:planit_sprint2/services/database.dart';
import 'package:provider/provider.dart';
import 'task_list.dart';
import 'package:planit_sprint2/model/task_model.dart';

class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Task>>.value(
        value: DatabaseService().plan,
        child: new Scaffold(
        appBar: new AppBar(
          title: new Text('Task List'),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.home),
              onPressed:  () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
            ),
          ],
        ),
        body: TaskList(),
        floatingActionButton: new FloatingActionButton(
            onPressed:() {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddTask()),
              ); },// pressing this button now opens the new screen
            tooltip: 'Add task',
            child: new Icon(Icons.add)),
      ),
    );
  }
}


