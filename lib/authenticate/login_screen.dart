import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planit_sprint2/services/auth.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String password = '';

  Widget _buildUsername() {           // function for building/styling username field
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Username',
          style: TextStyle(
            color: Colors.black87,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        Container(                     // container for username box field
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Color(0xFFF2F4F4),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow (
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ], //boxShadow
          ),
          height: 60.0,
          child: TextFormField(          // text field to type in username/email
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.black87),
            validator: (val) => val.isEmpty ? 'Please enter an email address.' : null,
            onChanged: (val) {
              setState(() => email = val);
            },
            decoration: InputDecoration(
              helperText: ' ',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 40.0),
              prefixIcon: Padding(
                padding: EdgeInsets.only(top: 19.0),
                child: Icon(
                  Icons.account_circle,
                  color: Colors.black87,
                ),
              ),
              hintText: 'Enter email address',
              hintStyle: TextStyle(
                color: Colors.black12,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildPassword() {            // function for building/styling password field
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: TextStyle(
            color: Colors.black87,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        Container(                     // container for password box field
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Color(0xFFF2F4F4),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow (
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ], //boxShadow
          ),
          height: 60.0,
          child: TextFormField(          // text field to type in password
            obscureText: true,
            style: TextStyle(color: Colors.black87),
            validator: (val) => val.isEmpty ? 'Please enter a password.' : null,
            onChanged: (val) {
              setState(() => password = val);
            },
            decoration: InputDecoration(
              helperText: ' ',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 42.0),
              prefixIcon: Padding(
                padding: EdgeInsets.only(top: 19.0),
                child: Icon(
                  Icons.lock,
                  color: Colors.black87,
                ),
              ),
              hintText: 'Enter password',
              hintStyle: TextStyle(
                color: Colors.black12,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildForgotPassword() {              // function for building forgot password button
    return Container(
        alignment: Alignment.centerRight,
        child: FlatButton(
            onPressed: () => print('Forgot password button pressed'), //{
              //Navigator.push( // navigates to forgot password screen
               // context,
               // MaterialPageRoute(builder: (context) => ForgotPass()),
             // );
            //},
            padding: EdgeInsets.only(right: 0.0),
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                color: Colors.black87,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
              ),
            )
        )
    );
  }

  Widget _buildLoginBtn() {                         // function for building login button
    return Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () async {
            if(_formKey.currentState.validate()) {
              dynamic result = await _auth.signInWithEmailAndPassword(email, password, context);
              if(result == null) { // null means there was an error trying to register
                setState(() => error = 'Invalid credentials. Please try again.');
              }
            }
//            Navigator.pushReplacementNamed(context, "/login");
          },
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius:  BorderRadius.circular(30.0),
          ),
          color: Colors.black87,
          child: Text(
            'LOGIN',
            style: TextStyle(
              color: Color(0xFFF2F4F4),
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        )
    );
  }

  Widget _buildCreateAcct() {                    // function for building create account button
    return GestureDetector(
      onTap: () {
        Navigator.push( // navigates to create account screen
          context,
          MaterialPageRoute(builder: (context) => Register()),
        );
      },
       child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Don\'t have a login?  ',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Create Account',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: <Widget>[
            Container( // container for login's background wallpaper
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [ // colors for gradient background of login page
                    Color(0xFFF2F4F4),
                    Color(0xFFE5E8E8),
                    Color(0xFFCCD1D1),
                    Color(0xFFB2BABB)
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                ),
              ),
            ),
            Container (                         // container for all fields in login page
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 260.0,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'PLANiT',
                        style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildUsername(),      // calls function to build username widget
                      SizedBox(height: 30.0),
                      _buildPassword(),
                      //_buildForgotPassword(),
                      _buildLoginBtn(),
                      _buildCreateAcct(),

                      SizedBox(height: 30.0),
                      Text(
                        error,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            )
      ])
    ); // Scaffold
  }
}

