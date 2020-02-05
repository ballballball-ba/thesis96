import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mythesis96/firebase/auth_service.dart';
import 'package:mythesis96/signup_driver.dart';

class Signup extends StatefulWidget {
  static final String id = 'signup_screen';

  @override
  _SignupState createState() => _SignupState();
}

var phone = new MaskTextInputFormatter(
    mask: '+66 (###) ###-##-#', filter: {"#": RegExp(r'[0-9]')});

class _SignupState extends State<Signup> {
  final _formkey = GlobalKey<FormState>();
  String _username, _email, _password, _gender,_tel;

  _submit() {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      // Logging in the user w/ Firebase
      Flushbar(
        message: 'สมัครสมาชิก เรียบร้อย',
        backgroundColor: Colors.green,
        icon: Icon(Icons.check_circle, size: 28.0, color: Colors.white),
        duration: Duration(seconds: 4),
        //leftBarIndicatorColor: Colors.blue[300],
        margin: EdgeInsets.all(8),
        borderRadius: 10,
      )..show(context);
      AuthService.signUpUser(context, _username, _email, _password, _gender, _tel);
    } else
      Flushbar(
        message: 'ไม่สามารถสมัครสมาชิกได้ ลองอีกครั้ง',
        backgroundColor: Color(0xffF2551D),
        icon: Icon(Icons.info, size: 28.0, color: Colors.white),
        duration: Duration(seconds: 5),
        //leftBarIndicatorColor: Colors.blue[300],
        margin: EdgeInsets.all(8),
        borderRadius: 10,
      )..show(context);
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

  final Color purple1 = Color(0xff5A45A5);
  final Color purple2 = Color(0xff2A1D59);
  final Color purple3 = Color(0xffBDAEF2);
  final Color orage1 = Color(0xffF2551D);
  final Color purple4 = Color(0xffA99CD9);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///แก้ button float
      body: SingleChildScrollView(
        ///แก้ button float
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              overflow: Overflow.visible,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 620.0,
                  decoration: BoxDecoration(
                      gradient: new LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xff5A45A5), Colors.white30])),
                ),
                Column(children: <Widget>[
                  Container(
                    width: 160,
                    height: 160,
                    margin: EdgeInsets.only(top: 40),
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
                    child: Text(
                      'สมัครสมาชิก',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Kanit',
                        fontSize: 24,
                        // fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
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
                      left: 32.0,
                      right: 32.0,
                      top: 20,
                    ),
                    child: Form(
                      key: _formkey,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 30, bottom: 20),
                              decoration: BoxDecoration(
                                  color: purple4,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon:
                                      Icon(Icons.person, color: Colors.white),
                                  hintText: 'DisplayName',
                                  hintStyle: TextStyle(
                                      color: Colors.white70,
                                      fontFamily: 'Kanit',
                                      fontSize: 18
                                      // fontWeight: FontWeight.w600,
                                      ),
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
                              margin: EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 10, bottom: 20),
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
                            Container(
                              margin: EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                                top: 10,
                              ),
                              decoration: BoxDecoration(
                                  color: purple4,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                inputFormatters: [phone],
                                keyboardType: TextInputType.number,

                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon:
                                      Icon(Icons.phone, color: Colors.white),
                                  hintText: 'Tel.',
                                  hintStyle: TextStyle(
                                      color: Colors.white70,
                                      fontFamily: 'Kanit',
                                      fontSize: 18
                                      // fontWeight: FontWeight.w600,
                                      ),
                                ),
                                validator: (input) => input.length < 10
                                    ? 'Must be at least 10 number'
                                    : null,
                                onSaved: (input) => _tel = input,
                                // obscureText: true,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  '     ไม่จำเป็นต้องใส่เลข 0 +66 คือ 0 ',
                                  style: TextStyle(color: Colors.black38),
                                ),
                              ],
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
                                        Text(
                                          'ชาย',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Kanit',
                                            // fontSize: 24,
                                            // fontWeight: FontWeight.w600,
                                          ),
                                        ),
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
                                        Text(
                                          'หญิง',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Kanit',
                                            // fontSize: 24,
                                            // fontWeight: FontWeight.w600,
                                          ),
                                        ),
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
                          ]),
                    ),
                  ),
                ]),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              constraints: BoxConstraints.expand(height: 55, width: 340),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff5A45A5)),
                child: FlatButton(
                  onPressed: _submit,
                  child: Text(
                    'สมัครใช้งาน',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Kanit',
                      fontSize: 22,
                      // fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              constraints: BoxConstraints.expand(height: 55, width: 340),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black26),
                child: FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'กลับหน้าแรก',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Kanit',
                      fontSize: 22,
                      // fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
