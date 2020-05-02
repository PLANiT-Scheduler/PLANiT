import 'package:cloud_firestore/cloud_firestore.dart';

class Task {

  String User;
  String taskName;
  Timestamp date;
  String description;
  bool done;

  Task({this.User, this.taskName, this.date, this.description, this.done});
}