import 'package:flutter/material.dart';
import 'package:planit_sprint2/authenticate/user_model.dart';
import 'package:planit_sprint2/authenticate/user_class_model.dart';
import 'package:planit_sprint2/services/database.dart';
import 'package:provider/provider.dart';
import 'package:planit_sprint2/model/course_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class EditClass extends StatefulWidget {
  Course course;

  EditClass(Course course) {
    this.course= course;
  }

  @override
  createState() => new EditClassState(course);
}

class EditClassState extends State<EditClass> {

  Course course;
  EditClassState(course) {
    this.course = course;
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

  String _currentDescription;
  String _currentStartTime;
  String _currentEndTime;
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
              automaticallyImplyLeading: false,
              title: new Text('Edit Class'),
            ),
            body: ListView(children: [
              Padding(
                padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                child: Text(course.className,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 20, color: Colors.blueAccent, fontWeight: FontWeight.bold)),
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
                  initialValue: course.description,
                  autofocus: true,
                  onChanged: (val) => setState(() => _currentDescription = val),
                  decoration: new InputDecoration(
                      contentPadding: const EdgeInsets.all(0)),
                ),
              ),



              Padding(
                padding: EdgeInsets.only(top: 12.0, left: 16.0, right: 16.0),
                child: Text("Meeting Date:",
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
                child: Text("Class Begins:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                child: new TextFormField(
                  initialValue: course.startTime,
                  autofocus: true,
                  onChanged: (val) => setState(() => _currentStartTime = val),
                  decoration: new InputDecoration(
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
                  initialValue: course.endTime,
                  autofocus: true,
                  onChanged: (val) => setState(() => _currentEndTime = val),
                  decoration: new InputDecoration(
                      contentPadding: const EdgeInsets.all(0)),
                ),
              ),


              Padding(
                padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                child: Text("Room:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                child: new TextFormField(
                  initialValue: course.room,
                  autofocus: true,
                  onChanged: (val) => setState(() => _currentRoom = val),
                  decoration: new InputDecoration(
                      contentPadding: const EdgeInsets.all(0)),
                ),
              ),


              Padding(
                padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                child: Text("Instructor",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                child: new TextFormField(
                  initialValue: course.instructor,
                  autofocus: true,
                  onChanged: (val) => setState(() => _currentInstructor = val),
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
                          await Firestore.instance.collection('classes').document(course.className).setData(
                              {
                                'User': user.uid,
                                'className': course.className,
                                'description':  _currentDescription ?? course.description,
                                'day': "${selectedDate.toLocal()}".split(' ')[0] ?? course.day,
                                'startTime':  _currentStartTime ?? course.startTime,
                                'endTime': _currentEndTime ?? course.endTime,
                                'room': _currentRoom ?? course.room,
                                'instructor': _currentInstructor ?? course.instructor,
                                'done' : course.done
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

