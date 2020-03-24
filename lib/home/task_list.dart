import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:planit_sprint2/home/TaskDetail.dart';
import 'package:planit_sprint2/services/database.dart';
import 'package:provider/provider.dart';
import 'package:planit_sprint2/model/task_model.dart';
import 'package:planit_sprint2/authenticate/user_model.dart';

import 'task.dart';


class TaskList extends StatefulWidget{
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList>{


  @override
  Widget build(BuildContext context){

    final user = Provider.of<User>(context);

  return new Scaffold(
    body: StreamBuilder(
      stream: Firestore.instance.collection('plan').where('User', isEqualTo: user.uid).snapshots(),
      builder: (context, snapshot) {

        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) {
            final DocumentSnapshot document = snapshot.data.documents[index];
            Task task = new Task(
              taskName: document['taskName'] ?? 'name',
              date: document['date'] ?? 'date',
              description: document['description'] ?? 'description',
              done: document['done'] ?? false,
            );
            return Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Card(
                  margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                  color: Colors.blue[200],
                  child: InkWell (
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => TaskDetail(task)),
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () async {
                              await Firestore.instance.collection('plan').document(task.taskName).setData(
                                  {
                                    'User': user.uid,
                                    'taskName': task.taskName,
                                    'date': task.date,
                                    'description':  task.description,
                                    'done': !task.done
                                  });
                            },
                            child: task.done
                                ? Icon(Icons.check_circle, color: Colors.white)
                                : Icon(Icons.radio_button_unchecked, color: Colors.white),
                          ),
                          SizedBox(width: 8),

                        Text(task.taskName, style:TextStyle(color:Colors.white, fontSize: 20)),

                        ],
                      ),
                  )
                ),
            );
          }
        );
      },
    )
  );
  }
}