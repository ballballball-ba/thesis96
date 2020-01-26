import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mythesis96/firebase/auth_service.dart';
import 'package:mythesis96/firebase/database_up.dart';
import 'package:mythesis96/firebase/store.dart';
import 'package:mythesis96/m/user_m.dart';

class Editprofile extends StatefulWidget {
  final User user;

  Editprofile({this.user});
  @override
  _EditprofileState createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  final _formkey = GlobalKey<FormState>();
  File _profileImage;
  String _name = '';
  String _bio = '';

  @override
  void initState() {
    super.initState();
    _name = widget.user.name;
    _bio = widget.user.bio;
  }

  _handleImageFromGallery() async {
    ///กำหนดว่าจะเอารูปจากไหน
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _profileImage = imageFile;
      });
    }
  }

  _displayProfileImage() {
    //no new ima
    if (_profileImage == null) {
      // no existing pic
      if (widget.user.profileImgUrl.isEmpty) {
        // show placeholder pic
        return AssetImage('assets/images/user_placeholder.jpg');
      } else {
        // user profile pic exis
        return CachedNetworkImageProvider(widget.user.profileImgUrl);
      }
    } else {
      //new pic
      return FileImage(_profileImage);
    }
  }

  _submit() async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();

      // setState(() {
      //   _isLoading = true;
      // });
      ///update firesotre
      String _profileImgUrl = '';

      if (_profileImage == null) {
        _profileImgUrl = widget.user.profileImgUrl;
      } else {
        //เรียก class store มาใช
        _profileImgUrl = await StoreSer.uploadUserProfileImage(
          widget.user.profileImgUrl,
          _profileImage,
        );
      }

      User user = User(
        id: widget.user.id,
        name: _name,
        profileImgUrl: _profileImgUrl,
        bio: _bio,
      );
      //database update function
      DatabaseSer.updateUser(user);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "แก้ไขโพรไฟล์",
          style: TextStyle(color: Color(0xff5A45A5)),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 60.0,
                    backgroundColor: Colors.grey,
                    backgroundImage: _displayProfileImage(),
                  ),
                  FlatButton(
                    //ติด error
                    //onPressed: _handleImageFromGallery(),
                    onPressed: _handleImageFromGallery,
                    // onPressed: () => print('อัพเดทรูปโพรไฟล์'),
                    child: Text('แก้ไขรูปโพรไฟล์',
                        style: TextStyle(color: Color(0xffF2551D))),
                  ),
                  TextFormField(
                    initialValue: _name,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          size: 30,
                        ),
                        labelText: "Display name"),
                    validator: (input) => input.trim().length < 1
                        ? 'Please enter a valid name'
                        : null,
                    onSaved: (input) => _name = input,
                  ),
                  TextFormField(
                    initialValue: _bio,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.book,
                          size: 30,
                        ),
                        labelText: "ไบโอ"),
                    validator: (input) => input.trim().length > 100
                        ? 'Please enter a valid name'
                        : null,
                    onSaved: (input) => _bio = input,
                  ),
                  Container(
                    margin: EdgeInsets.all(40),
                    height: 40,
                    width: 250,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      //กดแล้วเรียก submit fuction
                      onPressed: _submit,
                      color: Color(0xff5A45A5),
                      textColor: Colors.white,
                      child: Text(
                        "ยืนยัน",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 40,
                    width: 250,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      //กดแล้วเรียก submit fuction
                      onPressed: () => AuthService.logout(),
                      color: Colors.black38,
                      textColor: Colors.white,
                      child: Text(
                        "ออกจากระบบ",
                        style: TextStyle(fontSize: 18),
                      ),
                      //  Center(
                      //   child: FlatButton( //logout funtion
                      //     onPressed: () => AuthService.logout(),
                      //     child: Text('LOGOUT'),
                      //   ),
                      // )
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
