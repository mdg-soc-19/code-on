import 'package:firebase_auth/firebase_auth.dart';
import 'package:code_on/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //User authorization  Stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_convertUser);
  }

  //Convert FireBaseUser to custom User.
  User _convertUser(FirebaseUser user) {
    return (user != null) ? User(uid: user.uid) : null;
  }

  //Sign-In anonymously.
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign-In with email and password.
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //Register.
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _convertUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //Sign-Out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
