import 'package:flutter/material.dart';
import 'package:planit_sprint2/services/auth.dart';

class Register extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => new _RegisterState();

}

class _RegisterState extends State<Register>{

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
   return new Scaffold(
     resizeToAvoidBottomPadding: false,
     body: Column(crossAxisAlignment: CrossAxisAlignment.start,
     children: <Widget>[
       Container(
         child: Stack(
           children: <Widget>[
             Container(
               padding: EdgeInsets.fromLTRB(15.0, 50.0, 30, 0.0),
               child: Text('Create Account',
               style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
               ),
             ),
           ],
        ),
       ),
       Container(
         padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
         child: Form(
           key: _formKey,
           child: Column(
             children: <Widget>[
               TextFormField(
                 validator: (val) => val.isEmpty ? 'Please enter your first name.' : null,
                 decoration: InputDecoration(
                   labelText: 'FIRST NAME',
                   labelStyle: TextStyle(
                     fontFamily: 'Montserrat',
                     fontWeight: FontWeight.bold,
                     color: Colors.grey),
                   focusedBorder: UnderlineInputBorder(
                     borderSide: BorderSide(color: Colors.grey)
                   )
                 ),
               ),
               SizedBox(height: 10.0),

               TextFormField(
                 validator: (val) => val.isEmpty ? 'Please enter your last name.' : null,
                 decoration: InputDecoration(
                     labelText: 'LAST NAME',
                     labelStyle: TextStyle(
                         fontFamily: 'Montserrat',
                         fontWeight: FontWeight.bold,
                         color: Colors.grey),
                     focusedBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.grey)
                     )
                 ),
               ),
               SizedBox(height: 10.0),

               TextFormField(
                 validator: (val) => val.isEmpty ? 'Please enter a username.' : null,
                 decoration: InputDecoration(
                     labelText: 'USERNAME',
                     labelStyle: TextStyle(
                         fontFamily: 'Montserrat',
                         fontWeight: FontWeight.bold,
                         color: Colors.grey),
                     focusedBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.grey)
                     )
                 ),
               ),
               SizedBox(height: 10.0),

               TextFormField(
                 validator: (val) => val.isEmpty ? 'Please enter an email address.' : null,
                 onChanged: (val) {
                   setState(() => email = val);
                 },
                 decoration: InputDecoration(
                     labelText: 'EMAIL',
                     labelStyle: TextStyle(
                         fontFamily: 'Montserrat',
                         fontWeight: FontWeight.bold,
                         color: Colors.grey),
                     focusedBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.grey)
                     ),
                 ),
               ),
               SizedBox(height: 10.0),

               TextFormField(
                 obscureText: true,
                 validator: (val) => val.length < 6 ? 'Password must be at least 6 characters long.' : null,
                 onChanged: (val) {
                   setState(() => password = val);
                 },
                 decoration: InputDecoration(
                     labelText: 'PASSWORD',
                     labelStyle: TextStyle(
                         fontFamily: 'Montserrat',
                         fontWeight: FontWeight.bold,
                         color: Colors.grey),
                     focusedBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.blue)
                     )
                 ),
               ),
               SizedBox(height: 50.0),

               Container(              // container for Create Account button
                 height: 40,
                 child: Material(
                   borderRadius: BorderRadius.circular(20),
                   shadowColor: Colors.grey,
                   color: Colors.grey,
                   elevation: 7,
                   child: GestureDetector(
                     onTap: () async {
                       if(_formKey.currentState.validate()) {
                         dynamic result = await _auth.registerWithEmailAndPassword(email, password, context);
                         if(result == null) { // null means there was an error trying to register
                           setState(() => error = 'Email is invalid or already in use.');
                         }
                       }
                     },
                     child: Center(
                       child: Text(
                         'CREATE ACCOUNT',
                         style: TextStyle(
                           color: Colors.white,
                           fontWeight: FontWeight.bold,
                           fontFamily: 'Montserrat'
                         ),
                       ),
                     ),
                   ),
                 ),
               ),
               SizedBox(height: 20.0),

               Container(                               // container for login page button
                 height: 40,
                 color: Colors.transparent,
                 child: Container(
                   decoration: BoxDecoration(
                       border:Border.all(
                           color: Colors.black,
                           style: BorderStyle.solid,
                           width: 1),
                       color: Colors.transparent,
                       borderRadius: BorderRadius.circular(20)
                   ),
                   child: InkWell(
                     onTap: () {
                       Navigator.of(context).pop();
                     },
                     child:

                     Center(
                       child: Text('Login Page',
                           style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontFamily: 'Montserrat')
                       ),
                     ),
                   ),
                 ),
               ),

               SizedBox(height: 30.0),
               Text(
                 error,
                 style: TextStyle(
                     color: Colors.red,
                     fontSize: 16.0,
                     fontWeight: FontWeight.bold,
                     fontFamily: 'Montserrat',
                 ),
               ),
             ],
           ),
         ),
      ),
     ]),
   );
  }
}