import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  String _phone = '';
  String _gender ='';
  String _gender1 ='';
  String radiovalue= '';

  setRadioValue(String value) {
    setState(() {
      radiovalue = _gender1;
      _gender1 = value;
      print(radiovalue);
      print(_gender);
    });
  }
  @override
  void initState() {
    super.initState();
    _name = widget.user.name;
    _bio = widget.user.bio;
    _phone = widget.user.phone;
    _gender = widget.user.gender;
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
_showDialog();
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
        phone: _phone,
        //gender: _gender,
      );
      //database update function
      DatabaseSer.updateUser(user);
      Navigator.pop(context);
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
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: Text(
      //     "แก้ไขโพรไฟล์",
      //     style: TextStyle(color: Color(0xff5A45A5)),
      //     textAlign: TextAlign.center,
      //   ),
      // ),
       appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Color(0xff5A45A5)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("แก้ไขโพรไฟล์",
            style: TextStyle(
              fontFamily: 'Kanit',
              fontWeight: FontWeight.w600,
             color: Color(0xff5A45A5)
            )),
        centerTitle: true,
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
                    initialValue: _phone,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.phone,
                          size: 30,
                        ),
                        labelText: "เบอร์โทรศัพท์"),
                    validator: (input) => input.trim().length > 100
                        ? 'Please enter a valid '
                        : null,
                    onSaved: (input) => _bio = input,
                  ),
                             Container(
                               margin: EdgeInsets.only(left: 15),
                               child: Column(
                                children: <Widget>[
                                  //  Text('เพศ'),
                                  ButtonBar(
                                    alignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Radio(
                                            onChanged: (String _gender1) {
                                              setRadioValue(_gender1);
                                            },
                                            activeColor:  Colors.purple,
                                            value: 'ชาย',
                                            groupValue: radiovalue,
                                          ),
                                          Text(
                                            'ชาย',
                                            style: TextStyle(
                                              color: Color(0xffF2551D),
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
                                            onChanged: (String _gender1) {
                                              setRadioValue(_gender1);
                                            },
                                            
                                            activeColor: Colors.purple,
                                            value: 'หญิง',
                                            groupValue: radiovalue,
                                          ),
                                          Text(
                                            'หญิง',
                                            style: TextStyle(
                                              color: Color(0xffF2551D),
                                              fontFamily: 'Kanit',
                                              // fontSize: 24,
                                              // fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )

                                ],
                            ),
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
                  // Container(
                  //   margin: EdgeInsets.all(10),
                  //   height: 40,
                  //   width: 250,
                  //   child: FlatButton(
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: new BorderRadius.circular(10.0),
                  //     ),
                  //     //กดแล้วเรียก submit fuction
                  //     onPressed: () => AuthService.logout(),
                  //     color: Colors.black38,
                  //     textColor: Colors.white,
                  //     child: Text(
                  //       "ออกจากระบบ",
                  //       style: TextStyle(fontSize: 18),
                  //     ),
                  //     //  Center(
                  //     //   child: FlatButton( //logout funtion
                  //     //     onPressed: () => AuthService.logout(),
                  //     //     child: Text('LOGOUT'),
                  //     //   ),
                  //     // )
                  //   ),
                  // )
                ],
              ),
            ),
          ),
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
        return Center(
          child: Container(
            height: 271,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              title: new Text(
                    "แก้ไขโพรไฟล์เรียบร้อย",
                    style: TextStyle(fontFamily: 'Kanit',fontSize: 18, color: purple2,fontWeight: FontWeight.w600),
                  ),
              content: Column(
                children: <Widget>[
                 
                  Text(
                    "แก้ไขโพรไฟล์เรียบร้อย",
                    style: TextStyle(fontFamily: 'Kanit', color: orage1),
                  ),
                  Icon(Icons.check_circle, size: 40, color: orage1)
                ],
              ),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text(
                    "ตกลง",
                    style: TextStyle(fontFamily: 'Kanit', color: purple2),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
