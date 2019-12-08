import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:code_on/models/complex_user.dart';
import 'package:code_on/models/user.dart';
import 'database.dart';

class ApiService {
  //Function to fetch data from CodeForces servers
  Future fetchData(User user) async {
    String url =
        'https://codeforces.com/api/user.status?handle=' + user.username;
    var jsonResponse = await http.get(url);
    final DatabaseService _dataBase = DatabaseService(uid: user.uid);
    ComplexUserData u1 =
        ComplexUserData.fromJson(json.decode(jsonResponse.body));
    List<String> problems = new List();
    for (var r in u1.result) {
      if (r.verdict == Status.OK) {
        problems.add((r.problem.contestId.toString() + r.problem.index));
      }
    }
    _dataBase.updateData(user.username, problems);
    return true;
  }
}
