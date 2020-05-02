import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:planit_sprint2/authenticate/user_model.dart';
import 'package:planit_sprint2/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTask extends StatefulWidget {
  @override
  createState() => new AddTaskState();
}

class AddTaskState extends State<AddTask> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await DatePicker.showDateTimePicker(context, showTitleActions: true);
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
//  Future<Null> _selectDate(BuildContext context) async {
//    final DateTime picked = await showDatePicker(
//        context: context,
//        initialDate: selectedDate,
//        firstDate: DateTime(2015, 8),
//        lastDate: DateTime(2101));
//    if (picked != null && picked != selectedDate)
//      setState(() {
//        selectedDate = picked;
//      });
//  }

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
              title: new Text('Add a new task'),
            ),
            body: ListView(children: [
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
                child: Text("Task Name",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                child: new TextFormField(
                  //initialValue: userData.tasks,
                  style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                  autofocus: true,
                  onChanged: (val) => setState(() => _currentTask = val),
                  decoration: new InputDecoration(
                      hintText: 'Enter something to do...',
                      contentPadding: const EdgeInsets.all(0)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
                child: Text("Due Date",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                child: Text(
                  DateFormat.yMEd().add_jm().format(selectedDate),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.blueAccent)
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                child: RaisedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select date'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
                child: Text("Description",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                child: new TextFormField(
                  //initialValue: userData.description,
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                  autofocus: true,
                  onChanged: (val) => setState(() => _currentDescription = val),
                  decoration: new InputDecoration(
                      hintText: 'Enter something to do...',
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
                          await Firestore.instance.collection('plan').document(_currentTask).setData(
                              {
                                'User': user.uid,
                                'taskName': _currentTask,
                                'date': Timestamp.fromDate(selectedDate), //"${selectedDate.toLocal()}".split(' ')[0],
                                'description':  _currentDescription,
                                'done': false
                              });
                          Navigator.pushReplacementNamed(context, "/TaskPage");
                        },
                        child: Text('Confirm'),
                        color: Colors.pink[400],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 8.0, left: 16.0, right: 16.0),
                      child: RaisedButton(
                        onPressed: () => Navigator.pushReplacementNamed(context, "/TaskPage"),
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

