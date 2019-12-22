import 'package:cloud_firestore/cloud_firestore.dart';

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
}
