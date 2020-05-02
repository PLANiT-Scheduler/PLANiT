import'package:cloud_firestore/cloud_firestore.dart';
import 'package:planit_sprint2/model/task_model.dart';
import 'package:planit_sprint2/authenticate/user_model.dart';
import 'package:planit_sprint2/authenticate/user_class_model.dart';
import 'package:planit_sprint2/model/course_model.dart';

class DatabaseService {

  final String uid;

  DatabaseService({ this.uid});

  //collection reference
  final CollectionReference planCollection = Firestore.instance.collection(
      'plan');
  final CollectionReference classesCollection = Firestore.instance.collection(
    'classes');

  final Firestore _firestore = Firestore.instance;


  Future updateTask(String taskName, String date, String description) async {
    return await planCollection.document(taskName).setData({
      'User' : uid,
      'tasks': taskName,
      'date': date,
      'description': description,
    });
  }
  Future updateCourse(String className, String description, String day, String startTime, String endTime, String room, String instructor) async {
    return await classesCollection.document(className).setData({
      'User' : uid,
      'classes': className,
      'description': description,
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
      'room': room,
      'instructor': instructor,
    });
  }


  Future addTask(String taskName, String date, String description) async {
    return await planCollection.document(taskName).setData({
      'User' : uid,
      'taskName': taskName,
      'date': date,
      'description': description
    });
  }
  Future addCourse(String className, String description, String day, String startTime, String endTime, String room, String instructor) async {
    return await classesCollection.document(className).setData({
      'User' : uid,
      'className': className,
      'description': description,
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
      'room': room,
      'instructor': instructor,
    });
  }



  //brew list from snapshot
  List<Task>_taskListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Task(
        taskName: doc.data['tasks'] ?? '',
        date: doc.data['date'] ?? '0000',
        description: doc.data['description'] ?? ''
      );
    }).toList();
  }
  List<Course>_courseListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Course(
        className: doc.data['className'] ?? '',
        description: doc.data['description'] ?? '',
        day: doc.data['day'] ?? '0000',
        startTime: doc.data['startTime'] ?? '0000',
        endTime: doc.data['endTime'] ?? '0000',
        room: doc.data['room'] ?? '',
        instructor: doc.data['instructor'] ?? ''
      );
    }).toList();
  }


  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      tasks: snapshot.data['tasks'],
      date: snapshot.data['date'],
      description: snapshot.data['description']
    );
  }
  UserClassData _userClassDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserClassData(
      uid: uid,
      className: snapshot.data['className'],
      description: snapshot.data['description'],
      day: snapshot.data['day'],
      startTime: snapshot.data['startTime'],
      endTime: snapshot.data['endTime'] ,
      room: snapshot.data['room'] ,
      instructor: snapshot.data['instructor']
    );
  }



  //get plan stream
  Stream<List<Task>> get plan {
    return planCollection.snapshots()
        .map(_taskListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData{
    return planCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

  //get user doc stream
  Stream<UserClassData> get userClassData{
    return planCollection.document(uid).snapshots()
        .map(_userClassDataFromSnapshot);
  }


  Stream<List<Course>> get classes {
    return classesCollection.snapshots()
        .map(_courseListFromSnapshot);
  }

}
