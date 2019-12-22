import 'package:code_on/pages/auth_page.dart';
import 'package:code_on/services/database.dart';
import 'package:flutter/material.dart';

import 'package:code_on/models/user.dart';
import 'package:code_on/services/api.dart';
import 'package:code_on/services/auth.dart';
import 'package:provider/provider.dart';

// class HomePage extends StatelessWidget {
//   final User user;
//   HomePage({this.user});
//   final AuthService _auth = AuthService();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('HomePage'),
//       ),
//       body: Container(
//         margin: EdgeInsets.all(16.0),
//         alignment: Alignment.center,
//         child: Column(
//           children: <Widget>[
//             Text('Welcome to App!'),
//             TextFormField(
//               onChanged: (val) => user.setUserName(val),
//             ),
//             RaisedButton(
//               child: Text('Update Username'),
//               onPressed: () async {
//                 final ApiService _api = ApiService();
//                 await _api.fetchProblemset();
//                 _api.fetchData(user);
//               },
//             ),
//             RaisedButton(
//               onPressed: () {
//                 _auth.signOut();
//               },
//               child: Text('LogOut'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
class HomePage extends StatefulWidget {
  final User user;
  HomePage({this.user});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    User _user = widget.user;
    ApiService _api = ApiService();
    AuthService _auth = AuthService();
    DatabaseService _dataBase = DatabaseService(uid: _user.uid);
    return FutureBuilder(
      future: _dataBase.checkUserData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return snapshot.data
              ? Scaffold(
                  backgroundColor: Colors.blue,
                  body: Container(
                    margin: EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Text('Welcome to App!'),
                        TextFormField(
                          onChanged: (val) => _user.setUserName(val),
                        ),
                        RaisedButton(
                          child: Text('Update Username'),
                          onPressed: () async {
                            await _api.fetchProblemset();
                            _api.fetchData(_user);
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
                )
              : Container(
                  color: Colors.red,
                );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(color: Colors.green);
        } else {
          return Container(
            color: Colors.purple,
          );
        }
      },
    );
  }
}
