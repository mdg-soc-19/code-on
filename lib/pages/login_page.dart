import 'package:code_on/models/user.dart';
import 'package:code_on/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rect_getter/rect_getter.dart';

import 'package:code_on/services/auth.dart';
import 'package:code_on/animations/fade_animations.dart';

GlobalKey rectGetterKey = RectGetter.createGlobalKey();
Rect rect;

class LoginPage extends StatefulWidget {
  final Function toggleView;
  final Function getUser;
  LoginPage({this.toggleView, this.getUser});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  // GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  // Rect rect;
  @override
  void initState() {
    super.initState();
    User _user = widget.getUser();
    print(_user);
    if (_user != null) {
      _navigate(user: _user);
    }
  }

  String _email = '';
  String _password = '';
  Widget _ripple() {
    if (rect == null) {
      return Container();
    } else {
      return AnimatedPositioned(
          duration: Duration(seconds: 1),
          // left: (MediaQuery.of(context).size.width - (rect.bottom - rect.top)) /
          //     2,
          left: rect.left,
          right: MediaQuery.of(context).size.width - rect.right,
          // width: rect.bottom - rect.top,
          top: rect.top,
          bottom: MediaQuery.of(context).size.height - rect.bottom,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(150),
              color: Colors.blue,
            ),
            height: 48.0,
          ));
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
                      // Container(
                      //   height: 50,
                      //   margin: EdgeInsets.symmetric(horizontal: 60),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(50),
                      //     color: Color.fromRGBO(49, 39, 79, 1),
                      //   ),
                      //   child: SizedBox.expand(
                      //     child: RectGetter(
                      //       key: rectGetterKey,
                      //       child: FlatButton(
                      //         child: Text(
                      //           "Login",
                      //           style: TextStyle(color: Colors.white),
                      //         ),
                      //         onPressed: () async {
                      //           if (_formkey.currentState.validate()) {
                      //             setState(() {
                      //               rect = RectGetter.getRectFromKey(
                      //                   rectGetterKey);
                      //             });
                      //             // WidgetsBinding.instance
                      //             //     .addPostFrameCallback((_) {
                      //             //   setState(() {
                      //             //     rect = rect.inflate(1.3 *
                      //             //         MediaQuery.of(context)
                      //             //             .size
                      //             //             .longestSide);
                      //             //   });
                      //             // });
                      //             dynamic result =
                      //                 await _auth.signInWithEmailAndPassword(
                      //                     _email, _password);
                      //             if (result == null) {
                      //               print('Error');
                      //             }
                      //           }
                      //         },
                      //       ),
                      //     ),
                      //   ),
                      // )
                      ProgressButton(
                        onPressed: _onPress,
                        validate: _validate,
                        postLogin: _postLogin,
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

  bool _validate() {
    if (_formkey.currentState.validate()) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _onPress() async {
    dynamic result = await _auth.signInWithEmailAndPassword(_email, _password);
    if (result == null) {
      print('Error');
      return false;
    } else {
      return true;
    }
  }

  _postLogin() async {
    setState(() {
      rect = RectGetter.getRectFromKey(rectGetterKey);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide);
      });
    });
    await Future.delayed(Duration(seconds: 1));
    User _user = widget.getUser();
    _navigate(user: _user);
  }

  void _navigate({User user}) {
    print(user.uid);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomePage(user: user)));
  }
}

class ProgressButton extends StatefulWidget {
  final Function onPressed;
  final Function validate;
  final Function postLogin;

  const ProgressButton({Key key, this.onPressed, this.validate, this.postLogin})
      : super(key: key);

  @override
  _ProgressButtonState createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton>
    with TickerProviderStateMixin {
  bool _status = false;
  int _state = 0;
  double _width = double.infinity;
  Animation _animation;
  GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        key: _globalKey,
        height: 48.0,
        width: _width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Color.fromRGBO(49, 39, 79, 1),
        ),
        margin: EdgeInsets.symmetric(horizontal: 60),
        child: SizedBox.expand(
          child: RaisedButton(
            shape: _state != 0
                ? CircleBorder()
                : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
            padding: EdgeInsets.all(00.0),
            color: _state == 2 ? Colors.blue : Color.fromRGBO(49, 39, 79, 1),
            child:
                RectGetter(key: rectGetterKey, child: buildBuildButtonChild()),
            onPressed: () {},
            onHighlightChanged: (isPressed) {
              if (_state == 0) {
                if (widget.validate()) {
                  login();
                } else {
                  print('Validation Failed.');
                }
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildBuildButtonChild() {
    if (_state == 0) {
      return Text('Login',
          style: TextStyle(color: Colors.white, fontSize: 16.0));
    } else if (_state == 1) {
      return CircularProgressIndicator(
          value: null, valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
    } else {
      return Container(
        child: Icon(Icons.check, color: Colors.white),
        decoration: BoxDecoration(shape: BoxShape.circle),
      );
    }
  }

  void login() async {
    double initialWidth = _globalKey.currentContext.size.width;
    var controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - 48.0) * _animation.value);
        });
      });
    controller.forward();
    setState(() {
      _state = 1;
    });
    _status = await widget.onPressed();
    if (_status) {
      setState(() {
        _state = 2;
      });
      await Future.delayed(Duration(seconds: 1));
      widget.postLogin();
    } else {
      controller.reverse();
      setState(() {
        _state = 0;
      });
    }
  }
}
