import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:planit_sprint2/model/course_model.dart';
import 'package:planit_sprint2/authenticate/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MyClassesApp extends StatefulWidget{

  @override
  MyClassesAppState createState() => MyClassesAppState();

}

class MyClassesAppState extends State<MyClassesApp>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final user = Provider.of<User>(context);

    return new Scaffold(
      appBar: AppBar(
        title: Text('My Class Schedule'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('classes').where('User', isEqualTo: user.uid).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.data == null) return Container();

          return ListView.builder(

              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot document = snapshot.data.documents[index];
                Course course = new Course(
                  className: document['className'] ?? 'className',
                  description: document['description'] ?? 'description',
                  day: document['day'] ?? 'day',
                  startTime: document['startTime'] ?? 'startTime',
                  endTime: document['endTime'] ?? 'endTime',
                  room: document['room'] ?? 'room',
                  instructor: document['instructor'] ?? 'instructor',
                  done: document['done'] ?? false,
                );
                return Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Card(
                      margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                      color: Colors.black87,
                      child: InkWell (
                        onTap: () {
                          Navigator.pushNamed(context, '/classDetail', arguments: course);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        course.className,
                                        style:TextStyle(
                                            color:Colors.white,
                                            fontSize: 20
                                        )
                                    ),
                                  ]
                                ),
                              ),
                            )

                          ],
                        ),
                      )
                  ),
                );
              }
          );
        },
      ),

      floatingActionButton: SpeedDial(
        // both default to 16
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
//        visible: _dialVisible,
        // If true user is forced to close dial manually
        // by tapping main button and overlay is not rendered.
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.add),
              backgroundColor: Colors.red,
              label: 'Add class',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () { Navigator.pushNamed(context, "/addClass"); }
          ),
          SpeedDialChild(
            child: Icon(Icons.add_a_photo),
            backgroundColor: Colors.blue,
            label: 'Upload Photo',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () { Navigator.pushNamed(context, "/addImage"); }
          ),
        ],
      ),
    );
  }
}
