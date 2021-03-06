import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mythesis96/bt_bar/homemain.dart';
import 'package:intl/intl.dart';
import 'package:mythesis96/bt_bar/notifier_share.dart';
import 'package:mythesis96/bt_bar/payment.dart';
import 'package:mythesis96/firebase/constance.dart';
import 'package:mythesis96/firebase/database_up.dart';
import 'package:mythesis96/m/share_posts.dart';
import 'package:mythesis96/m/user_data.dart';
import 'package:mythesis96/m/user_m.dart';
import 'package:provider/provider.dart';

class DetailShare extends StatefulWidget {
  final Share concertname;
  final String userId;
  // DetailShare({Key key}) : super(key: key);
  DetailShare({this.concertname, this.userId});
  @override
  _DetailShareState createState() => _DetailShareState();
}

class _DetailShareState extends State<DetailShare> {
  final Color purple1 = Color(0xff5A45A5);
  final Color purple2 = Color(0xff2A1D59);
  final Color purple3 = Color(0xffBDAEF2);
  final Color orage1 = Color(0xffF2551D);
  final Color purple4 = Color(0xffA99CD9);

  TextEditingController _maleController = TextEditingController();
  TextEditingController _femaleController = TextEditingController();
//driver
  String _dropDownValue = '0';
  String _dropDownValue2 = '0';
  String _dropDownValue3 = '0';
  String _dropDownValue4 = '0';
  String _dropDownValue5;

