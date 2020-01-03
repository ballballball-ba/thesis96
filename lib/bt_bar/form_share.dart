import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:mythesis96/constance.dart';
import 'package:mythesis96/firebase/auth_service.dart';
import 'package:mythesis96/firebase/database_up.dart';
import 'package:mythesis96/m/car_data.dart';
import 'package:mythesis96/m/share_posts.dart';
import 'package:mythesis96/m/user_data.dart';
import 'package:mythesis96/signup_driver.dart';
import 'package:provider/provider.dart';

class Shareform extends StatefulWidget {
  static final String id = 'Shareform_screen';

  @override
  _ShareformState createState() => _ShareformState();
}

class _ShareformState extends State<Shareform> {
  TextEditingController _concertnameController = TextEditingController();
  TextEditingController _startplaceController = TextEditingController();
  TextEditingController _endplaceController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _seatController = TextEditingController();
  TextEditingController _datetimeController = TextEditingController();
  //car
  TextEditingController _brandcarControlle = TextEditingController();
  TextEditingController _gencarControlle = TextEditingController();
  TextEditingController _colorControlle = TextEditingController();
  TextEditingController _licensecarControlle = TextEditingController();

  //driver
  String _concertname = '';
  String _startplace = '';
  String _endplace = '';
  String _price = '';
  String _seat = '';
  String _datetime = '';

  ///car
  String _brandcar = '';
  String _gencar = '';
  String _color = '';
  String _licensecar = '';

  bool _isloading = false;

  // final _formkey = GlobalKey<FormState>();
  // String _username, _email, _password;

