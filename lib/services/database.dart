import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  //Collection Reference
  final CollectionReference userData =
      Firestore.instance.collection('userData');

  Future updateData(String username, List problems) async {
    return await userData.document(uid).setData({
      'username': username,
      'arrayOfProblems': FieldValue.arrayUnion(problems)
    });
  }
}
