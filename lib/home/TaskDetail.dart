import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planit_sprint2/authenticate/user_model.dart';
import 'package:planit_sprint2/model/task_model.dart';
import 'package:provider/provider.dart';

class TaskDetail extends StatefulWidget {
  Task task;
  TaskDetail(Task task) {
    this.task= task;
  }

  @override
  createState() => new TaskDetailState(task);

}

class TaskDetailState extends State<TaskDetail>{
  Task task;
  TaskDetailState(task) {
    this.task = task;
  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Task Detail'),
      ),
      body: ListView(children: [
        Padding(
          padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child: Text("Task Name",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 24, decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child: Text(task.taskName,
            textAlign: TextAlign.left,
            style: TextStyle(
            fontSize: 20, color: Colors.blueAccent, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child: Text("Due Date",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 24, decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
        ),
//        Padding(
//          padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
//          child: Text(
//              DateFormat.yMEd().add_jm().format(task.date.toDate()), //task.date,
//              textAlign: TextAlign.left,
//              style: TextStyle(
//                  fontSize: 20, color: Colors.blueAccent, fontWeight: FontWeight.bold)),
//        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child: Text("Description",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 24, decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child:Text(task.description,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 16, color: Colors.blueGrey)),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 8.0, left: 16.0, right: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/editTask', arguments: task);
                  },
                  child: Text('Edit'),
                  color: Colors.pink[400],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 8.0, left: 16.0, right: 16.0),
                child: RaisedButton(
                  onPressed: () async{
                    await Firestore.instance.collection('plan').document(task.taskName).delete();
                    Navigator.pop(context);
                  },
                  child: Text('Delete'),
                  color: Colors.amber,
                ),
              ),
            ]),
      ]),
    );
  }

}