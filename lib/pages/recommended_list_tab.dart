import 'package:code_on/models/problems.dart';
import 'package:code_on/models/user.dart';
import 'package:code_on/pages/web_view.dart';
import 'package:flutter/material.dart';
import 'package:code_on/services/database.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RecommendedListTab extends StatefulWidget {
  final User user;
  RecommendedListTab({@required this.user});
  @override
  _RecommendedListTabState createState() => _RecommendedListTabState();
}

class _RecommendedListTabState extends State<RecommendedListTab> {
  User user;
  Future<List<Problem>> readRecommendations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('recommendationData')) {
      final DatabaseService _dataBase = DatabaseService(uid: user.uid);
      await _dataBase.fetchRecommendation(user: user);
    }
    var result = json.decode(prefs.getString('recommendationData'));
    return List<Problem>.from(
        result["problems"].map((x) => Problem.fromJson(x)));
  }

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    print('building list');
    return FutureBuilder(
      future: readRecommendations(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue, Colors.blue[50]],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: SpinKitChasingDots(color: Colors.white));
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error in url');
          } else {
            return Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.blue, Colors.blue[50]],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                child: LiquidPullToRefresh(
                  showChildOpacityTransition: false,
                  onRefresh: () async {
                    final DatabaseService _dataBase =
                        DatabaseService(uid: user.uid);

                    await _dataBase.fetchRecommendation(user: user);
                    Future.delayed(Duration(seconds: 1), () {
                      setState(() {});
                    });
                  },
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        margin: new EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        elevation: 4.0,
                        child: Container(
                          color: Colors.white38,
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ProblemWebView(
                                        title: snapshot.data[index].name,
                                        selectedUrl:
                                            "https://codeforces.com/problemset/problem/" +
                                                snapshot.data[index].contestID +
                                                "/" +
                                                snapshot.data[index].index,
                                      )));
                            },
                            title: Text(snapshot.data[index].name),
                            subtitle: Text(snapshot.data[index].contestID +
                                snapshot.data[index].index),
                            leading: Container(
                              padding: EdgeInsets.only(right: 12.0),
                              decoration: new BoxDecoration(
                                  border: new Border(
                                      right: new BorderSide(
                                          width: 1.0,
                                          color: Colors.blueAccent))),
                              child: Icon(Icons.autorenew, color: Colors.blue),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ));
          }
        } else {
          return Text('error');
        }
      },
    );
  }
}
