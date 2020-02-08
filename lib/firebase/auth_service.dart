import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mythesis96/feed_home.dart';
import 'package:mythesis96/bt_bar/homemain.dart';
import 'package:mythesis96/login.dart';
import 'package:mythesis96/m/user_data.dart';
import 'package:provider/provider.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = Firestore.instance;
// // GET UID
//   Future<String> getCurrentUID() async {
//     return (await _firestore.currentUser()).uid;
//   }

  static void signUpUser(
      BuildContext context, String username, String email, String password,String gender,String tel) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser signedInUser = authResult.user;
      if (signedInUser != null) {
        _firestore.collection('/Users').document(signedInUser.uid).setData({
          'email': email,
          'gender': gender,
          'phone': tel,
          'username': username,
          'picprofileUrl': '',
        });
        //สมัครเสร็จให้ไปหน้าไหน
        //เช่็คหลังจาก สมัคร ว่าเป็น current user 
        Provider.of<Userdata>(context).currentUserID = signedInUser.uid;
       Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }
  // static void addNotireq(){
  //   String currentUserID, Share sharepost, String
  // }
  static void signUpDriver(
      BuildContext context, String username2, String email2, String password2) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: email2,
        password: password2,
      );
      FirebaseUser signUpDriver = authResult.user;
      if (signUpDriver != null) {
        _firestore.collection('/Driver').document(signUpDriver.uid).setData({
          'email': email2,
          'gender': '',
          'iduser': '',
          'username': username2,
          'picidcardUrl': '',
          'picprofileUrl': '',
          'piccartex': '',
          'piclicense': '',
        });
        //สมัครเสร็จให้ไปหน้าไหน
       Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }

 

  static void login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }
  }

  static void logout(){
    _auth.signOut();
   // Navigator.pushReplacementNamed(context, Login.id);
  }
  
}
