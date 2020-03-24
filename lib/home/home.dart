import 'package:flutter/material.dart';
import 'package:planit_sprint2/services/auth.dart';

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
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
