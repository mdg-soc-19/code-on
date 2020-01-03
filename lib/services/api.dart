import 'dart:convert';
import 'package:code_on/models/complex_problems.dart';
import 'package:code_on/models/problems.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:code_on/models/complex_user.dart';
import 'package:code_on/models/user.dart';
import 'database.dart';

class ApiService {
  //Function to fetch user data from CodeForces servers and upload to Database
  Future<bool> fetchAndUploadData(User user) async {
    ComplexUserData complexUserData;
    try {
      String url =
          'https://codeforces.com/api/user.status?handle=' + user.username;
      var jsonResponse = await http.get(url);
      complexUserData =
          ComplexUserData.fromJson(json.decode(jsonResponse.body));
    } catch (error) {
      print(error.toString());
      return false;
    }

    final DatabaseService _dataBase = DatabaseService(uid: user.uid);

    List<String> problems = new List();
    for (var r in complexUserData.result) {
      if (r.verdict == Status.OK) {
        problems.add((r.problem.contestId.toString() + r.problem.index));
      }
    }
    _dataBase.updateData(user.username, problems);
    return true;
  }

  //Function to fetch problemset data from CodeForces servers and upload to Database
  Future fetchAndUploadProblemset() async {
    try {
      String url = 'https://codeforces.com/api/problemset.problems';
      var jsonResponse = await http.get(url);
      ComplexProblemSet problemSet =
          ComplexProblemSet.fromJson(json.decode(jsonResponse.body));
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

  //Function to fetch user data from CodeForces
  Future<List<Problem>> fetchUserData(User user) async {
    try {
      String url =
          'https://codeforces.com/api/user.status?handle=' + user.username;
      var jsonResponse = await http.get(url);
      ComplexUserData complexUserData =
          ComplexUserData.fromJson(json.decode(jsonResponse.body));
      List<Problem> problems = new List();
      for (var i in complexUserData.result) {
        if (i.verdict == Status.OK) {
          problems.add(Problem(
              index: i.problem.index,
              contestID: i.problem.contestId.toString()));
        }
      }
      return problems;
    } catch (error) {
      print(error.toString() + 'asasdasd');
      return null;
    }
  }

  //Function to fetch problemset data from CodeForces servers
  Future<List<Problem>> fetchProblemset() async {
    try {
      String url = 'https://codeforces.com/api/problemset.problems';
      var jsonResponse = await http.get(url);
      ComplexProblemSet problemSet =
          ComplexProblemSet.fromJson(json.decode(jsonResponse.body));
      List<Problem> problems = new List();
      for (var p in problemSet.result.problems) {
        problems.add(Problem(
            index: p.index,
            contestID: p.contestId.toString(),
            name: p.name,
            points: p.points,
            tags: p.tags));
      }
      return problems;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
