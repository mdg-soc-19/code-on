import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';

import 'package:code_on/services/auth.dart';
import 'package:code_on/animations/fade_animations.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;
  LoginPage({this.toggleView});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  Rect rect;
  bool loading = false;

  String _email = '';
  String _password = '';
  Widget _ripple() {
    if (rect == null) {
      return Container();
    } else {
      return Positioned(
          left: rect.left,
          right: MediaQuery.of(context).size.width - rect.right,
          top: rect.top,
          bottom: MediaQuery.of(context).size.height - rect.bottom,
          child: Container(
              decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Color.fromRGBO(49, 39, 79, 1),
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(children: <Widget>[
      Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 400,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -40,
                    height: 400,
                    width: width,
                    child: FadeAnimation(
                        1,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/background-1.png'),
                                  fit: BoxFit.fill)),
                        )),
                  ),
                  Positioned(
                    height: 400,
                    width: width + 20,
                    child: FadeAnimation(
                        1.3,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/background-2.png'),
                                  fit: BoxFit.fill)),
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1.5,
                      Text(
                        "Login",
                        style: TextStyle(
                            color: Color.fromRGBO(49, 39, 79, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  FadeAnimation(
                      1.7,
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(196, 135, 198, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              )
                            ]),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]))),
                                child: TextFormField(
                                  validator: (val) => val.isEmpty
                                      ? 'Enter a valid email ID'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => _email = val);
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email ID",
                                      hintStyle: TextStyle(color: Colors.grey)),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: TextFormField(
                                  validator: (val) => val.length < 6
                                      ? 'Enter a password 6 chars or longer'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => _password = val);
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey)),
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                      1.7,
                      Center(
                          child: Text(
                        "Forgot Password?",
                        style:
                            TextStyle(color: Color.fromRGBO(196, 135, 198, 1)),
                      ))),
                  SizedBox(
                    height: 30,
                  ),
                  FadeAnimation(
                      1.9,
                      Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 60),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color.fromRGBO(49, 39, 79, 1),
                        ),
                        child: SizedBox.expand(
                          child: RectGetter(
                            key: rectGetterKey,
                            child: FlatButton(
                              child: Text(
                                "Login",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (_formkey.currentState.validate()) {
                                  setState(() {
                                    rect = RectGetter.getRectFromKey(
                                        rectGetterKey);
                                  });
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    setState(() {
                                      rect = rect.inflate(1.3 *
                                          MediaQuery.of(context)
                                              .size
                                              .longestSide);
                                    });
                                  });
                                  dynamic result =
                                      await _auth.signInWithEmailAndPassword(
                                          _email, _password);
                                  if (result == null) {
                                    print('Error');
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  FadeAnimation(
                      2,
                      Center(
                          child: FlatButton(
                        child: Text(
                          "Create Account",
                          style:
                              TextStyle(color: Color.fromRGBO(49, 39, 79, .6)),
                        ),
                        onPressed: () => widget.toggleView(),
                      ))),
                ],
              ),
            )
          ],
        ),
      ),
      _ripple()
    ]);
  }
}
