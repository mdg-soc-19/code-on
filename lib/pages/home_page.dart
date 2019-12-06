import 'package:code_on/main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
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
                appAuth.logout().then((_) =>
                    Navigator.of(context).pushReplacementNamed('/login'));
              },
              child: Text('LogOut'),
            )
          ],
        ),
      ),
    );
  }
}
