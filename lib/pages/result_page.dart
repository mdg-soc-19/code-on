import 'package:code_on/models/user.dart';
import 'package:code_on/pages/recommended_list_tab.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultPage extends StatefulWidget {
  final User user;
  ResultPage({@required this.user});
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    User _user = widget.user;
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: TabBar(
                tabs: <Widget>[
                  Tab(text: 'Recommendations'),
                  Tab(text: 'Profile')
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                RecommendedListTab(
                  user: _user,
                ),
                Text('Hello There')
              ],
            )),
      ),
    );
  }
}
