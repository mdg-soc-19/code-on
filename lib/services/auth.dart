import 'package:firebase_auth/firebase_auth.dart';

import 'package:code_on/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  Future<FirebaseUser> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          Fluttertoast.showToast(
              msg: "Invalid Email Address", toastLength: Toast.LENGTH_SHORT);
          break;
        case "ERROR_WRONG_PASSWORD":
          Fluttertoast.showToast(
              msg: "Wrong Password", toastLength: Toast.LENGTH_SHORT);
          break;
        case "ERROR_USER_NOT_FOUND":
          Fluttertoast.showToast(
              msg: "No such user exists, try creating a new account",
              toastLength: Toast.LENGTH_SHORT);
          break;
        case "ERROR_TO_MANY_REQUESTS":
          Fluttertoast.showToast(
              msg: "Too many requests, please wait",
              toastLength: Toast.LENGTH_SHORT);
          break;
        default:
      }
      print(error.toString());
      return null;
    }
  }

  //Register.
  Future<User> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _convertUser(user);
    } catch (error) {
      switch (error.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
          Fluttertoast.showToast(
              msg: "This Email ID already registered",
              toastLength: Toast.LENGTH_SHORT);

          break;
        case "ERROR_INVALID_EMAIL":
          Fluttertoast.showToast(
              msg: "Invalid Email ID", toastLength: Toast.LENGTH_SHORT);
          break;
        case "ERROR_WEAK_PASSWORD":
          Fluttertoast.showToast(
              msg: "Weak password", toastLength: Toast.LENGTH_SHORT);
          break;
        default:
      }
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
