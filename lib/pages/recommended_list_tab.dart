import 'package:code_on/models/user.dart';
import 'package:flutter/material.dart';
import 'package:code_on/services/database.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RecommendedListTab extends StatelessWidget {
  final User user;
  RecommendedListTab({@required this.user});
  @override
  Widget build(BuildContext context) {
    final DatabaseService _dataBase = DatabaseService(uid: user.uid);

    return FutureBuilder(
      future: _dataBase.fetchRecommendation(),
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
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return makeCard(index);
                  },
                ));
          }
        } else {
          return Text('error');
        }
      },
    );
    //
  }

  Card makeCard(int index) {
    return Card(
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      elevation: 4.0,
      child: Container(
        color: Colors.white38,
        child: ListTile(
          title: Text(index.toString() + ' Hello What'),
          subtitle: Text('Here comes the ID of problem'),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right:
                        new BorderSide(width: 1.0, color: Colors.blueAccent))),
            child: Icon(Icons.autorenew, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
