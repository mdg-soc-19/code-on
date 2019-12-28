import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  //Collection References
  final CollectionReference userData =
      Firestore.instance.collection('userData');
  final CollectionReference problemSet =
      Firestore.instance.collection('problemSet');

  //Check for userData.
  Future<bool> checkUserData() async {
    DocumentSnapshot result = await userData.document(uid).get();
    return result.exists;
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

  Future fetchRecommendation({int type = 0}) async {
    try {
      String url =
          'https://us-central1-code-on-1.cloudfunctions.net/collaborativeFiltering?uid=' +
              uid;
      var jsonResponse = await http.get(url);
      List map = json.decode(jsonResponse.body);
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
        return 'Error';
      }
      print('reco=' + recommendation.toString());
      return map;
    } catch (error) {
      print(error.toString());
      return error;
    }
  }
}
