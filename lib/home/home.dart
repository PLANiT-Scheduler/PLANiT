import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:planit_sprint2/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planit_sprint2/model/task_model.dart';
import 'package:provider/provider.dart';
import 'package:planit_sprint2/authenticate/user_model.dart';
import 'dart:math' as math;
import 'package:weather/weather.dart';

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

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  final AuthService _auth = AuthService();

  AnimationController controller;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  String _fahrenheit = 'Unknown';
  String _icon = 'Unknown';
  String _area = 'Unkonwn';
  String key = '9cb178f99559b76d0dfad327b81af1b7';
  WeatherStation ws;

  @override
  void initState() {
    super.initState();
    ws = new WeatherStation(key);
    initPlatformState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1500),
    );
  }

  Future<void> initPlatformState() async{
    queryWeather();
  }

  void queryWeather() async{
    Weather w = await ws.currentWeather();
    int fahrenheit = w.temperature.fahrenheit.round();
    String icon = w.weatherMain;
    String area = w.areaName;
    setState(() {
      _fahrenheit = fahrenheit.toString();
      _icon = icon;
      _area = area;
    });
}

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
                  Text(
                    _area + "     " + _icon + "      " + _fahrenheit + "\u2109",
                    //textDirection: TextDirection.ltr,
                    style: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.bold,
                                      color: Colors.deepOrangeAccent,
                                      fontSize: 18)
                  ),


                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2.0,
                          offset: Offset(0.0, 0.0),
                        ),
                      ],
                    ),
                      child: Align(
                        alignment: FractionalOffset.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                                "Agenda For Today",
                                style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold
                                ),
                            ),
                          ],
                        ),
                      ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      //borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
//                      border: Border(
//                        top: BorderSide(width: 1.0, color: Colors.black26),
//                        bottom: BorderSide(width: 1.0, color: Colors.black26),
//                      ),
                    ),
                    child: StreamBuilder(
                      stream: Firestore.instance.collection('plan').where('User', isEqualTo: user.uid).snapshots(),
                      builder: (context, snapshot) {
                        if(snapshot.data == null) return Container();
                        return
                          ConstrainedBox(
                              constraints: new BoxConstraints(
                                minHeight: 180,
                                maxHeight: 240,
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
                                          margin: EdgeInsets.fromLTRB(15.0, 6.0, 20.0, 0.0),
                                          color: Colors.blue[200],
                                          child: InkWell (
                                            onTap: () {
                                              Navigator.pushNamed(context, '/taskDetail', arguments: task);
                                            },
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(7.0),
                                                    child: task.done
                                                        ? Icon(Icons.check_circle, color: Colors.white)
                                                        : Icon(Icons.radio_button_unchecked, color: Colors.white),
                                                  ),
                                                ),
                                                SizedBox(width: 10),

                                                Text(task.taskName, style:TextStyle(color:Colors.white, fontSize: 18)),

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
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                      offset: Offset(0.0, 3.0),
                    ),
                  ],
                ),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: FractionalOffset.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Study Timer",
                            style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 30.0,
                                height: 1.5,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          AnimatedBuilder(
                            animation: controller,
                            builder: (BuildContext context, Widget child) {
                              return Text(
                                timerString,
                                style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 30.0,
                                    height: 1.2,
                                    //fontWeight: FontWeight.bold
                                ),
                              );
                            }),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20.0, 90.0, 20.0, 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            child: AnimatedBuilder(
                              animation: controller,
                              builder: (BuildContext context, Widget child) {
                                return Icon(controller.isAnimating ? Icons.pause : Icons.play_arrow);
                              }),
                            onPressed: () {
                              if(controller.isAnimating) controller.stop();
                              else { controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value); }
                            },
                          ),
                          RaisedButton(
                            child: AnimatedBuilder(
                                animation: controller,
                                builder: (BuildContext context, Widget child) {
                                  return Icon(controller.isAnimating ? Icons.replay : Icons.replay);
                                }),
                            onPressed: () { controller.reset(); },
                          ),
                        ],
                      ),
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