  // _submit() {
  //   if (_formkey.currentState.validate()) {
  //     _formkey.currentState.save();
  //     // Logging in the user w/ Firebase
  //     AuthService.signUpUser(context, _username, _email, _password);
  //   }
  // }
  _submit() async {
    if (!_isloading &&
        _concertname.isNotEmpty &&
        _startplace.isNotEmpty &&
        _endplace.isNotEmpty &&
        _price != null &&
        _seat != null &&
        _datetime.isNotEmpty &&
        //car
        _brandcar.isNotEmpty &&
        _gencar.isNotEmpty &&
        _color.isNotEmpty &&
        _licensecar.isNotEmpty) {
      setState(() {
        _isloading = true;
      });

      // สร้างแชร

      Share sharepost = Share(
        concertname: _concertname,
        startplace: _startplace,
        endplace: _endplace,
        price: _price,
        seat: _seat,
        datetime: _datetime,
        timestamp: Timestamp.fromDate(DateTime.now()),
        authorId: Provider.of<Userdata>(context).currentUserID,
      );

      Cardata car = Cardata(
        brandcar: _brandcar,
        gencar: _gencar,
        color: _color,
        licensecar: _licensecar,
        timestamp: Timestamp.fromDate(DateTime.now()),
        authorId: Provider.of<Userdata>(context).currentUserID,
      );
      DatabaseSer.createShare(sharepost);
      DatabaseSer.createCar(car);

      // รีเซทข้อมูลให้ว่างเหมือนเดิม
      _concertnameController.clear();
      _startplaceController.clear();
      _endplaceController.clear();
      _priceController.clear();
      _seatController.clear();
      _datetimeController.clear();
      //car clear
      _brandcarControlle.clear();
      _gencarControlle.clear();
      _colorControlle.clear();
      _licensecarControlle.clear();

      setState(() {
        _concertname = '';
        _startplace = '';
        _endplace = '';
        _price = '';
        _seat = '';
        _datetime = '';
        /////////////
        _brandcar = '';
        _gencar = '';
        _color = '';
        _licensecar = '';

        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "สร้างการแชร์",
          style: TextStyle(color: Color(0xff5A45A5)),
          textAlign: TextAlign.center,
        ),
        // actions: <Widget>[
        //   FlatButton(
        //     onPressed: _submit,
        //     child: Text(
        //       "ยืนยัน",
        //       style: TextStyle(fontSize: 16, color: Color(0xffFF7240)),
        //     ),

        //   )
        // ],
      ),

      ///แก้ button float
      body: SingleChildScrollView(
        child: Container(
          //กำกับความสูง
          //   height: MediaQuery.of(context).size.height,
          ///แก้ button float
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _isloading
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 1.0),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.blue[200],
                        valueColor: AlwaysStoppedAnimation(Colors.blue),
                      ),
                    )
                  : SizedBox.shrink(),
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
                margin: EdgeInsets.only(
                    left: 32.0, right: 32.0, top: 40, bottom: 20),
                child: Form(
                    //  key: _formkey,
                    child: Column(mainAxisSize: MainAxisSize.min, children: <
                        Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10, bottom: 20),
                    child: TextFormField(
                      controller: _concertnameController,
                      decoration: InputDecoration(
                        labelText: 'เลือกคอนเสิร์ต',
                      ),
                      validator: (input) =>
                          input.isEmpty ? 'กรุณาเลือกคอนเสิร์ต' : null,
                      //save database
                      // onSaved: (input) => _username = input,
                      onChanged: (input) => _concertname = input,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10, bottom: 20),
                    child: TextFormField(
                      controller: _startplaceController,

                      decoration: InputDecoration(
                        labelText: 'จุดเริ่มต้น',
                      ),
                      validator: (input) =>
                          input.trim().isEmpty ? 'กรุณาเลือกจุดเริ่มต้น' : null,
                      onChanged: (input) => _startplace = input,

                      // onSaved: (input) => _email = input,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10, bottom: 20),
                    child: TextFormField(
                      controller: _endplaceController,
                      decoration: InputDecoration(labelText: 'ปลายทาง'),
                      validator: (input) =>
                          input.trim().isEmpty ? 'กรุณากำหนดปลายทาง' : null,
                      // onSaved: (input) => _password = input,
                      // obscureText: true,
                      onChanged: (input) => _endplace = input,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 15.0, right: 200.0, top: 10, bottom: 20),
                    child: TextFormField(
                      controller: _priceController,
                      decoration: InputDecoration(labelText: 'ราคา/จำนวน'),
                      validator: (input) =>
                          input.trim().isEmpty ? 'กรุณากำหนดราคา' : null,
                      // onSaved: (input) => _password = input,
                      // obscureText: true,
                      onChanged: (input) => _price = input,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10, bottom: 20),
                    child: TextFormField(
                      controller: _datetimeController,
                      decoration: InputDecoration(labelText: 'วันและเวลา'),
                      validator: (input) =>
                          input.trim().isEmpty ? 'กรุณากำหนดวันและเวลา' : null,
                      // onSaved: (input) => _password = input,
                      // obscureText: true,
                      onChanged: (input) => _datetime = input,
                    ),
                  ),
                  Divider(
                    color: Colors.black38,
                  ),
                  Container(
////////////////////////////////////////////////////////////////////////////
                    margin: EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10, bottom: 20),
                    child: TextFormField(
                      controller: _brandcarControlle,
                      decoration: InputDecoration(labelText: 'ยี่ห้อรถ'),
                      validator: (input) => input.trim().isEmpty
                          ? 'กรุณาระบุยี่ห้อรถ'
                          : null,
                      // onSaved: (input) => _password = input,
                      // obscureText: true,
                    onChanged: (input) => _brandcar = input,

                    ),
                  ),
                   Container(

                    margin: EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10, bottom: 20),
                    child: TextFormField(
                      controller: _gencarControlle,
                      decoration: InputDecoration(labelText: 'รุ่นรถ'),
                      validator: (input) => input.trim().isEmpty
                          ? 'กรุณาระบุรุ่นรถ'
                          : null,
                      // onSaved: (input) => _password = input,
                      // obscureText: true,
                      onChanged: (input) => _gencar = input,
                    ),
                  ),
                   Container(

                    margin: EdgeInsets.only(
                        left: 15.0, right: 200.0, top: 10, bottom: 20),
                    child: TextFormField(
                      controller: _colorControlle,
                      decoration: InputDecoration(labelText: 'สี'),
                      validator: (input) => input.trim().isEmpty
                          ? 'กรุณาระบุสี'
                          : null,
                      // onSaved: (input) => _password = input,
                      // obscureText: true,
                      onChanged: (input) => _color = input,
                    ),
                  ),
                   Container(

                    margin: EdgeInsets.only(
                        left: 15.0, right: 200.0, top: 10, bottom: 20),
                    child: TextFormField(
                      controller: _licensecarControlle,
                      decoration: InputDecoration(labelText: 'เลขทะเบียน',helperText: 'เราจะเก็บข้อมูลนี้ไว้เป็นความลับ',),
                      validator: (input) => input.trim().isEmpty
                          ? 'กรุณาระบุเลขทะเบียน'
                          : null,
                      // onSaved: (input) => _password = input,
                      // obscureText: true,
                      onChanged: (input) => _licensecar = input,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 15.0, right: 200.0, top: 10, bottom: 20),
                    child: TextFormField(
                      controller: _seatController,
                      decoration: InputDecoration(labelText: 'ที่นั่งว่าง'),
                      validator: (input) =>
                          input.trim().isEmpty ? 'กรุณาระบบที่นั่งว่าง' : null,
                      // onSaved: (input) => _password = input,
                      // obscureText: true,
                      onChanged: (input) => _seat = input,
                    ),
                  ),
                  //  Container(

                  //   margin: EdgeInsets.only(
                  //       left: 15.0, right: 15.0, top: 10, bottom: 20),
                  //   child: TextFormField(
                  //     decoration: InputDecoration(labelText: 'ช่วยบอกเราหน่อย คุณมากับใคร'),
                  //     validator: (input) => input.isEmpty
                  //         ? 'กรุณาบอกเราหน่อย'
                  //         : null,
                  //     // onSaved: (input) => _password = input,
                  //     // obscureText: true,
                  //   ),
                  // ),
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

                    // onPressed: _submit,
                    child: Text('ยืนยัน',
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
