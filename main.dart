import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_page.dart';
import 'register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PLANit Login Screen',
      home: LoginPage(),
    );
  }
}
