import 'package:code_on/models/user.dart';
import 'package:code_on/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'package:code_on/animations/fade_animations.dart';
import 'package:code_on/services/auth.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  final Function toggleView;
  final Function getUser;
  RegisterPage({this.toggleView, this.getUser});

  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<RegisterPage> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  Rect rect;

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
              gradient: LinearGradient(
                  colors: [Colors.indigo, Colors.indigo[50]],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            height: 48.0,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Stack(children: <Widget>[
      Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: height / 2,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: width / 10,
                        width: 80,
                        height: height / 4,
                        child: FadeAnimation(
                            1,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-1.png'))),
                            )),
                      ),
                      Positioned(
                        left: width * 2 / 5,
                        width: 80,
                        height: height / 6,
                        child: FadeAnimation(
                            1.3,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-2.png'))),
                            )),
                      ),
                      Positioned(
                        right: width / 10,
                        top: height / 15,
                        width: 80,
                        height: height / 6,
                        child: FadeAnimation(
                            1.5,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/clock.png'))),
                            )),
                      ),
                      Positioned(
                        child: FadeAnimation(
                            1.6,
                            Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Center(
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: height / 2,
                  width: width,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Column(
                        children: <Widget>[
                          FadeAnimation(
                              1.8,
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromRGBO(143, 148, 251, .2),
                                          blurRadius: 20.0,
                                          offset: Offset(0, 10))
                                    ]),
                                child: Form(
                                    key: _formkey,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width: width,
                                          padding: EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey[100]))),
                                          child: TextFormField(
                                            validator: (val) => val.isEmpty
                                                ? 'Enter an email'
                                                : null,
                                            onChanged: (val) {
                                              setState(() => _email = val);
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Email ID",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400])),
                                            keyboardType:
                                                TextInputType.emailAddress,
                                          ),
                                        ),
                                        Container(
                                          width: width,
                                          padding: EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            validator: (val) => val.length < 6
                                                ? 'Enter a password 6 chars or longer'
                                                : null,
                                            obscureText: true,
                                            onChanged: (val) {
                                              setState(() => _password = val);
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Password",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400])),
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                          ),
                                        )
                                      ],
                                    )),
                              )),
                          SizedBox(
                            height: 60,
                          ),
                          FadeAnimation(
                              2,
                              // Container(
                              //   width: width * 9 / 10,
                              //   height: 50,
                              //   decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(50),
                              //       gradient: LinearGradient(colors: [
                              //         Color.fromRGBO(143, 148, 251, 1),
                              //         Color.fromRGBO(143, 148, 251, .65),
                              //       ])),
                              //   child: SizedBox.expand(
                              //       child: FlatButton(
                              //     child: Text(
                              //       "Register",
                              //       style: TextStyle(
                              //           color: Colors.white,
                              //           fontWeight: FontWeight.bold),
                              //     ),
                              //     onPressed: () async {
                              //       if (_formkey.currentState.validate()) {
                              //         dynamic result = await _auth
                              //             .registerWithEmailAndPassword(
                              //                 _email, _password);
                              //         if (result == null) {
                              //           print('Error');
                              //         } else {
                              //           Navigator.of(context).pushReplacement(
                              //               MaterialPageRoute(
                              //                   builder: (context) => HomePage(
                              //                       user: result,
                              //                       hasUsername: false)));
                              //         }
                              //       }
                              //     },
                              //   )),
                              // )),
                              RectGetter(
                                key: rectGetterKey,
                                child: ProgressButton(
                                    postRegister: _postRegister,
                                    startRegister: _startRegister,
                                    validate: _validate),
                              )),
                          SizedBox(
                            height: 70,
                          ),
                          FadeAnimation(
                              1.5,
                              FlatButton(
                                child: Text(
                                  "Already Have an Account?",
                                  style: TextStyle(
                                      color: Color.fromRGBO(143, 148, 251, 1)),
                                ),
                                onPressed: () => widget.toggleView(),
                              )),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
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

  Future<User> _startRegister() async {
    User result = await _auth.registerWithEmailAndPassword(_email, _password);

    if (result == null) {
      print('Error');
      return result;
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('uid', result.uid);
      return result;
    }
  }

  void _postRegister() async {
    setState(() {
      rect = RectGetter.getRectFromKey(rectGetterKey);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide);
      });
    });
    await Future.delayed(Duration(seconds: 1));
    User user = widget.getUser();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomePage(
              user: user,
              hasUsername: false,
            )));
  }
}

class ProgressButton extends StatefulWidget {
  final Function startRegister;
  final Function validate;
  final Function postRegister;
  const ProgressButton(
      {Key key, this.postRegister, this.startRegister, this.validate})
      : super(key: key);
  @override
  _ProgressButtonState createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton>
    with TickerProviderStateMixin {
  User _status;
  int _state = 0;
  double _width = 200.0;
  Animation _animation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(143, 148, 251, 1),
            Color.fromRGBO(143, 148, 251, .65),
          ])),
      child: SizedBox.expand(
          child: FlatButton(
        shape: _state != 0
            ? CircleBorder()
            : RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        color: _state == 2 ? Colors.indigo : Color.fromRGBO(255, 255, 255, 0),
        padding: EdgeInsets.all(0.0),
        child: buildBuildButtonChild(),
        onPressed: () {},
        onHighlightChanged: (_) {
          if (_state == 0) {
            if (widget.validate()) {
              register();
            } else {
              print('Validation Failed.');
            }
          }
        },
      )),
    );
  }

  Widget buildBuildButtonChild() {
    if (_state == 0) {
      return Text('Register',
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

  void register() async {
    var controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          _width = 200 - ((200 - 48.0) * _animation.value);
        });
      });
    controller.forward();
    setState(() {
      _state = 1;
    });
    _status = await widget.startRegister();
    if (_status != null) {
      setState(() {
        _state = 2;
      });
      await Future.delayed(Duration(seconds: 1));
      widget.postRegister();
    } else {
      controller.reverse();
      setState(() {
        _state = 0;
      });
    }
  }
}
