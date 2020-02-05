import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mythesis96/firebase/auth_service.dart';
import 'package:mythesis96/signup.dart';

class PhoneAuth extends StatefulWidget {
  static final String id = 'phone';
  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

var phone = new MaskTextInputFormatter(
    mask: '+66 (###) ###-##-#', filter: {"#": RegExp(r'[0-9]')});

class _PhoneAuthState extends State<PhoneAuth> {
  String phoneNo;
  String smsCode;
  String verificationId;
  final Color purple1 = Color(0xff5A45A5);
  final Color purple2 = Color(0xff2A1D59);
  final Color purple3 = Color(0xffBDAEF2);
  final Color orage1 = Color(0xffF2551D);
  final Color purple4 = Color(0xffA99CD9);
  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodesent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;

      smsCodeDialog(context).then((value) {
        print('ถูกต้อง');
        // Flushbar(
        //   message: ' เรียบร้อย',
        //   backgroundColor: Colors.green,
        //   icon: Icon(
        //     Icons.assignment_turned_in,
        //     size: 28.0,
        //     color: Colors.white,
        //   ),
        //   duration: Duration(seconds: 4),
        //   //leftBarIndicatorColor: Colors.blue[300],
        //   margin: EdgeInsets.all(8),
        //   borderRadius: 10,
        // )..show(context);
      });
    };

    final PhoneVerificationCompleted verifiedSuccess =
        (AuthCredential phoneAuthCredential) {
      print('verified');
    };

