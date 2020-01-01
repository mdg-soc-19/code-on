import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:code_on/services/auth.dart';
import 'package:code_on/models/user.dart';
import 'package:code_on/pages/auth_page.dart';

void main() => runApp(MyApp());

// void main() async {

// }
// class Wrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<User>(context);
//     print(user);
//     if (user == null) {
//       return Authenticate();
//     } else {
//       return TransitionPage(user: user);
//       // return HomePage(user: user);
//     }
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Authenticate(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
