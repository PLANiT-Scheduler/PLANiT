import 'package:flutter/material.dart';

import 'package:planit_sprint2/services/database.dart';
import 'package:provider/provider.dart';
import 'package:planit_sprint2/authenticate/user_class_model.dart';
import 'package:planit_sprint2/authenticate/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyAddClasses extends StatefulWidget{
  @override
  createState() => new MyAddClassesState();
}

class MyAddClassesState extends State<MyAddClasses>{

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

  String _currentClassName;
  String _currentDescription;
  String _currentstartTime ;
  String _currentEndTime ;
  String _currentRoom;
  String _currentInstructor;



  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserClassData>(
        stream: DatabaseService(uid: user.uid).userClassData,
        builder: (context, snapshot) {

          UserClassData userClassData = snapshot.data;

          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Add a new class'),
            ),
            body: ListView(children: [
              Padding(
                padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                child: Text("Course Name",
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
                  onChanged: (val) => setState(() => _currentClassName = val),
                  decoration: new InputDecoration(
                      hintText: 'Enter Course Name...',
                      contentPadding: const EdgeInsets.all(0)),
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
                  //initialValue: userData.description,
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                  autofocus: true,
                  onChanged: (val) => setState(() => _currentDescription = val),
                  decoration: new InputDecoration(
                      hintText: 'ex: 2 midterms and no final...',
                      contentPadding: const EdgeInsets.all(0)),
                ),
              ),


              Padding(
                padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                child: Text("Start Date",
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
                child: Text("Class Begins: ",
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
                  onChanged: (val) => setState(() => _currentstartTime = val),
                  decoration: new InputDecoration(
                      hintText: 'ex: 11am or 1pm...',
                      contentPadding: const EdgeInsets.all(0)),
                ),
              ),



              Padding(
                padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                child: Text("Class Ends:",
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
                  onChanged: (val) => setState(() => _currentEndTime = val),
                  decoration: new InputDecoration(
                      hintText: 'ex: 12pm or 5pm...',
                      contentPadding: const EdgeInsets.all(0)),
                ),
              ),



              Padding(
                padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                child: Text("Room number:",
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
                  onChanged: (val) => setState(() => _currentRoom = val),
                  decoration: new InputDecoration(
                      hintText: 'ex: CPSC104 ...',
                      contentPadding: const EdgeInsets.all(0)),
                ),
              ),


              Padding(
                padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                child: Text("Instructor:",
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
                  onChanged: (val) => setState(() => _currentInstructor = val),
                  decoration: new InputDecoration(
                      hintText: 'ex: Mr. Peralta',
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
                          await Firestore.instance.collection('classes').document(_currentClassName).setData(
                              {
                                'User': user.uid,
                                'className': _currentClassName,
                                'description':  _currentDescription,
                                'day': "${selectedDate.toLocal()}".split(' ')[0],
                                'startTime': _currentstartTime,
                                'endTime': _currentEndTime,
                                'room': _currentRoom,
                                'instructor': _currentInstructor,
                              });
                          Navigator.pop(context);
                        },
                        child: Text('Confirm'),
                        color: Colors.pink[400],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 8.0, left: 16.0, right: 16.0),
                      child: RaisedButton(
                        onPressed: () => Navigator.pop(context),
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