  @override
  Widget build(BuildContext context) {
    ShareNotifier shareNotifier =
        Provider.of<ShareNotifier>(context, listen: false);
    String _concertname = shareNotifier.currentShare.concertname;
    String _startplace = shareNotifier.currentShare.startplace;
    String _endplace = shareNotifier.currentShare.endplace;
    String _price = shareNotifier.currentShare.price;
    String _seat = shareNotifier.currentShare.seat;
    String _seatyou = shareNotifier.currentShare.seatyou;
    String _seatyou2 = shareNotifier.currentShare.seatyou2;
    String _date = shareNotifier.currentShare.date;
    String _time = shareNotifier.currentShare.time;
    String _details = shareNotifier.currentShare.details;
    String _picpro = shareNotifier.currentShare.picpro;

    String _malereq = '0';
    String _femalereq = '0';

    ///car
    String _brandcar = shareNotifier.currentShare.brandcar;
    // String _gencar = shareNotifier.currentShare.gencar;
    String _color = shareNotifier.currentShare.color;
    String _licensecar = shareNotifier.currentShare.licensecar;
    String _authorshare = shareNotifier.currentShare.authorId;

    final _formkey = GlobalKey<FormState>();

    check() {
      if (shareNotifier.currentShare.gender == 'ชาย') {
        return Form(
          key: _formkey,
          child: Row(
            children: <Widget>[
              Container(
                height: 50,
                width: 90,
                decoration: BoxDecoration(
                    color: purple4, borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(top: 10, left: 15, bottom: 20),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(2),
                  ],
                  // controller: _seatyouController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon:
                        Icon(FontAwesomeIcons.male, color: Colors.white),
                    hintText: 'ช',
                    hintStyle: TextStyle(
                      color: Colors.white70,
                      fontFamily: 'Kanit',
                      // fontWeight: FontWeight.w600,
                    ),
                  ),
                  validator: (input) =>
                      input.trim().isEmpty ? 'กรุณาระบุที่นั่ง' : null,
                  // onSaved: (input) => _password = input,
                  // obscureText: true,
                  onChanged: (input) => _malereq = input,
                ),
              ),
            ],
          ),
        );
      } else if (shareNotifier.currentShare.gender == 'หญิง') {
        return Form(
          key: _formkey,
          child: Row(
            children: <Widget>[
              Container(
                height: 50,
                width: 90,
                decoration: BoxDecoration(
                    color: purple4, borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(top: 10, left: 15, bottom: 20),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(2),
                  ],
                  //   controller: _seatyou2Controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon:
                        Icon(FontAwesomeIcons.female, color: Colors.white),
                    hintText: 'ญ',
                    hintStyle: TextStyle(
                      color: Colors.white70,
                      fontFamily: 'Kanit',
                      // fontWeight: FontWeight.w600,
                    ),
                  ),
                  validator: (input) =>
                      input.trim().isEmpty ? 'กรุณาระบุที่นั่ง' : null,
                  // onSaved: (input) => _password = input,
                  // obscureText: true,
                  onChanged: (input) => _femalereq = input,
                ),
              ),
              Column(
                children: <Widget>[
                  Text(
                    'กรุณาระบุจำนวน',
                    style: TextStyle(
                        color: Colors.white70,
                        fontFamily: 'Kanit',
                        fontSize: 13),
                  ),
                  Text(
                    '   ที่ต้องการขอร่วมเดินทาง',
                    style: TextStyle(
                        color: Colors.white70,
                        fontFamily: 'Kanit',
                        fontSize: 13),
                  )
                ],
              ),
            ],
          ),
        );
      } else {
        return Form(
          key: _formkey,
          child: Row(
            children: <Widget>[
              Container(
                height: 50,
                width: 90,
                decoration: BoxDecoration(
                    color: purple4, borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(top: 10, left: 15, bottom: 20),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(2),
                  ],
                  // controller: _seatyouController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon:
                        Icon(FontAwesomeIcons.male, color: Colors.white),
                    hintText: 'ช',
                    hintStyle: TextStyle(
                      color: Colors.white70,
                      fontFamily: 'Kanit',
                      // fontWeight: FontWeight.w600,
                    ),
                  ),
                  validator: (input) =>
                      input.trim().isEmpty ? 'กรุณาระบุที่นั่ง' : null,
                  // onSaved: (input) => _password = input,
                  // obscureText: true,
                  onChanged: (input) => _malereq = input,
                ),
              ),
              Container(
                height: 50,
                width: 90,
                decoration: BoxDecoration(
                    color: purple4, borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(top: 10, left: 15, bottom: 20),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(2),
                  ],
                  //   controller: _seatyou2Controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon:
                        Icon(FontAwesomeIcons.female, color: Colors.white),
                    hintText: 'ญ',
                    hintStyle: TextStyle(
                      color: Colors.white70,
                      fontFamily: 'Kanit',
                      // fontWeight: FontWeight.w600,
                    ),
                  ),
                  validator: (input) =>
                      input.trim().isEmpty ? 'กรุณาระบุที่นั่ง' : null,
                  // onSaved: (input) => _password = input,
                  // obscureText: true,
                  onChanged: (input) => _femalereq = input,
                ),
              ),
              Column(
                children: <Widget>[
                  Text(
                    'กรุณาระบุจำนวน',
                    style: TextStyle(
                        color: Colors.white70,
                        fontFamily: 'Kanit',
                        fontSize: 13),
                  ),
                  Text(
                    '   ที่ต้องการขอร่วมเดินทาง',
                    style: TextStyle(
                        color: Colors.white70,
                        fontFamily: 'Kanit',
                        fontSize: 13),
                  )
                ],
              ),
            ],
          ),
        );
      }
    }

//  final databaseReference = Firestore.instance;
//     databaseReference
//         .collection("Users")
//         .getDocuments()
//         .then((QuerySnapshot snapshot) {
//       snapshot.documents.forEach((f) => print('${f.data['NameCon']}}'));
//       //snapshot.documents
//       //     for (var index = 0; index < da.length; ++index) {
//       // final value = values[index];
//       // }
//     });
    final snapShot =
        Firestore.instance.collection('Users').document().snapshots();
    // if (snapShot.) {
