import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:code_on/utility/user.dart';

class AuthService {
  Future<Database> database;
  String usn;
  String psw;
  AuthService() {
    database = initialize();
  }

  Future<Database> initialize() async {
    return openDatabase(join(await getDatabasesPath(), 'userlist.db'),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE users(username TEXT PRIMARY KEY, password TEXT, current INTEGER)");
    }, version: 1);
  }

  void register(String username, String password) async {
    final Database db = await database;
    User u = User(username: username, password: password, current: 1);
    usn = username;
    psw = password;
    await db.insert('users', u.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<bool> login(String username, String password) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    for (int i = 0; i < maps.length; i++) {
      if (maps[i]['username'] == username) {
        if (maps[i]['password'] == password) {
          usn = username;
          psw = password;
          db.update('users',
              User(username: username, password: password, current: 1).toMap(),
              where: "username = ?", whereArgs: [username]);
          return true;
        }
      }
    }
    return false;
  }

  Future<bool> defaultLogin() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    for (int i = 0; i < maps.length; i++) {
      if (maps[i]['current'] == 1) {
        usn = maps[i]['username'];
        psw = maps[i]['password'];
        return true;
      }
    }
    return false;
  }

  Future<void> logout() async {
    final Database db = await database;
    await db.update(
        'users', User(username: usn, password: psw, current: 0).toMap(),
        where: "username = ?", whereArgs: [usn]);
  }
}
