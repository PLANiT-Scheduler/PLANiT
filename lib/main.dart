import 'package:flutter/material.dart';
import 'package:planit_sprint2/authenticate/user_model.dart';
import 'package:planit_sprint2/home/classDetail.dart';
import 'package:planit_sprint2/home/editClass.dart';
import 'home/myAddClasses.dart';
import 'package:planit_sprint2/services/auth.dart';
import 'package:planit_sprint2/wrapper.dart';
import 'package:provider/provider.dart';
import 'home/task.dart';
import 'authenticate/login_screen.dart';
import 'home/home_page.dart';
import 'home/addTask.dart';
import 'home/TaskDetail.dart';
import 'model/task_model.dart';
import 'home/EditTask.dart';
import 'home/upload.dart';
import 'model/course_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        routes: {
          "/login": (_) => new MyHomePage(),
          "/register": (_) => new MyHomePage(),
          "/logout": (_) => new LoginPage(),
          "/TaskPage": (_) => new TodoList(),
          "/exitTask": (_) => new MyHomePage(),
          "/addTask": (_) => new AddTask(),
          "/addImage": (_) => image(),
          "/addClass": (_) => new MyAddClasses(),
        },
        onGenerateRoute: (settings) {
          final arguments = settings.arguments;
          return MaterialPageRoute(builder: (context) {
            switch (settings.name) {
              case '/taskDetail':
                if (arguments is Task) { return TaskDetail(arguments); }
                else { return MyHomePage(); }
                break;
              case '/editTask':
                if (arguments is Task) { return EditTask(arguments); }
                else { return TodoList(); }
                break;
              case '/classDetail':
                if (arguments is Course) { return ClassDetail(arguments); }
                else { return MyHomePage(); }
                break;
              case '/editClass':
                if (arguments is Course) { return EditClass(arguments); }
                else { return TodoList(); }
                break;
              default:
                return null;
            }
          });
        },
      ),
    );
  }
}