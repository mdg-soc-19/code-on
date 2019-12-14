import 'dart:convert';
import 'package:code_on/models/problems.dart';
import 'package:http/http.dart' as http;

import 'package:code_on/models/complex_user.dart';
import 'package:code_on/models/user.dart';
import 'database.dart';

class ApiService {
  //Function to fetch user data from CodeForces servers
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

  //Function to fetch problemset data from CodeForces servers
  Future fetchProblemset() async {
    try {
      String url = 'https://codeforces.com/api/problemset.problems';
      var jsonResponse = await http.get(url);
      ProblemSet problemSet =
          ProblemSet.fromJson(json.decode(jsonResponse.body));
      final DatabaseService _dataBase = DatabaseService();
      List<String> problems = new List();
      for (var p in problemSet.result.problems) {
        problems.add((p.contestId.toString() + p.index));
      }
      _dataBase.updateProblem(problems);
      return true;
    } catch (error) {
      print(error.toString());
      return false;
    }
  }
}
