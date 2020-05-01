import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:planit_sprint2/model/currentTask.dart';
import 'package:planit_sprint2/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planit_sprint2/model/task_model.dart';
import 'package:planit_sprint2/services/database.dart';
import 'package:planit_sprint2/services/timeLeft.dart';
import 'package:provider/provider.dart';
import 'package:planit_sprint2/authenticate/user_model.dart';

class MenuOptions {
  static const String SignOut = 'Sign out';
  //add more strings here for more menu options

  static const List<String> choices = <String>[
    SignOut
  ];
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();

  String _timeUntil; // time until next task is due

  Timer _timer;

  void _startTimer(CurrentTask currentTask) {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _timeUntil = OurTimeLeft().timeLeft(currentTask.getCurrentTask.date.toDate());
      });
    });
  }


  @override
//  void initState() {
//    super.initState();
//
//    CurrentTask _currentTask = Provider.of<CurrentTask>(context, listen: false);
//    _currentTask.updateStateFromDatabase(_currentTask.getCurrentTask.taskName);
//    _startTimer(_currentTask);
//  }

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
      body: ListView(
        children: <Widget>[
          Container(
            child: SingleChildScrollView(
              child: Column(
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
                    stream: Firestore.instance.collection('plan').where('User', isEqualTo: user.uid).snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.data == null) return Container();
                      return
                        ConstrainedBox(
                            constraints: new BoxConstraints(
                              minHeight: 180,
                              maxHeight: 293,
                            ),
                            child:ListView.builder(
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, index) {
                                  final DocumentSnapshot document = snapshot.data.documents[index];
                                  Task task = new Task(
                                    taskName: document['taskName'] ?? 'name',
                                    date: document.data['date'] ?? Timestamp.fromDate(DateTime.now()),
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
                                            Navigator.pushNamed(context, '/taskDetail', arguments: task);
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
                                              SizedBox(width: 50),

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
                ],
              ),
            ),
          ),

          SizedBox(height: 40),
          Container(              // container for countdown timer
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                      offset: Offset(
                        0.0,
                        3.0,
                      ),
                    ),
                  ],
                ),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Task name here",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Due In: ",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.grey,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              _timeUntil ?? "loading...",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    RaisedButton(
                      child: Text(
                        "Finished Task",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => print("Finished Task button pressed!"),
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, "/TaskPage");
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


//class HomePage extends StatelessWidget {
//
//  final AuthService _auth = AuthService();
//
//  String _timeUntil; // time until next task is due
//
//  Timer _timer;
//
//  void _startTimer(CurrentTask currentTask) {
//    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//      setState(() {
//        _timeUntil = OurTimeLeft().timeLeft(currentTask.getCurrentTask.)
//      });
//    });
//  }
//
//
//  @override
//  void initState() {
//    super.initState();
//    CurrentTask _currentTask = Provider.of<CurrentTask>(context, listen: false);
//    _currentTask.updateStateFromDatabase(_currentTask.getCurrentTask.date.toDate());
//    _startTimer(_currentTask);
//  }
//
//  Widget build(BuildContext context) {
//    final user = Provider.of<User>(context);
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Home Page'),
//        actions: <Widget>[
//          PopupMenuButton<String>(   // 3 dot menu button for sign out (add more options later?)
//            onSelected: (choice) => choiceAction(choice, context),
//            itemBuilder: (BuildContext context) {
//              return MenuOptions.choices.map((String choice){
//                return PopupMenuItem<String>(
//                  value: choice,
//                  child: Text(choice),
//                );
//              }).toList();
//            },
//          ),
//        ],
//      ),
//      body: ListView(
//          children: <Widget>[
//            Container(
//                child: SingleChildScrollView(
//                  child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        //Add calendar here
//                        ConstrainedBox(
//                          constraints: new BoxConstraints(
//                            minHeight: 280,
//                            maxHeight: 280,
//                          ),
//                        ),
//                        Text("Agenda For Today", style:TextStyle(color:Colors.black, fontSize: 24), textAlign: TextAlign.left),
//                        StreamBuilder(
//                        stream: Firestore.instance.collection('plan').where('User', isEqualTo: user.uid).snapshots(),
//                        builder: (context, snapshot) {
//                          if(snapshot.data == null) return Container();
//                            return
//                              ConstrainedBox(
//                                  constraints: new BoxConstraints(
//                                    minHeight: 180,
//                                    maxHeight: 293,
//                                  ),
//                                  child:ListView.builder(
//                                      itemCount: snapshot.data.documents.length,
//                                      itemBuilder: (context, index) {
//                                        final DocumentSnapshot document = snapshot.data.documents[index];
//                                        Task task = new Task(
//                                          taskName: document['taskName'] ?? 'name',
//                                          date: document.data['date'] ?? Timestamp.fromDate(DateTime.now()),
//                                          description: document['description'] ?? 'description',
//                                          done: document['done'] ?? false,
//                                        );
//                                        return Padding(
//                                          padding: EdgeInsets.only(top: 8.0),
//                                          child: Card(
//                                              margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
//                                              color: Colors.blue[200],
//                                              child: InkWell (
//                                                onTap: () {
//                                                  Navigator.pushNamed(context, '/taskDetail', arguments: task);
//                                                },
//                                                child: Row(
//                                                  crossAxisAlignment: CrossAxisAlignment.center,
//                                                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                                  children: <Widget>[
//                                                    GestureDetector(
//                                                      onTap: () async {
//                                                        await Firestore.instance.collection('plan').document(task.taskName).setData(
//                                                            {
//                                                              'User': user.uid,
//                                                              'taskName': task.taskName,
//                                                              'date': task.date,
//                                                              'description':  task.description,
//                                                              'done': !task.done
//                                                            });
//                                                      },
//                                                      child: task.done
//                                                          ? Icon(Icons.check_circle, color: Colors.white)
//                                                          : Icon(Icons.radio_button_unchecked, color: Colors.white),
//                                                    ),
//                                                    SizedBox(width: 50),
//
//                                                    Text(task.taskName, style:TextStyle(color:Colors.white, fontSize: 20)),
//
//                                                  ],
//                                                ),
//                                              )
//                                          ),
//                                        );
//                                      }
//                                  )
//                              );
//                          },
//                        ),
//                      ],
//                    ),
//                ),
//            ),
//
//            SizedBox(height: 40),
//            Container(              // container for countdown timer
//              child: Padding(
//                padding: const EdgeInsets.all(20.0),
//                child: Container(
//                  padding: EdgeInsets.all(20.0),
//                  decoration: BoxDecoration(
//                    color: Colors.white,
//                    borderRadius: BorderRadius.circular(20.0),
//                    boxShadow: [
//                      BoxShadow(
//                        color: Colors.grey,
//                        blurRadius: 5.0,
//                        offset: Offset(
//                          0.0,
//                          3.0,
//                        ),
//                      ),
//                    ],
//                  ),
//                  child: Column(
//                    //crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Text(
//                        "Task name here",
//                        style: TextStyle(
//                          fontSize: 30,
//                          color: Colors.grey,
//                        ),
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.symmetric(vertical: 20.0),
//                        child: Row(
//                          children: <Widget>[
//                            Text(
//                              "Due In: ",
//                              style: TextStyle(
//                                fontSize: 30,
//                                color: Colors.grey,
//                              ),
//                            ),
//                            Expanded(
//                              child: Text(
//                                _timeUntil ?? "loading...",
//                                style: TextStyle(
//                                  fontSize: 30,
//                                  color: Colors.grey,
//                                ),
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                      RaisedButton(
//                        child: Text(
//                          "Finished Task",
//                          style: TextStyle(color: Colors.white),
//                        ),
//                        onPressed: () => print("Finished Task button pressed!"),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            ),
//
//          ],
//        ),
//        floatingActionButton: FloatingActionButton(
//          onPressed: () {
//            Navigator.pushReplacementNamed(context, "/TaskPage");
//          },
//          tooltip: 'Increment',
//          child: Icon(Icons.add),
//        ),
//      );
//  }
//
//  // function to sign out
//  void signOutUser(BuildContext context) async {
//    await _auth.signOut(context);
//  }
//
//  //function for menu choices on popup menu button
//  void choiceAction(String choice, BuildContext context) {
//    if (choice == MenuOptions.SignOut) {
//      signOutUser(context);
//    }
//  }
//}
