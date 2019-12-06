import 'package:flutter/material.dart';

import 'package:code_on/services/auth.dart';

class HomePage extends StatelessWidget {
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Container(
        margin: EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Text('Welcome to App!'),
            RaisedButton(
              onPressed: () {
                _auth.signOut();
              },
              child: Text('LogOut'),
            )
          ],
        ),
      ),
    );
  }
}
