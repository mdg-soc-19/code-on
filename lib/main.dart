import 'package:flutter/material.dart';

import 'package:code_on/utility/authorization.dart';
import 'package:code_on/pages/login_page.dart';
import 'package:code_on/pages/home_page.dart';

AuthService appAuth = AuthService();

void main() async {
  Widget _defaultHome = LoginPage();

  bool _result = await appAuth.defaultLogin();
  if (_result) {
    _defaultHome = HomePage();
  }
  runApp(MaterialApp(
    title: 'App',
    home: _defaultHome,
    routes: <String, WidgetBuilder>{
      '/home': (BuildContext context) => HomePage(),
      '/login': (BuildContext context) => LoginPage()
    },
  ));
}
