import 'package:flutter/material.dart';
import 'package:mythesis96/firebase/auth_service.dart';
import 'package:mythesis96/signup_driver.dart';

class Signup extends StatefulWidget {
  static final String id = 'signup_screen';

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formkey = GlobalKey<FormState>();
  String _username, _email, _password, _gender;

  _submit() {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      // Logging in the user w/ Firebase
      AuthService.signUpUser(context, _username, _email, _password, _gender);
    }
  }

  String radiovalue;
  
  setRadioValue(String value) {
    setState(() {
      radiovalue = value;
      _gender = value;
      print(radiovalue);
      print(_gender);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///แก้ button float
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,

          ///แก้ button float
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'CCARE',
                style: TextStyle(fontSize: 50),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
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
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 10, bottom: 20),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'DisplayName',
                              ),
                              validator: (input) => input.trim().isEmpty
                                  ? 'Please enter a valid DisplayName'
                                  : null,
                              onSaved: (input) => _username = input,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 10, bottom: 20),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                              ),
                              validator: (input) => !input.contains('@')
                                  ? 'Please enter a valid email'
                                  : null,
                              onSaved: (input) => _email = input,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 10, bottom: 20),
                            child: TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Password'),
                              validator: (input) => input.length < 6
                                  ? 'Must be at least 6 characters'
                                  : null,
                              onSaved: (input) => _password = input,
                              obscureText: true,
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              //  Text('เพศ'),
                              ButtonBar(
                                alignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Radio(
                                        onChanged: (String _gender) {
                                          setRadioValue(_gender);
                                         
                                        },
                                        activeColor: Colors.red,
                                        value: 'ชาย',
                                        groupValue: radiovalue,
                                        
                                      ),
                                      Text('ชาย'),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Radio(
                                        onChanged: (String _gender) {
                                          setRadioValue(_gender);
                                        
                                        },
                                        activeColor: Colors.purple,
                                        value: 'หญิง',
                                        groupValue: radiovalue,
                                      ),
                                      Text('หญิง'),
                                    ],
                                  ),
                                ],
                              )

                              // Container(
                              //   margin: EdgeInsets.only(
                              //       left: 15.0, right: 15.0, top: 10, bottom: 20),
                              //   child: Radio(
                              //     value: 1,
                              //     groupValue: 1,
                              //     activeColor: Colors.purple,
                              //     onChanged: (T) {
                              //       print('ชาย');

                              //     },

                              //   ),

                              //   // TextFormField(
                              //   //   decoration: InputDecoration(labelText: 'Password'),
                              //   //   validator: (input) => input.length < 6
                              //   //       ? 'Must be at least 6 characters'
                              //   //       : null,
                              //   //   onSaved: (input) => _password = input,
                              //   //   obscureText: true,
                              //   // ),
                              // ),
                            ],
                          ),
                        ])),
              ),
              SizedBox(height: 20.0),
              Container(
                constraints: BoxConstraints.expand(height: 55, width: 340),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Color(0xff5A45A5)),
                  child: FlatButton(
                    onPressed: _submit,
                    child: Text('สมัครใช้งาน',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        )),
                  ),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(top: 30),
              //   child: Text("---มีรถ อยากหาคนนั่งมาช่วยแชร์---",
              //       style: TextStyle(
              //         color: Colors.black54,
              //         fontSize: 12,
              //       )),
              // ),
              // SizedBox(height: 20.0),
              // Container(
              //   constraints: BoxConstraints.expand(height: 55, width: 340),
              //   child: Container(
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(16),
              //         color: Color(0xffFF7240)),
              //     child: FlatButton(
              //       onPressed: () => Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => Signupdrive())),
              //       child: Text('สมัครคนขับ',
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 22,
              //           )),
              //     ),
              //   ),
              // ),
              SizedBox(height: 20.0),
              Container(
                constraints: BoxConstraints.expand(height: 55, width: 250),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.black26),
                  child: FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('กลับหน้าแรก',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
