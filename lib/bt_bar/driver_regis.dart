import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mythesis96/firebase/database_up.dart';
import 'package:mythesis96/firebase/store.dart';
import 'package:mythesis96/m/driver_regit.dart';
import 'package:mythesis96/m/user_data.dart';
import 'package:provider/provider.dart';

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
    if (_isloading && _image != null && _image1 != null) {
      setState(() {
        _isloading = true;
      });
      // cretae
      String imageUrl = await StoreSer.uploadpost(_image);
      String imageUrl1 = await StoreSer.uploadpost1(_image1);
      //String imageUrl = await StoreSer.uploadpost(_imageFile2);

      Post post = Post(
        imageUrl: imageUrl,
        imageUrl1: imageUrl1,
        likes: {},
        authorId: Provider.of<Userdata>(context).currentUserID,
        timestamp: Timestamp.fromDate(DateTime.now()),
      );
      DatabaseSer.sendpic(post);
      
      // update data
      _captionController.clear();

      setState(() {
        _image = null;
        _image1 = null;
        _isloading = false;
      });
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
        backgroundColor: Colors.white,
        title: Text(
          "สมัครคนขับ",
          style: TextStyle(color: Color(0xff5A45A5)),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: _submit,
            child: Text(
              "ยืนยัน",
              style: TextStyle(fontSize: 16, color: Color(0xffFF7240)),
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
                  child: Text(
                    'อัพโหลดรูปใบขับขี่ของคุณ',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 13,
                        color: orange1,
                        fontWeight: FontWeight.bold),
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
                  child: Text(
                    'อัพโหลดรูปภาษีรถยนต์ของคุณ',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 13,
                        color: orange1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // Align(
              //   alignment: Alignment.topLeft,

              // ),
            ],
          ),
          // GestureDetector(
          //   onTap: _showSelectImageDialog3,
          //   child: Container(
          //       height: 200,
          //       width: 200,
          //       color: Colors.grey[200],
          //       child: _image2 == null
          //           ? Icon(
          //               Icons.add_a_photo,
          //               color: Colors.white70,
          //               size: 70,
          //             )
          //           : Image(
          //               image: FileImage(_image2),
          //               fit: BoxFit.cover,
          //             )),
          // ),

          // SizedBox(height: 20,),
          // TextField(
          //   controller: _captionController,
          //   style: TextStyle(fontSize: 18),
          //   decoration: InputDecoration(
          //     labelText: 'อะไรสักอย่างในอนาคต'
          //   ),
          //   onChanged: (input) => _caption = input,
          // ),
        ],
      ),
      // persistentFooterButtons: <Widget>[
      //   SizedBox(
      //       width: 200, // match_parent
      //       child: RaisedButton(

      //       ),
      //       ),

      // )
      // FlatButton(

      //   onPressed: () => Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (_) => ShareForm(),
      //     ),
      //   ),

      //   color: Color(0xff5A45A5),
      //   child: Text(
      //     'สมัครคนขับ',
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
      // ],
    );
  }
}
