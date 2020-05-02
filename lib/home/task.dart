// Import MaterialApp and other widgets which we can use to quickly create a material app
import 'package:flutter/material.dart';
import 'package:planit_sprint2/services/database.dart';
import 'package:provider/provider.dart';
import 'task_list.dart';
import 'package:planit_sprint2/model/task_model.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => new _TodoListState();
}

class _TodoListState extends State<TodoList> {

  @override
  Widget build(BuildContext context) {

//    final tasks = Provider.of<List<Task>>(context);
//
//    return ListView.builder(
//      itemCount: tasks.length,
//      itemBuilder: (context, index) {
//        return TaskTile(task: tasks[index]);
//      },
//    );

    return StreamProvider<List<Task>>.value(
        value: DatabaseService().plan,
        child: new Scaffold(
        appBar: new AppBar(
          title: new Text('Task List'),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.home),
              onPressed:  () {
                Navigator.pushReplacementNamed(context, "/exitTask");
              },
            ),
          ],
        ),
        body: TaskList(),
        floatingActionButton: new FloatingActionButton(
            onPressed:() { Navigator.pushReplacementNamed(context, "/addTask"); },// pressing this button now opens the new screen
            tooltip: 'Add task',
            child: new Icon(Icons.add)),
      ),
    );
  }
}


