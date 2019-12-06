class User {
  String uid;
  String username;
  String password;
  int current;
  User({this.uid});
  // User({this.current, this.username, this.password});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'current': current,
    };
  }
}
