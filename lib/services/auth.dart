// File uses firebase_auth package to hold firebase authentication instance for
// login, sign up, and sign out functions

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:planit_sprint2/authenticate/user_model.dart';
import 'package:planit_sprint2/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //creates a user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // setup stream that detects authentication changes (user signed in / registered)
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password, BuildContext context) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      Navigator.pushReplacementNamed(context, "/login");
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password, BuildContext context) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      Navigator.pushReplacementNamed(context, "/register");

      //create a new document for the user with the uid
      //await DatabaseService(uid: user.uid).updateUserData('exam', '0000', 'something');
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut(BuildContext context) async {
    try {
      Navigator.pushReplacementNamed(context, "/logout");
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
  // forgot password
  Future sendPasswordResetEmail(String email, BuildContext context) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch(e) {
      print(e.toString());
      return 'error';
    }
  }

}
