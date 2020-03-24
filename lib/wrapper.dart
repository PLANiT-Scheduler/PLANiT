import 'package:flutter/material.dart';
import 'package:planit_sprint2/authenticate/login_screen.dart';
import 'package:planit_sprint2/authenticate/user_model.dart';
import 'package:planit_sprint2/home/home_page.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // accesses user data from StreamProvider in main.dart
    final user = Provider.of<User>(context);
    // every time a user signs in/out, we get a response (an event) down the "stream"
    // that stores the uid of who just signed in (or null if they are signed out) in
    // the variable user.


    // return either home or login_page widget
    if (user == null) { // if user is signed out, show login page
      return LoginPage();
    } else {    // else user is already logged in, so show homepage
      return MyHomePage();
    }
  }
}
