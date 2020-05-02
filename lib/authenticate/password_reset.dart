import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:planit_sprint2/services/auth.dart';

class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String warning;

  Widget _buildEmailTF() {       // widget for building/styling email text field
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
          height: 55.0,
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
              contentPadding: EdgeInsets.only(left: 20.0),
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

  Widget _buildSubmitBtn() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () async {
            if(_formKey.currentState.validate()) {
              dynamic result = await _auth.sendPasswordResetEmail(email, context);
              if(result == 'error') {
                setState(() => error = 'Invalid email. Please try again.');
              } else {
                print('Password reset email sent.');
                setState(() => warning = 'A password reset link has been sent to $email');
              }
            }
          },
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius:  BorderRadius.circular(30.0),
          ),
          color: Colors.black87,
          child: Text(
            'SUBMIT',
            style: TextStyle(
              color: Color(0xFFF2F4F4),
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
    );
  }

  Widget _buildLoginPageBtn() {
    return Container(
        alignment: Alignment.center,
        child: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text(
              'Return to Login',
              style: TextStyle(
                color: Colors.black87,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
              ),
            )
        )
    );
  }

  Widget showAlert() {
    if (warning != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 0.0,
                ),
                child: SafeArea(
                  child: AutoSizeText(
                    warning,
                    maxLines: 3,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  Widget showError() {
    return Text(
      error,
      style: TextStyle(
        color: Colors.red,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'OpenSans',
      ),
    );
  }

  Widget resetError() {
    error = '';
    return SizedBox(height: 10.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
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
         showAlert(),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 70.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Reset Password',
                      style: TextStyle(
                        color: Colors.black87,
                        fontFamily: 'OpenSans',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    _buildEmailTF(),
                    _buildSubmitBtn(),
                    _buildLoginPageBtn(),
                    showError(),
                    resetError(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
