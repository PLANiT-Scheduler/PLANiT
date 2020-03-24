import 'package:flutter/material.dart';
import 'package:planit_sprint2/authenticate/user_model.dart';
import 'package:planit_sprint2/services/auth.dart';
import 'package:planit_sprint2/wrapper.dart';
import 'package:provider/provider.dart';
import 'home/task.dart';
import 'authenticate/login_screen.dart';
import 'home/home_page.dart';

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
          "/newTask": (_) => new TodoList(),
          "/exitTask": (_) => new MyHomePage(),
        },
      ),
    );
  }
}