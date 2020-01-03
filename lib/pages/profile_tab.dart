import 'package:code_on/pages/auth_page.dart';
import 'package:code_on/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
          margin: EdgeInsets.symmetric(vertical: 10.0),
          width: width * 9 / 10,
          height: height - 200.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(255, 255, 255, 0.9),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(196, 135, 198, .3),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                )
              ]),
        ),
        RaisedButton(
          color: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
          child: Container(
            height: 48.0,
            width: width / 4,
            child: Center(
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
          onPressed: () async {
            await _auth.signOut();
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('uid');
            prefs.remove('recommendationData');
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Authenticate()));
          },
        ),
      ]),
    );
  }
}
