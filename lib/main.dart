import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mythesis96/bt_bar/homemain.dart';
import 'package:mythesis96/bt_bar/notifier_share.dart';
import 'package:mythesis96/feed_home.dart';
import 'package:mythesis96/login.dart';
import 'package:mythesis96/m/user_data.dart';
import 'package:mythesis96/signup.dart';
import 'package:provider/provider.dart';

import 'bt_bar/notifier_share request.dart';

void main() => runApp(MultiProvider(
      providers: [
       
        ChangeNotifierProvider(
          builder: (context) => ShareNotifier(),
        ),
        ChangeNotifierProvider(
          builder: (context) => ShareNotifier2(),
        ),
        ChangeNotifierProvider(
          builder: (context) => ShareNotifier3(),
        ),
         ChangeNotifierProvider(
          builder: (context) => ShareNotifierrequest1(),
        ),
        ChangeNotifierProvider(
          builder: (context) => ShareNotifierrequest(),
        ),
        ChangeNotifierProvider(
          builder: (context) => ShareNotifierrequest2(),
        ),
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  Widget _getScreenId() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          //เมื่อเข้าแอพมาก็จะเรียก provider มาใช้
          Provider.of<Userdata>(context).currentUserID = snapshot.data.uid;
          // Provider.of<Paydata>(context).currentPayID = snapshot.data.uid;
          //old ยังต้องเรียกฟังชันจากหน้า home มา
          // return Home(userId: snapshot.data.uid);
          return Home();
        } else {
          return Login();
        }
      },
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => Userdata(),
      child: MaterialApp(
        title: 'CCARE',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryIconTheme: Theme.of(context)
                .primaryIconTheme
                .copyWith(color: Colors.black)),
        home: _getScreenId(),
        routes: {
          Login.id: (context) => Login(),
          Signup.id: (context) => Signup(),
          Feedhome.id: (context) => Feedhome(),
        },
      ),
    );
  }
}
