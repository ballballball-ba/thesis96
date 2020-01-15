import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mythesis96/signup.dart';

class PhoneAuth extends StatefulWidget {
  static final String id = 'phone';
  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {

String phoneNo;
String smsCode;
String verificationId;

Future<void> verifyPhone() async{
  final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId){
    this.verificationId = verId;
  };
  final PhoneCodeSent smsCodesent = (String verId,[int forceCodeResend]){
    this.verificationId = verId;
    smsCodeDialog(context).then((value){
    print('ถูกต้อง');
    });
  };

 final PhoneVerificationCompleted verifiedSuccess = (AuthCredential phoneAuthCredential) {
       print('verified');
    };

  final PhoneVerificationFailed verifailed = (AuthException exception){
    print('${exception.message}');
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

Future<bool> smsCodeDialog(BuildContext context){
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return new AlertDialog(
        title: Text('กรอกรหัสที่ได้รับ'),
        content: TextField(
          onChanged: (value){
            this.smsCode= value;
          },
        ),
        contentPadding: EdgeInsets.all(10),
        actions: <Widget>[
          FlatButton(
            child: Text('เสร็จสิ้น'),
            onPressed: (){
              FirebaseAuth.instance.currentUser().then((user){
               if(user != null){
                 
                 Navigator.of(context).pop(signIn());
                //  Navigator.of(context).pushReplacementNamed('/signup_screen');
               } else{
                 Navigator.of(context).pop();
                 
               }
              });
            },
          )
        ],
      );
    }
  );
}

signIn(){
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
      appBar: new AppBar(
        title: new Text('PhoneAuht'),
      ),
      body: new Center(
        child: Container(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: 'กรอกเบอร์โทรศัพท์ของคุณ'),
              onChanged: (value){
                this.phoneNo = value;
              },
              ),
              SizedBox(height: 10),
              RaisedButton(
                onPressed: verifyPhone,
                child: Text('ตรวจสอบ'),
              textColor: Colors.white,
              elevation: 7.0,
              color: Colors.blue,
              )
            ],
          ),
        ),

      ),
    );
  }
}