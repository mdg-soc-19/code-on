import 'dart:convert';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_on/models/problems.dart';
import 'package:code_on/models/user.dart';
import 'package:code_on/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  //Collection References
  final CollectionReference userData =
      Firestore.instance.collection('userData');
  final CollectionReference problemSet =
      Firestore.instance.collection('problemSet');

  //Check for userData.
  Future<String> checkUserData() async {
    DocumentSnapshot result = await userData.document(uid).get();
    if (result.exists) {
      return result['username'];
    } else {
      return null;
    }
  }

  //Updates userData
  Future updateData(String username, List problems) async {
    return await userData.document(uid).setData({
      'username': username,
      'arrayOfProblems': FieldValue.arrayUnion(problems)
    });
  }

  //Updates problemSet
  Future updateProblem(List problems) async {
    return await problemSet
        .document('current')
        .setData({'arrayOfProblems': FieldValue.arrayUnion(problems)});
  }

  Future<List<Problem>> fetchRecommendation({int type = 0, User user}) async {
    List map;
    try {
      String url =
          'https://us-central1-code-on-1.cloudfunctions.net/collaborativeFiltering?uid=' +
              uid;
      var jsonResponse = await http.get(url);
      map = json.decode(jsonResponse.body);
    } catch (error) {
      print(error.toString());
      return null;
    }
    print(map);
    List recommendation = new List(map[0].length);
    if (type == 0) {
      for (int i = 0; i < map[0].length; i++) {
        recommendation[i] = map[1][i] + map[0][i];
      }
    } else if (type == 1) {
      recommendation = map[0];
    } else if (type == 2) {
      recommendation = map[1];
    } else {
      print('Wrong type selected.');
      return null;
    }
    ApiService _api = ApiService();
    List<Problem> userSolves = await _api.fetchUserData(user);
    _api.fetchAndUploadProblemset();
    List<Problem> problemSet = await _api.fetchProblemset();
    List<Problem> recommendedProblems = List();
    if (problemSet.length == recommendation.length) {
      Map<String, double> unsortedMap = Map();
      for (int i = 0; i < problemSet.length; i++) {
        for (int j = 0; j < userSolves.length; j++) {
          if ((userSolves[j].contestID + userSolves[j].index) ==
              (problemSet[i].contestID + problemSet[i].index)) {
            recommendation[i] = 0;
          }
        }
        if (recommendation[i] != 0) {
          unsortedMap[problemSet[i].contestID + problemSet[i].index] =
              recommendation[i];
        }
      }
      var sortedKeys = unsortedMap.keys.toList(growable: false)
        ..sort((k1, k2) => unsortedMap[k2].compareTo(unsortedMap[k1]));

      print(sortedKeys);
      for (int i = 0; i < 20; i++) {
        for (int j = 0; j < problemSet.length; j++) {
          if (problemSet[j].contestID + problemSet[j].index == sortedKeys[i]) {
            recommendedProblems.add(problemSet[j]);
          }
        }
      }
      SharedPreferences pref = await SharedPreferences.getInstance();

      pref.setString(
          'recommendationData',
          json.encode({
            "problems":
                List<dynamic>.from(recommendedProblems.map((x) => x.toJson()))
          }));
      return recommendedProblems;
    } else {
      print(
          '*********************************** Data Missmatch ***********************************');
      return null;
    }
  }
}
