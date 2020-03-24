import 'package:flutter/material.dart';
import 'package:planit_sprint2/authenticate/user_model.dart';
import 'package:planit_sprint2/services/database.dart';
import 'package:provider/provider.dart';
import 'package:planit_sprint2/model/task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';
import 'task.dart';

class EditTask extends StatefulWidget {
  Task task;

  EditTask(Task task) {
    this.task= task;
  }

  @override
  createState() => new EditTaskState(task);
}

class EditTaskState extends State<EditTask> {

  Task task;
  EditTaskState(task) {
    this.task = task;
  }

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  String _currentTask;
  String _currentDescription;


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {

          UserData userData = snapshot.data;

          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Edit task'),
            ),
            body: ListView(children: [
              Padding(
                padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                child: Text(task.taskName,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 20, color: Colors.blueAccent, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12.0, left: 16.0, right: 16.0),
                child: Text("Due Date",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                child: Text("${selectedDate.toLocal()}".split(' ')[0],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.blueAccent)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                child: RaisedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select date'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                child: Text("Description",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                child: new TextFormField(
                  initialValue: task.description,
                  autofocus: true,
                  onChanged: (val) => setState(() => _currentDescription = val),
                  decoration: new InputDecoration(
                      contentPadding: const EdgeInsets.all(0)),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 8.0, left: 16.0, right: 16.0),
                      child: RaisedButton(
                        onPressed: () async {
                          await Firestore.instance.collection('plan').document(task.taskName).setData(
                              {
                                'User': user.uid,
                                'taskName': task.taskName,
                                'date': "${selectedDate.toLocal()}".split(' ')[0],
                                'description':  _currentDescription,
                                'done' : task.done
                              });
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => TodoList()),
                          );
                        },
                        child: Text('Confirm'),
                        color: Colors.pink[400],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 8.0, left: 16.0, right: 16.0),
                      child: RaisedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Cancel'),
                        color: Colors.amber,
                      ),
                    ),
                  ]),
            ]),
          );

        }
    );
  }
}

