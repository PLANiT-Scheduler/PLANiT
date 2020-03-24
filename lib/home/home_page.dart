import 'package:flutter/material.dart';
import './home.dart';
import './classes.dart';
import './schedule.dart';
import 'package:planit_sprint2/services/database.dart';
import 'package:provider/provider.dart';
import 'package:planit_sprint2/authenticate/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planit_sprint2/model/task_model.dart';
import 'package:planit_sprint2/home/TaskDetail.dart';
import 'task.dart';


void homepage() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedPage = 0;
  final _pageOptions = [
    HomePage(),
    ClassPage(),
    SchedulePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final user = Provider.of<User>(context);
    return Scaffold(

      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ConstrainedBox(
            constraints: new BoxConstraints(
              minHeight: 200,
              maxHeight: 200,
            ),
            child: HomePage(),
          ),
          ConstrainedBox(
            constraints: new BoxConstraints(
              minHeight: 200,
              maxHeight: 200,
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

            //body: _pageOptions[_selectedPage],
            //bottomNavigationBar:
        ]

      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.description),
              title: Text('Classes'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              title: Text('Schedule'),
            ),
          ]
      ),
        floatingActionButton:FloatingActionButton(
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
}
