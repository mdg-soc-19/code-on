import 'package:code_on/pages/auth_page.dart';
import 'package:code_on/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.blue[50]],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Column(children: <Widget>[
        Container(
          height: 50.0,
          child: Center(
            child: RaisedButton(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)),
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                await _auth.signOut();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('uid');
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Authenticate()));
              },
            ),
          ),
        ),
      ]),
    );
  }
}
