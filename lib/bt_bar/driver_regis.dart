import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mythesis96/bt_bar/form_share.dart';
import 'package:mythesis96/firebase/database_up.dart';
import 'package:mythesis96/firebase/store.dart';
import 'package:mythesis96/m/driver_regit.dart';
import 'package:mythesis96/m/user_data.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Driverregis extends StatefulWidget {
  @override
  _DriverregisState createState() => _DriverregisState();
}

class _DriverregisState extends State<Driverregis> {
  File _image;
  File _image1;
  // File _image2;

  TextEditingController _captionController = TextEditingController();
  // String _caption = '';
  bool _isloading = false;

  _showSelectImageDialog() {
    return Platform.isAndroid ? _androidDialog() : _iosBottomSheet();
  }

  _showSelectImageDialog2() {
    return Platform.isAndroid ? _androidDialog() : _iosBottomSheet();
  }

  // _showSelectImageDialog3() {
  //   return Platform.isAndroid ? _androidDialog() : _iosBottomSheet();
  // }
  _androidDialog() {
    //print('andrioddddddd');
    showDialog(
        context: context,
        builder: (BuildContext conext) {
          return SimpleDialog(
            title: Text('เพิ่มรูปภาพ'),
            children: <Widget>[
              SimpleDialogOption(
                child: Text('ถ่ายรูป'),
                onPressed: () => _handleIma(ImageSource.camera),
              ),
              SimpleDialogOption(
                child: Text('เลือกรูปจากแกลลอรี่'),
                onPressed: () => _handleIma(ImageSource.gallery),
              ),
              SimpleDialogOption(
                child: Text(
                  'ยกเลิก',
                  style: TextStyle(
                    color: Colors.redAccent,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  _iosBottomSheet() {
    //iossssss
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            title: Text('เพิ่มรูปภาพ'),
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text('ถ่ายรูป'),
                //เรียกฟังชันใช้ตรงนี้
                onPressed: () => _handleIma(ImageSource.camera),
              ),
              CupertinoActionSheetAction(
                child: Text('เลือกรูปจากแกลลอรี่'),
                onPressed: () => _handleIma(ImageSource.gallery),
              )
            ],
            cancelButton: CupertinoActionSheetAction(
              child: Text('ยกเลิก'),
              onPressed: () => Navigator.pop(context),
            ),
          );
        });
  }

//ฟังชัน ให้สามารถเลือกรูปจาก source
  _handleIma(ImageSource source) async {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(source: source);
    File imageFile1 = await ImagePicker.pickImage(source: source);
    // File imageFile2 = await ImagePicker.pickImage(source: source);
    if (imageFile != null && imageFile1 != null) {
      // imageFile = await _cropImage(imageFile);
      setState(() {
        _image = imageFile;
        _image1 = imageFile1;
        // _image2 = imageFile2;
      });
    }
  }

// _cropImage(File imageFile)async{
//   File croppedImage = await ImageCropper.cropImage(
//     sourcePath: imageFile.path,
//     aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
//   );
//   return croppedImage;
// }

  _submit() async {
    if (!_isloading && _image != null && _image1 != null) {
      setState(() {
        _isloading = true;
      });
      Flushbar(
        message: 'สมัครคนขับ เรียบร้อย',
        icon: Icon(
          Icons.check_circle,
          size: 28.0,
          color: Color(0xffF2551D),
        ),
        duration: Duration(seconds: 4),
        //leftBarIndicatorColor: Colors.blue[300],
        margin: EdgeInsets.all(8),
        borderRadius: 10,
      )..show(context);
      // cretae
      String imageUrl = await StoreSer.uploadpost(_image);
      String imageUrl1 = await StoreSer.uploadpost1(_image1);
      //String imageUrl = await StoreSer.uploadpost(_imageFile2);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Shareform(),
        ),
      );
      var now = new DateTime.now();
      Post post = Post(
        imageUrl: imageUrl,
        imageUrl1: imageUrl1,
       
        authorId: Provider.of<Userdata>(context).currentUserID,
        timestamp: DateFormat("dd-MM-yyyy hh:mm").format(now),
      );
      DatabaseSer.sendpic(post);

      // update data
      _captionController.clear();

      setState(() {
        _image = null;
        _image1 = null;
        _isloading = false;
      });
    } else {
      Flushbar(
        message: 'ไม่สามารถสมัครคนขับได้ ลองอีกครั้ง',
        backgroundColor: Colors.red,
        icon: Icon(
          Icons.info,
          size: 28.0,
          color: Colors.white,
        ),
        duration: Duration(seconds: 4),
        //leftBarIndicatorColor: Colors.blue[300],
        margin: EdgeInsets.all(8),
        borderRadius: 10,
      )..show(context);
    }
  }

  final Color purple1 = Color(0xff5A45A5);
  final Color purple2 = Color(0xff2A1D59);
  final Color orange1 = Color(0xffF2551D);
  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Color(0xff5A45A5)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("สมัครคนขับ",
            style: TextStyle(
                fontFamily: 'Kanit',
                fontWeight: FontWeight.w600,
                color: Color(0xff5A45A5))),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: _submit,
            child: Text(
              "ยืนยัน",
              style: TextStyle(fontSize: 16, color: Color(0xffFF7240),fontFamily: 'Kanit',),
            ),
          )
        ],
      ),
      
      body: Column(
        children: <Widget>[
          _isloading
              ? Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.blue[200],
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  ),
                )
              : SizedBox.shrink(),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(
                      2.0, // horizontal, move right 10
                      2.0, // vertical, move down 10
                    ),
                  ),
                ], borderRadius: BorderRadius.circular(15)),
                child: GestureDetector(
                  onTap: _showSelectImageDialog,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[200],
                    ),
                    child: _image == null
                        ? Icon(
                            Icons.add_a_photo,
                            color: Colors.white70,
                            size: 70,
                          )
                        : Image(
                            image: FileImage(_image),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'อัพโหลดรูปใบขับขี่ของคุณ',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Kanit',
                            fontSize: 15,
                            color: orange1,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Text(
                        'กรุณาอัพโหลดรูปใบขับขี่ของคุณ เพื่อยืนยัน',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 13,
                            color: purple1,
                            fontFamily: 'Kanit'
                            ),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(
                      2.0, // horizontal, move right 10
                      2.0, // vertical, move down 10
                    ),
                  ),
                ], borderRadius: BorderRadius.circular(15)),
                child: GestureDetector(
                  onTap: _showSelectImageDialog2,
                  child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[200],
                      ),
                      child: _image1 == null
                          ? Icon(
                              Icons.add_a_photo,
                              color: Colors.white70,
                              size: 70,
                            )
                          : Image(
                              image: FileImage(_image1),
                              fit: BoxFit.cover,
                            )),
                ),
              ),

              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'อัพโหลดรูปภาพเพื่อยืนยันในการชมคอนเสิร์ตของคุณ',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Kanit',
                            fontSize: 15,
                            color: orange1,
                            fontWeight: FontWeight.bold),
                      ),Padding(padding: EdgeInsets.only(top: 10)),
                      Text(
                        'เช่น รูปบัตรคอนเสิร์ตหรือรูปบรรยากาศคอนเสิร์ตหรืออื่นๆ',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 13,
                            color: purple1,
                            fontFamily: 'Kanit'
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              // Align(
              //   alignment: Alignment.topLeft,

              // ),
            ],
          ),
        
        ],
      ),
   
      // ],
    );
  }
}
