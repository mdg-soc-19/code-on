import 'package:flutter/material.dart';

import 'package:code_on/models/user.dart';
import 'package:code_on/services/api.dart';
import 'package:code_on/services/auth.dart';

class HomePage extends StatelessWidget {
  final User user;
  HomePage({this.user});
  final AuthService _auth = AuthService();
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
            TextFormField(
              onChanged: (val) => user.setUserName(val),
            ),
            RaisedButton(
              child: Text('Update Username'),
              onPressed: () async {
                final ApiService _api = ApiService();
                await _api.fetchProblemset();
                _api.fetchData(user);
              },
            ),
            RaisedButton(
              onPressed: () {
                _auth.signOut();
              },
              child: Text('LogOut'),
            ),
          ],
        ),
      ),
    );
  }
}
