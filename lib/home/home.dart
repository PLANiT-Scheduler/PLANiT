import 'package:flutter/material.dart';
import 'package:planit_sprint2/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planit_sprint2/model/task_model.dart';
import 'package:provider/provider.dart';
import 'package:planit_sprint2/home/TaskDetail.dart';
import 'package:planit_sprint2/authenticate/user_model.dart';
import 'task.dart';

class MenuOptions {
  static const String SignOut = 'Sign out';
  //add more strings here for more menu options

  static const List<String> choices = <String>[
    SignOut
  ];
}

class HomePage extends StatelessWidget {

  final AuthService _auth = AuthService();


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          PopupMenuButton<String>(   // 3 dot menu button for sign out (add more options later?)
            onSelected: (choice) => choiceAction(choice, context),
            itemBuilder: (BuildContext context) {
              return MenuOptions.choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Add calendar here
            ConstrainedBox(
              constraints: new BoxConstraints(
                minHeight: 280,
                maxHeight: 280,
              ),
            ),
            Text("Agenda For Today", style:TextStyle(color:Colors.black, fontSize: 24), textAlign: TextAlign.left),
            StreamBuilder(
              stream: Firestore.instance.collection('plan').where('User', isEqualTo: user.uid).where('date', isEqualTo: "${DateTime.now().toLocal()}".split(' ')[0]).snapshots(),
              builder: (context, snapshot) {
                return
                  ConstrainedBox(
                      constraints: new BoxConstraints(
                        minHeight: 180,
                        maxHeight: 180,
                      ),
                      child:ListView.builder(
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
                      )
                  );
              },
            ),
          ]

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => TodoList()),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  // function to sign out
  void signOutUser(BuildContext context) async {
    await _auth.signOut(context);
  }

  //function for menu choices on popup menu button
  void choiceAction(String choice, BuildContext context) {
    if (choice == MenuOptions.SignOut) {
      signOutUser(context);
    }
  }
}