    final PhoneVerificationFailed verifailed = (AuthException exception) {
      print('${exception.message}');
      _showDialog();
    };

    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user =
        await _auth.signInWithCredential(credential).then((user) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Signup(),
          ));
    }).catchError((e) {
      print(e);
    });

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: this.phoneNo,
      codeAutoRetrievalTimeout: autoRetrieve,
      codeSent: smsCodesent,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifailed,
    );
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Text(
              'กรอกรหัสที่ได้รับ',
              style: TextStyle(fontFamily: 'Kanit', color: purple1),
            ),
            content: TextField(
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'เสร็จสิ้น',
                  style: TextStyle(fontFamily: 'Kanit', color: purple1),
                ),
                onPressed: () {
                  if (this.smsCode == '123456') {
                   
                   _showDialogpass();
                    //                  MaterialPageRoute(
                    // builder: (_) =>
                    // Shareform(),),

                    print('555555555555');
                  } else {
                    _showDialogeror();
                  }
                  // FirebaseAuth.instance.currentUser().then((user) {
                  //   if (value != null) {
                  //     Navigator.of(context).pop(signIn());
                  //     //  Navigator.of(context).pushReplacementNamed('/signup_screen');
                  //   } else {
                  //
                  //   }
                  // });
                },
              ),
              FlatButton(
                  child: Text(
                    'ยกเลิก',
                    style: TextStyle(fontFamily: 'Kanit', color: purple1),
                  ),
                  onPressed: () => Navigator.of(context).pop()
                  // {
                  //   if(1+1 == 2){

                  //   }
                  //   // FirebaseAuth.instance.currentUser().then((user) {
                  //   //   if (value != null) {
                  //   //     Navigator.of(context).pop(signIn());
                  //   //     //  Navigator.of(context).pushReplacementNamed('/signup_screen');
                  //   //   } else {
                  //   //
                  //   //   }
                  //   // });
                  // },
                  )
            ],
          );
        });
  }

  signIn() {
    // FirebaseAuth.instance
    // .signInWithPhoneNumber(verificationId: verificationId, smsCode: smsCode)
    // .then((user){
    //  Navigator.of(context).pushReplacementNamed('/signup_screen');
    // }).catchErroe((e){
    // print(e);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // appBar: new AppBar(
      //   title: new Text('PhoneAuht'),
      // ),
      // body: new Center(
      //   child: Container(
      //     padding: EdgeInsets.all(25),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         TextField(
      //           decoration: InputDecoration(hintText: 'กรอกเบอร์โทรศัพท์ของคุณ'),
      //         onChanged: (value){
      //           this.phoneNo = value;
      //         },
      //         ),
      //         SizedBox(height: 10),
      //         RaisedButton(
      //           onPressed: verifyPhone,
      //           child: Text('ตรวจสอบ'),
      //         textColor: Colors.white,
      //         elevation: 7.0,
      //         color: Colors.blue,
      //         )
      //       ],
      //     ),
      //   ),

      // ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              overflow: Overflow.visible,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 400.0,
                  decoration: BoxDecoration(
                      gradient: new LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xff5A45A5), Colors.white30])),
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: new Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 40,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'กรุณากรอกเบอร์โทรศัพท์ของคุณ',
                            style: TextStyle(
                                color: purple1,
                                fontFamily: 'Kanit',
                                fontWeight: FontWeight.w600,
                                fontSize: 18
                                // fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            'เพื่อตรวจสอบ ผ่านรหัส OTP',
                            style: TextStyle(
                                color: purple1,
                                fontFamily: 'Kanit',
                                fontWeight: FontWeight.w600,
                                fontSize: 18
                                // fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(bottom: 30),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                          color: purple4,
                          borderRadius: BorderRadius.circular(10)),
                      // margin: EdgeInsets.only(
                      //     left: 15.0, right: 150, top: 10, bottom: 20),

                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [phone],

                        //  controller: _dateController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.phone, color: Colors.white),
                          hintText: 'กรอกเบอร์โทรของคุณ',

                          // suffixText: '',
                          hintStyle: TextStyle(
                              color: Colors.white70,
                              fontFamily: 'Kanit',
                              fontSize: 18
                              // fontWeight: FontWeight.w600,
                              ),
                        ),
                        validator: (input) =>
                            input.isEmpty ? 'กรุณาระบุเบอร์โทร' : null,
                        onChanged: (value) {
                          this.phoneNo = value;
                        },
                        //  onSaved: (input) => _password = input,
                        // obscureText: true,
                        // onChanged: (input) => _date = input,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '+66 (111) 111-11-1',
                          style: TextStyle(
                              color: Colors.black38,
                              fontFamily: 'Kanit',
                              fontSize: 18
                              // fontWeight: FontWeight.w600,
                              ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          'ไม่ต้องกรอก 0 ตัวหน้า',
                          style: TextStyle(
                              color: Colors.black26,
                              fontFamily: 'Kanit',
                              fontSize: 14
                              // fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.only(bottom: 40),
                      constraints:
                          BoxConstraints.expand(height: 40, width: 150),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff5A45A5)),
                        child: FlatButton(
                          onPressed: verifyPhone,

                          // onPressed: _submit,
                          child: Text('ตรวจสอบ',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Kanit',
                                fontSize: 16,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: new Text(
            "ข้อผิดพลาด",
            style: TextStyle(fontFamily: 'Kanit', color: purple1),
          ),
          content: new Text(
            "กรุณาตรวจสอบหมายเลขโทรศัพท์อีกครั้ง",
            style: TextStyle(fontFamily: 'Kanit', color: orage1),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "ตกลง",
                style: TextStyle(fontFamily: 'Kanit', color: purple2),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogeror() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: new Text(
            "ข้อผิดพลาด",
            style: TextStyle(fontFamily: 'Kanit', color: purple1),
          ),
          content: new Text(
            "กรุณาตรวจสอบหมายเลข OTP อีกครั้ง",
            style: TextStyle(fontFamily: 'Kanit', color: orage1),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "ตกลง",
                style: TextStyle(fontFamily: 'Kanit', color: purple2),
              ),
              onPressed: () {
                AuthService.logout();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void _showDialogpass() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          // title: new Text(
          //   "",
          //   style: TextStyle(fontFamily: 'Kanit', color: purple1),
          // ),
          content: new Text(
            "ตรวจสอบเรียบร้อย",
            style: TextStyle(fontFamily: 'Kanit', color: orage1),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "ตกลง",
                style: TextStyle(fontFamily: 'Kanit', color: purple2),
              ),
              onPressed: () {
           
                 Navigator.pushReplacement(context, signIn());
              },
            ),
          ],
        );
      },
    );
  }
}
