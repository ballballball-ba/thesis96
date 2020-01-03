import 'package:flutter/material.dart';
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

  _submit() {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      // Logging in the user w/ Firebase
      AuthService.login(_email, _password);
     /* print(_email);
      print(_password);*/
    }
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
             height: MediaQuery.of(context).size.height,
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
                  margin:
                      EdgeInsets.only(left: 32.0, right: 32.0, top: 40, bottom: 20),
                  child: Form(
                      key: _formkey,
                      child:
                          Column(mainAxisSize: MainAxisSize.min, 
                          children: <Widget>[


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
                              decoration: InputDecoration(labelText: 'Password'),
                              validator: (input) => input.length < 6
                                  ? 'Must be at least 6 characters'
                                  : null,
                              onSaved: (input) => _password = input,
                              obscureText: true,
                            ),
                          
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
                      child: Text('เข้าสู่ระบบ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          )),
                    ),
                  ),
                ),
                Container(
                   margin: EdgeInsets.only(
                             top: 30),
                  child: Text("---ยังไม่ได้สมัครใช้งาน---",style: TextStyle(
                    color: Colors.black54,fontSize: 12,
                  )),

                ),
                SizedBox(height: 20.0),
                Container(
                  constraints: BoxConstraints.expand(height: 55, width: 250),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color(0xffFF7240)),
                    child: FlatButton(
                      onPressed: () => Navigator.pushNamed(context, Signup.id),
                      child: Text('สมัครใช้งาน',
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
