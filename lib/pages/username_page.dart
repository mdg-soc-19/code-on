import 'package:code_on/animations/page_enter_animatino.dart';
import 'package:code_on/models/user.dart';
import 'package:code_on/pages/home_page.dart';
import 'package:code_on/services/api.dart';
import 'package:code_on/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:google_fonts/google_fonts.dart';

class UsernamePage extends StatefulWidget {
  final User user;
  UsernamePage(
      {Key key, @required this.user, @required AnimationController controller})
      : animation = PageEnterAnimation(controller),
        super(key: key);
  final PageEnterAnimation animation;

  @override
  _UsernamePageState createState() => _UsernamePageState();
}

class _UsernamePageState extends State<UsernamePage> {
  String _username;
  @override
  Widget build(BuildContext context) {
    User _user = widget.user;
    ApiService _api = ApiService();
    AuthService _auth = AuthService();
    PageEnterAnimation animation = widget.animation;
    print('build @ UsernamePage');
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: AnimatedBuilder(
      animation: animation.controller,
      builder: (context, child) => Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
            Widget>[
          SizedBox(
            height: 10.0,
          ),
          Transform(
            transform: Matrix4.diagonal3Values(animation.imageIconSize.value,
                animation.imageIconSize.value, 1.0),
            child: Container(
                width: size.width / 2,
                height: size.height / 3,
                padding: EdgeInsets.all(25.0),
                child: Image.asset('assets/images/icon6.png')),
          ),
          Container(
              //text
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              alignment: Alignment.topLeft,
              child: Opacity(
                opacity: animation.titleOpacity.value,
                child: Text('Hi there,',
                    style: GoogleFonts.varelaRound(
                        textStyle: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontSize: 36.0))),
              )),
          Container(
            //text
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            alignment: Alignment.topLeft,
            child: Opacity(
              opacity: animation.textOpacity.value,
              child: RichText(
                text: TextSpan(
                    style: GoogleFonts.varelaRound(
                        textStyle: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, .9),
                            fontSize: 24.0)),
                    children: <TextSpan>[
                      TextSpan(text: 'Please enter your'),
                      TextSpan(
                          text: ' CodeForces ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(255, 255, 255, 1))),
                    ]),
              ),
            ),
          ),
          Container(
            //formfeild
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            height: 50.0,
            margin: EdgeInsets.all(25.0),
            child: Opacity(
              opacity: animation.fieldOpacity.value,
              child: TextFormField(
                onChanged: (val) {
                  setState(() => _username = val);
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.white70,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    labelText: "Username",
                    labelStyle: GoogleFonts.varelaRound(
                        textStyle:
                            TextStyle(color: Colors.white70, fontSize: 24.0))),
                style: GoogleFonts.varelaRound(
                    textStyle: TextStyle(color: Colors.white, fontSize: 24.0)),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(25.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Opacity(
                  opacity: animation.fieldOpacity.value,
                  child: FlatButton(
                    onPressed: () async {
                      _user.setUserName(_username);
                      await _api.fetchAndUploadProblemset();
                      _api.fetchAndUploadData(_user);

                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => HomePage(
                                user: _user,
                                hasUsername: true,
                              )));
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Continue',
                            style: GoogleFonts.varelaRound(
                                textStyle: TextStyle(
                                    fontSize: 24.0, color: Colors.white)),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          )
                        ]),
                  ),
                ),
              ),
            ),
          )
        ]),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.indigo, Colors.indigo[100]],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
      ),
    ));
  }
}

// class UsernamePage extends StatelessWidget {
//   UsernamePage({Key key, @required AnimationController controller})
//       : animation = PageEnterAnimation(controller),
//         super(key: key);
//   final PageEnterAnimation animation;
//   @override
//   Widget build(BuildContext context) {
//     print('build @ UsernamePage');
//     String _username;
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//         body: AnimatedBuilder(
//       animation: animation.controller,
//       builder: (context, child) => Container(
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               SizedBox(
//                 height: 10.0,
//               ),
//               Transform(
//                 transform: Matrix4.diagonal3Values(
//                     animation.iconSize.value, animation.iconSize.value, 1.0),
//                 child: Container(
//                     width: size.width / 2,
//                     height: size.height / 3,
//                     padding: EdgeInsets.all(25.0),
//                     child: Image.asset('assets/images/icon6.png')),
//               ),
//               Container(
//                   //text
//                   padding: EdgeInsets.symmetric(horizontal: 25.0),
//                   alignment: Alignment.topLeft,
//                   child: Opacity(
//                     opacity: animation.titleOpacity.value,
//                     child: Text('Hi there,',
//                         style: GoogleFonts.varelaRound(
//                             textStyle: TextStyle(
//                                 color: Color.fromRGBO(255, 255, 255, 1),
//                                 fontSize: 36.0))),
//                   )),
//               Container(
//                 //text
//                 padding: EdgeInsets.symmetric(horizontal: 25.0),
//                 alignment: Alignment.topLeft,
//                 child: Opacity(
//                   opacity: animation.textOpacity.value,
//                   child: RichText(
//                     text: TextSpan(
//                         style: GoogleFonts.varelaRound(
//                             textStyle: TextStyle(
//                                 color: Color.fromRGBO(255, 255, 255, .9),
//                                 fontSize: 24.0)),
//                         children: <TextSpan>[
//                           TextSpan(text: 'Please enter your'),
//                           TextSpan(
//                               text: ' CodeForces ',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Color.fromRGBO(255, 255, 255, 1))),
//                         ]),
//                   ),
//                 ),
//               ),
//               Container(
//                 //formfeild
//                 padding: EdgeInsets.symmetric(horizontal: 10.0),
//                 height: 50.0,
//                 margin: EdgeInsets.all(25.0),
//                 child: TextFormField(
//                   onChanged: (val) {
//                     print(val);
//                     setState(){

//                     }
//                     _username = val;
//                   },
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: InputDecoration(
//                       prefixIcon: Icon(
//                         Icons.person,
//                         color: Colors.white70,
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white)),
//                       disabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white)),
//                       enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white)),
//                       labelText: "Username",
//                       labelStyle: GoogleFonts.varelaRound(
//                           textStyle:
//                               TextStyle(color: Colors.white, fontSize: 24.0))),
//                   style: GoogleFonts.varelaRound(
//                       textStyle:
//                           TextStyle(color: Colors.white, fontSize: 24.0)),
//                 ),
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.all(25.0),
//                   child: Align(
//                     alignment: Alignment.bottomCenter,
//                     child: FlatButton(
//                       onPressed: () {
//                         print(_username + 'button');
//                       },
//                       child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Text(
//                               'Continue',
//                               style: GoogleFonts.varelaRound(
//                                   textStyle: TextStyle(
//                                       fontSize: 24.0, color: Colors.white)),
//                             ),
//                             Icon(
//                               Icons.arrow_forward_ios,
//                               color: Colors.white,
//                             )
//                           ]),
//                     ),
//                   ),
//                 ),
//               )
//             ]),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//               colors: [Colors.blue, Colors.blue[100]],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight),
//         ),
//       ),
//     ));
//   }
// }
