import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:planit_sprint2/authenticate/user_model.dart';
import 'package:planit_sprint2/model/course_model.dart';
import 'package:provider/provider.dart';


class ClassDetail extends StatefulWidget {
  Course course;
  ClassDetail(Course course) {
    this.course= course;
  }

  @override
  createState() => new ClassDetailState(course);

}

class ClassDetailState extends State<ClassDetail>{
  Course course;
  ClassDetailState(Course course) {
    this.course = course;
  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Class Detail'),
      ),
      body: ListView(children: [
        Padding(
          padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child: Text("Class Name",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 24, decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child: Text(course.className,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 20, color: Colors.blueAccent, fontWeight: FontWeight.bold)),
        ),


        Padding(
          padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child: Text("Description:",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 24, decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child:Text(course.description,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 16, color: Colors.blueGrey)),
        ),


        Padding(
          padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child: Text("Class Date:",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 24, decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child: Text(course.day,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 20, color: Colors.blueAccent, fontWeight: FontWeight.bold)),
        ),



        Padding(
          padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child: Text("Class Begins:",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 24, decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child:Text(course.startTime,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 16, color: Colors.blueGrey)),
        ),

        Padding(
          padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child: Text("Class Ends:",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 24, decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child:Text(course.endTime,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 16, color: Colors.blueGrey)),
        ),


        Padding(
          padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child: Text("Room",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 24, decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child:Text(course.room,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 16, color: Colors.blueGrey)),
        ),


        Padding(
          padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child: Text("Instructor",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 24, decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child:Text(course.instructor,
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
                    Navigator.pushReplacementNamed(context, '/editClass', arguments: course);
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
                    await Firestore.instance.collection('classes').document(course.className).delete();
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