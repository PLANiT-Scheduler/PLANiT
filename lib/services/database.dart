import'package:cloud_firestore/cloud_firestore.dart';
import 'package:planit_sprint2/model/task_model.dart';
import 'package:planit_sprint2/authenticate/user_model.dart';

class DatabaseService {

  final String uid;

  DatabaseService({ this.uid});

  //collection reference
  final CollectionReference planCollection = Firestore.instance.collection(
      'plan');

  Future updateTask(String taskName, String date, String description) async {
    return await planCollection.document(taskName).setData({
      'User' : uid,
      'tasks': taskName,
      'date': date,
      'description': description,
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

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      tasks: snapshot.data['tasks'],
      date: snapshot.data['date'],
      description: snapshot.data['description']
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

}