import 'package:code_on/utility/auth.dart';
import 'package:flutter/material.dart';
import 'package:code_on/main.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  String _status = 'no-action';
  final usernamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  AuthService _auth = AuthService();

  @override
  void dispose() {
    usernamecontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Container(
        child: Column(
          children: <Widget>[
            TextField(
              controller: usernamecontroller,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Enter a username'),
            ),
            TextField(
              controller: passwordcontroller,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Enter a password'),
            ),
            RaisedButton(
              child: Text('Login for the App:(${this._status})'),
              onPressed: () {
                setState(() {
                  _status = 'loading';
                });
                _auth
                    .signInWithEmailAndPassword(
                        usernamecontroller.text, passwordcontroller.text)
                    .then((result) {
                  if (result) {
                  } else {
                    setState(() {
                      _status = 'rejected';
                    });
                  }
                });
              },
            ),
            RaisedButton(
              child: Text('Register and Login'),
              onPressed: () {
                dynamic result = _auth.registerWithEmailAndPassword(
                    usernamecontroller.text, passwordcontroller.text);
                if (result == null) {
                  print('Error');
                }
              },
            ),
            RaisedButton(
              child: Text('Login Anonymously'),
              onPressed: () async {
                final AuthService _auth = AuthService();
                dynamic user = await _auth.signInAnon();
                if (user == null) {
                  print('Error');
                } else {
                  print(user);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
