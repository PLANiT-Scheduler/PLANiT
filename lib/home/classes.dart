import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new ClassPage(),
    routes: <String, WidgetBuilder> {
      "/AddClassPage": (BuildContext context) => new AddClassPage(),
    }
  ));
}

class ClassPage extends StatefulWidget {
  @override
  ClassPageState createState() => ClassPageState();
}

class ClassPageState extends State<ClassPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Classes'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add), onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddClassPage()),
                  );
                  //Navigator.of(context).pushNamed("/AddClassPage");
            })
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(70.0),
              decoration: BoxDecoration(
                color: Colors.redAccent,
              ),
              alignment: Alignment.center,
              child: Text(
                'POSC 100',
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )
              ),
            ),
            Container(
              padding: EdgeInsets.all(70.0),
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              alignment: Alignment.center,
              child: Text(
                  'CPSC 471',
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )
              ),
            ),
          ]
        ),
    );
  }
}

class AddClassPage extends StatefulWidget {
  @override
  _AddClassPageState createState() => _AddClassPageState();
}

class _AddClassPageState extends State<AddClassPage> {

  String className;
  String description;

  String day;
  String timeStart;
  String timeEnd;

  String room;
  String instructor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Add class'),
        ),
        body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Class Information',
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 16.0),
                child: Divider(),
              ),
               Padding(
                 padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
                 child: TextField(
                   decoration: InputDecoration(
                     prefixIcon: Icon(Icons.person),
                     labelText: 'Class name',
                     enabledBorder: OutlineInputBorder(
                       borderSide: BorderSide(
                         color: Colors.blue,
                       )
                     ),
                     border: OutlineInputBorder(),
                   ),
                   onChanged: (value) {
                     setState(() {
                       className = value;
                     });
                   },
                 ),
                ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    labelText: 'Description',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        )
                    ),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      description = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.today),
                    labelText: 'Day',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        )
                    ),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      day = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.timer),
                    labelText: 'Start Time',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        )
                    ),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      timeStart = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.timer_off),
                    labelText: 'End Time',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        )
                    ),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      timeEnd = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on),
                    labelText: 'Room (optional)',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        )
                    ),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      room = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_pin),
                    labelText: 'Instructor (optional)',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        )
                    ),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      instructor = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: MaterialButton(
                  child: Text(
                    'Add class',
                    style: TextStyle(
                      color: Colors.blue,
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
        ),
    );
  }
}