// Provider.of<User>(context).gender
    // } else {
    // }
    var allreq = int.parse(_malereq) + int.parse(_femalereq);
    _presubmit() async {
      if (_formkey.currentState.validate()
          // &&  allreq > 0 && allreq <= 8
          &&
          int.parse(_malereq) <= int.parse(_seat) &&
          int.parse(_femalereq) <= int.parse(_seat)) {
        _formkey.currentState.save();
        // _malereq != _seatyou && _femalereq != _seatyou2
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
                    "รายละเอียด",
                    style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 18,
                        color: purple2,
                        fontWeight: FontWeight.w600),
                  ),
                  content: Column(
                    children: <Widget>[
                      Text(
                        "ยืนยันการส่งคำขอ",
                        style: TextStyle(fontFamily: 'Kanit', color: orage1),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    // FlatButton(
                    //   child: const Text('ยกเลิก',
                    //       style: TextStyle(
                    //           fontFamily: 'Kanit', color: Colors.black87)),
                    //   onPressed: () {
                    //     Navigator.of(context).pop();
                    //   },
                    // ),
                    // usually buttons at the bottom of the dialog
                    FlatButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('ยกเลิก',
                            style: TextStyle(
                                fontFamily: 'Kanit', color: purple2))),
                    new FlatButton(
                        child: new Text(
                          "ตกลง",
                          style: TextStyle(fontFamily: 'Kanit', color: purple2),
                        ),
                        onPressed: () {
                          if (int.parse(_femalereq) > 0 ||
                              int.parse(_malereq) > 0) {
                            _formkey.currentState.save();
                            //Navigator.pushReplacement(context, MaterialPageRoute( builder: (_) => Home(), ));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Home(),
                              ),
                            );
                            _showDialog();

                            var now = new DateTime.now();
                            Sharereq sharereq = Sharereq(
                              concertname: _concertname,
                              startplace: _startplace,
                              endplace: _endplace,
                              price: _price,
                              seat: _seat,
                              seatyou: _seatyou,
                              seatyou2: _seatyou2,
                              date: _date,
                              time: _time,
                              details: _details,
                              picpro: _picpro,

                              reqseat1: _malereq,
                              reqseat2: _femalereq,
                              //********************** */
                              brandcar: _brandcar,
                              //gencar: _gencar,
                              color: _color,
                              licensecar: _licensecar,

                              authorshare: _authorshare,
                              timestamp:
                                  DateFormat("dd-MM-yyyy hh:mm:ss").format(now),
                              authorId:
                                  Provider.of<Userdata>(context).currentUserID,
                            );
                            DatabaseSer.createSharereq(sharereq);
                            // DatabaseSer.createCar(car);

                            // รีเซทข้อมูลให้ว่างเหมือนเดิม
                            _maleController.clear();
                            _femaleController.clear();
                            setState(() {
                              _malereq = '';
                              _femalereq = '';
                            });
                          } else {
                            Flushbar(
                              message:
                                  'ไม่สามารถ ขอร่วมเดินทางได้ ลองอีกครั้ง! ตรวจสอบจำนวน',
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
                        }),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        //Navigator.pushReplacement(context, MaterialPageRoute( builder: (_) => Home(), ));
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) => Home(),
        //   ),
        // );
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
                    "แจ้งเตือน",
                    style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 18,
                        color: purple2,
                        fontWeight: FontWeight.w600),
                  ),
                  content: Column(
                    children: <Widget>[
                      Text(
                        "จำนวนระบุคำร้องขอการแชร์ของคุณ",
                        style: TextStyle(
                            fontFamily: 'Kanit', color: orage1, fontSize: 14),
                      ),
                      Text(
                        "ไม่ถูกต้องกับของผู้แชร์",
                        style: TextStyle(
                            fontFamily: 'Kanit', color: orage1, fontSize: 14),
                      ),

                      // Icon(FontAwesomeIcons.spinner, size: 40, color: orage1)
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: const Text('ยกเลิก',
                          style: TextStyle(
                              fontFamily: 'Kanit', color: Colors.black87)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
      // else {
    }

    return Scaffold(
      backgroundColor: purple3,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: purple2),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("รายละเอียดการแชร์",
            style: TextStyle(
              fontFamily: 'Kanit',
              fontWeight: FontWeight.w600,
              color: purple2,
            )),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20.0),

        // width: 500,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(50.0),
            topRight: const Radius.circular(50.0),
            // bottomLeft: const Radius.circular(10.0),
            // bottomRight: const Radius.circular(10.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 4,
              offset: Offset(
                5.0, // horizontal, move right 10
                4.0, // vertical, move down 10
              ),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Container(
            height: 850,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(25),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "รายละเอียดการแชร์",
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: purple2,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Divider(
                        color: Colors.black38,
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        Icons.music_note,
                                        color: orange1,
                                        size: 20,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                      ),
                                      Text(
                                        'ชื่อคอนเสิร์ต',
                                        style: TextStyle(
                                          fontFamily: 'Kanit',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: purple2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: 30),
                                      ),
                                      Text(
                                          shareNotifier
                                              .currentShare.concertname,
                                          style: TextStyle(
                                            fontFamily: 'Kanit',
                                            color: purple1,
                                          )),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        Icons.music_note,
                                        color: orange1,
                                        size: 20,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'จุดเริ่มต้น',
                                            style: TextStyle(
                                              fontFamily: 'Kanit',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: purple2,
                                            ),
                                          ),
                                          Text(
                                              shareNotifier
                                                  .currentShare.startplace,
                                              style: TextStyle(
                                                fontFamily: 'Kanit',
                                                color: purple1,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        Icons.music_note,
                                        color: orange1,
                                        size: 20,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'ปลายทาง',
                                            style: TextStyle(
                                              fontFamily: 'Kanit',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: purple2,
                                            ),
                                          ),
                                          Text(
                                              shareNotifier
                                                  .currentShare.endplace,
                                              style: TextStyle(
                                                fontFamily: 'Kanit',
                                                color: purple1,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        Icons.date_range,
                                        color: orange1,
                                        size: 20,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'วันและเวลา',
                                            style: TextStyle(
                                              fontFamily: 'Kanit',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: purple2,
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                  shareNotifier
                                                      .currentShare.date,
                                                  style: TextStyle(
                                                    fontFamily: 'Kanit',
                                                    color: purple1,
                                                  )),
                                              Text(' - '),
                                              Text(
                                                  shareNotifier
                                                      .currentShare.time,
                                                  style: TextStyle(
                                                    fontFamily: 'Kanit',
                                                    color: purple1,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        Icons.attach_money,
                                        color: orange1,
                                        size: 20,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'ราคาต่อที่นั่ง',
                                            style: TextStyle(
                                              fontFamily: 'Kanit',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: purple2,
                                            ),
                                          ),
                                          Text(shareNotifier.currentShare.price,
                                              style: TextStyle(
                                                fontFamily: 'Kanit',
                                                color: purple1,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.venusMars,
                                        color: orange1,
                                        size: 20,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'เพศชาย',
                                            style: TextStyle(
                                              fontFamily: 'Kanit',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: purple2,
                                            ),
                                          ),
                                          Text(
                                              shareNotifier
                                                  .currentShare.seatyou,
                                              style: TextStyle(
                                                fontFamily: 'Kanit',
                                                color: purple1,
                                              )),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 30),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'เพศหญิง',
                                            style: TextStyle(
                                              fontFamily: 'Kanit',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: purple2,
                                            ),
                                          ),
                                          Text(
                                              shareNotifier
                                                  .currentShare.seatyou2,
                                              style: TextStyle(
                                                fontFamily: 'Kanit',
                                                color: purple1,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        Icons.airline_seat_legroom_normal,
                                        color: orange1,
                                        size: 20,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'ที่นั่งว่าง',
                                            style: TextStyle(
                                              fontFamily: 'Kanit',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: purple2,
                                            ),
                                          ),
                                          Text(
                                              shareNotifier.currentShare.seat
                                                  .toString(),
                                              style: TextStyle(
                                                fontFamily: 'Kanit',
                                                color: purple1,
                                              )),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 30),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'เพศที่ต้องการ',
                                            style: TextStyle(
                                              fontFamily: 'Kanit',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: purple2,
                                            ),
                                          ),
                                          Text(
                                              shareNotifier.currentShare.gender
                                                  .toString(),
                                              style: TextStyle(
                                                fontFamily: 'Kanit',
                                                color: purple1,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.venusMars,
                                        color: orange1,
                                        size: 20,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'รถ',
                                            style: TextStyle(
                                              fontFamily: 'Kanit',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: purple2,
                                            ),
                                          ),
                                          Text(
                                              shareNotifier
                                                  .currentShare.brandcar,
                                              style: TextStyle(
                                                fontFamily: 'Kanit',
                                                color: purple1,
                                              )),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 50),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'สีรถ',
                                              style: TextStyle(
                                                fontFamily: 'Kanit',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: purple2,
                                              ),
                                            ),
                                            Text(
                                                shareNotifier
                                                    .currentShare.color,
                                                style: TextStyle(
                                                  fontFamily: 'Kanit',
                                                  color: purple1,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.venusMars,
                                        color: orange1,
                                        size: 20,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'เลขทะเบียน',
                                            style: TextStyle(
                                              fontFamily: 'Kanit',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: purple2,
                                            ),
                                          ),
                                          license()
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.fileAlt,
                                        color: orange1,
                                        size: 20,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'รายละเอียด',
                                            style: TextStyle(
                                              fontFamily: 'Kanit',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: purple2,
                                            ),
                                          ),
                                          Text(
                                              shareNotifier
                                                  .currentShare.details,
                                              style: TextStyle(
                                                fontFamily: 'Kanit',
                                                color: purple1,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.only(left: 15)),
                                      Text('ระบุจำนวนที่ต้องการขอร่วมเดินทาง',
                                          style: TextStyle(
                                              fontFamily: 'Kanit',
                                              color: purple2,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),

                                  check(),

                                  Divider()
                                  // Row(
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: <Widget>[
                                  //     Padding(
                                  //       padding: EdgeInsets.only(left: 30),
                                  //     ),
                                  //     Text(shareNotifier.currentShare.startplace),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // margin: EdgeInsets.only(bottom: 40),
                  constraints: BoxConstraints.expand(height: 55, width: 340),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xff5A45A5)),
                    child: FlatButton(
                      // onPressed: () {},

                      onPressed: _presubmit,
                      child: Text('ขอร่วมเดินทาง',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Kanit',
                            fontSize: 22,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  license() {
    ShareNotifier shareNotifier =
        Provider.of<ShareNotifier>(context, listen: false);
    if (shareNotifier.currentShare.licensecar != null) {
      return Row(
        children: <Widget>[
          Text('xxxxx',
              style: TextStyle(
                fontFamily: 'Kanit',
                color: purple1,
              )),
          Padding(padding: EdgeInsets.only(left: 10)),
          Text('*เลขทะเบียนจะแสดงหลังจากการตอบรับ',
              style: TextStyle(
                  fontFamily: 'Kanit', color: Colors.black38, fontSize: 12)),
        ],
      );
    } else {
      Text('-');
    }
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
                "ส่งคำร้องขอเดินทาง เรียบร้อย",
                style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 18,
                    color: purple2,
                    fontWeight: FontWeight.w600),
              ),
              content: Column(
                children: <Widget>[
                  Text(
                    "ตรวจสอบคำร้องได้ที่หน้า 'การแชร์ของฉัน'",
                    style: TextStyle(fontFamily: 'Kanit', color: orage1),
                  ),
                  Icon(FontAwesomeIcons.spinner, size: 40, color: orage1)
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
//
