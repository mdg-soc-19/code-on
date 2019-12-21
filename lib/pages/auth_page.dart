import 'package:code_on/models/user.dart';
import 'package:flutter/material.dart';

import 'package:code_on/pages/login_page.dart';
import 'package:code_on/pages/register_page.dart';
import 'package:provider/provider.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  User _user;
  void _toggleView() {
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }

  User _getUser() {
    return _user;
  }

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<User>(context);
    if (showSignIn) {
      return LoginPage(
        toggleView: _toggleView,
        getUser: _getUser,
      );
    } else {
      return RegisterPage(toggleView: _toggleView);
    }
  }
}
