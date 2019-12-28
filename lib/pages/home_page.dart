import 'package:code_on/pages/auth_page.dart';
import 'package:code_on/pages/result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

import 'package:code_on/pages/username_page.dart';
import 'package:code_on/models/user.dart';
import 'package:code_on/services/api.dart';
import 'package:code_on/services/auth.dart';

class HomePage extends StatefulWidget {
  final User user;
  final bool hasUsername;
  HomePage({@required this.user, @required this.hasUsername});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    print('initState @ HomePage');
    _controller =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build @ HomePage');
    User _user = widget.user;
    return widget.hasUsername
        ? ResultPage(
            user: _user,
          )
        : UsernamePage(
            user: _user,
            controller: _controller,
          );
  }
}
