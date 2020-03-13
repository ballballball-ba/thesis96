import 'package:flutter/material.dart';
import 'package:mythesis96/Firebasemessaging/FirebaseMessaging.dart';
import 'package:mythesis96/phone_auth.dart';
import 'package:mythesis96/signup.dart';
import 'package:mythesis96/firebase/auth_service.dart';

class Login extends StatefulWidget {
  static final String id = 'login_screen';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  String _email, _password;
  // final PushNotificationService _pushNotificationService =
  //     locator<PushNotificationService>();
  _submit() async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      // Logging in the user w/ Firebase
      AuthService.login(_email, _password);
      /* print(_email);
      print(_password);*/
      ;
    }
  }

  final Color purple1 = Color(0xff5A45A5);
  final Color purple2 = Color(0xff2A1D59);
  final Color purple3 = Color(0xffBDAEF2);
  final Color orage1 = Color(0xffF2551D);
  final Color purple4 = Color(0xffA99CD9);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Stack(
          alignment: Alignment.center,
          overflow: Overflow.visible,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 700.0,
              decoration: BoxDecoration(
                  gradient: new LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xff5A45A5), Colors.white30])),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 160,
                    height: 160,
                    margin: EdgeInsets.only(top: 100),
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(80),
                        // border: Border.all(width: 1, color: purple1),
                        image: DecorationImage(
                      image: AssetImage(
                        'assets/images/purple2.png',
                      ),
                    )),
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: purple3,
                        boxShadow: [
                          new BoxShadow(
                              color: Colors.black12,
                              offset: new Offset(3.0, 3.0),
                              blurRadius: 15.0,
                              spreadRadius: 10.0),
                        ]),
                    margin: EdgeInsets.only(
                        left: 32.0, right: 32.0, top: 40, bottom: 20),
                    child: Form(
                        key: _formkey,
                        child: Column(children: <Widget>[
                          Container(
                            height: 50,
                            margin: EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 40, bottom: 20),
                            decoration: BoxDecoration(
                                color: purple4,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon:
                                    Icon(Icons.email, color: Colors.white),
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                    color: Colors.white70,
                                    fontFamily: 'Kanit',
                                    fontSize: 18
                                    // fontWeight: FontWeight.w600,
                                    ),
                              ),
                              validator: (input) => !input.contains('@')
                                  ? 'Please enter a valid email'
                                  : null,
                              onSaved: (input) => _email = input,
                            ),
                          ),
                          Container(
                            height: 50,
                            margin: EdgeInsets.only(
                                left: 15.0, right: 15.0, bottom: 20),
                            decoration: BoxDecoration(
                                color: purple4,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon:
                                    Icon(Icons.lock, color: Colors.white),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                    color: Colors.white70,
                                    fontFamily: 'Kanit',
                                    fontSize: 18
                                    // fontWeight: FontWeight.w600,
                                    ),
                              ),
                              validator: (input) => input.length < 6
                                  ? 'Must be at least 6 characters'
                                  : null,
                              onSaved: (input) => _password = input,
                              obscureText: true,
                            ),
                          ),
                        ])),
                  ),
                  Container(
                    constraints: BoxConstraints.expand(height: 55, width: 340),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xff5A45A5)),
                      child: FlatButton(
                        onPressed: _submit,
                        child: Text('เข้าสู่ระบบ',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Kanit',
                              fontSize: 22,
                            )),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("หากยังไม่ได้สมัครสมาชิก? ",
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'Kanit',
                              fontSize: 14,
                            )),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signup())),
                          child: Text("สมัครสมาชิก",
                              style: TextStyle(
                                color: orage1,
                                fontFamily: 'Kanit',
                                fontSize: 20,
                              )),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 20.0),
                  // Container(
                  //   constraints: BoxConstraints.expand(height: 55, width: 340),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(20),
                  //         color: Color(0xffFF7240)),
                  //     child: FlatButton(
                  //       onPressed: () => Navigator.push(context,
                  //           MaterialPageRoute(builder: (context) => Signup())),
                  //       child: Text('สมัครใช้งาน',
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontFamily: 'Kanit',
                  //             fontSize: 22,
                  //           )),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),

            // Container(
            //   margin: EdgeInsets.only(top: 50),
            //   constraints: BoxConstraints.expand(height: 55, width: 340),
            //   child: Container(
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(20),
            //         color: Color(0xff5A45A5)),
            //     child: FlatButton(
            //       onPressed: _submit,
            //       child: Text('เข้าสู่ระบบ',
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontFamily: 'Kanit',
            //             fontSize: 22,
            //           )),
            //     ),
            //   ),
            // ),
            //
          ],
        ),
      ])),
    );
    //   navigateToPhoneVerifyPage(BuildContext context) {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => MyPhoneVerifyPage()));
    // }
  }
}
