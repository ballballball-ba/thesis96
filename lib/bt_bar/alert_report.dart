import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mythesis96/firebase/database_up.dart';
import 'package:mythesis96/m/report.dart';
import 'package:mythesis96/m/share_posts.dart';
import 'package:mythesis96/m/user_data.dart';
import 'package:mythesis96/m/userlocation.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Alertreport extends StatefulWidget {
  Alertreport({Key key}) : super(key: key);

  @override
  _AlertreportState createState() => _AlertreportState();
}

class _AlertreportState extends State<Alertreport> {
  final Color purple1 = Color(0xff5A45A5);
  final Color purple2 = Color(0xff2A1D59);
  final Color orange1 = Color(0xffF2551D);
  String _dropDownValue;

  final _formkey = GlobalKey<FormState>();
  TextEditingController _textController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();
  String _topic = '';
  String _text = '';
  String _date = '';
  String _time = '';
  String _bank = '';
  String _location = '';
  //  @override
  // Widget build2(BuildContext context) {
  //   var userlocation = Provider.of<UserLocation>(context);
  //   return Center(
  //     child: Container(
  //       child: Text('==== ${userlocation.latitude},==== ${userlocation.longtitude}'),
  //     ),
  //   );
  // }

  _submit() async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      Flushbar(
        message: 'แจ้งปัญหา/แจ้งเหตุ เรียบร้อย',
        icon: Icon(
          Icons.info,
          size: 28.0,
          color: Colors.green,
        ),
        duration: Duration(seconds: 4),
        //leftBarIndicatorColor: Colors.blue[300],
        margin: EdgeInsets.all(8),
        borderRadius: 10,
      )..show(context);

      String readTimestamp(int timestamp) {
        var now = new DateTime.now();
        var format = new DateFormat('HH:mm a');
        var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
        var diff = now.difference(date);
        var time = '';

        if (diff.inSeconds <= 0 ||
            diff.inSeconds > 0 && diff.inMinutes == 0 ||
            diff.inMinutes > 0 && diff.inHours == 0 ||
            diff.inHours > 0 && diff.inDays == 0) {
          time = format.format(date);
        } else if (diff.inDays > 0 && diff.inDays < 7) {
          if (diff.inDays == 1) {
            time = diff.inDays.toString() + ' วันที่แล้ว';
          } else {
            time = diff.inDays.toString() + ' วันที่แล้ว';
          }
        } else {
          if (diff.inDays == 7) {
            time = (diff.inDays / 7).floor().toString() + ' สัปดาห์ที่แล้ว';
          } else {
            time = (diff.inDays / 7).floor().toString() + ' สัปดาห์ที่แล้ว';
          }
        }

        return time;
      }

      var now = new DateTime.now();
      Report car = Report(
        topic: _topic,
        text: _text,
        date: _date,
        time: _time,
        location1: Provider.of<UserLocation>(context).latitude.toString(),
        location2: Provider.of<UserLocation>(context).longtitude.toString(),

        //  timestamp: DateTime.now().toString(),
        timestamp: DateFormat("dd-MM-yyyy hh:mm:ss").format(now),
        authorId: Provider.of<Userdata>(context).currentUserID,
      );

      DatabaseSer.createReport(car);
      // DatabaseSer.createCar(car);

      // รีเซทข้อมูลให้ว่างเหมือนเดิม
      _textController.clear();

      setState(() {
        _topic = '';
        _text = '';
        _date = '';
        _time = '';
      });
    } else {
      Flushbar(
        message: 'ไม่สามารถ แจ้งปัญหา/แจ้งเหตุได้',
        icon: Icon(
          Icons.info,
          size: 28.0,
          color: Color(0xffF2551D),
        ),
        duration: Duration(seconds: 4),
        //leftBarIndicatorColor: Colors.blue[300],
        margin: EdgeInsets.all(8),
        borderRadius: 10,
      )..show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: purple2),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("แจ้งปัญหา/แจ้งเหตุ",
            style: TextStyle(
              fontFamily: 'Kanit',
              fontWeight: FontWeight.w600,
              color: purple2,
            )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              Container(
                margin:
                    EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 20),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 2,
                      offset: Offset(
                        1.0, // horizontal, move right 10
                        1.0, // vertical, move down 10
                      ),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(
                              2.0, // horizontal, move right 10
                              2.0, // vertical, move down 10
                            ),
                          ),
                        ],
                      ),
                      child: Container(
                        margin: EdgeInsets.only(left: 15, right: 15),
                        child: DropdownButton(
                          underline: SizedBox(),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(color: purple2),
                          items: [
                            'แจ้งเหตุฉุกเฉิน - ตำรวจ',
                            'แจ้งเหตุฉุกเฉิน - พยาบาล',
                            'แจ้งเหตุฉุกเฉิน - อื่นๆ',
                            'แจ้งปัญหาการใช้งาน',
                            'ติดต่อทีมงาน'
                          ].map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                              () {
                                _dropDownValue = val;
                                if (val.isEmpty) {
                                  _topic = 'แจ้งเหตุฉุกเฉิน - ตำรวจ';
                                } else {
                                  _topic = val;
                                }
                              },
                            );
                          },
                          hint: _dropDownValue == null
                              ? Text(
                                  'แจ้งเหตุฉุกเฉิน - ตำรวจ',
                                )
                              : Text(
                                  _dropDownValue,
                                  style: TextStyle(color: purple2),
                                ),
                        ),
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(left: 15, right: 15),
                    //   child: DropdownButton(
                    //     underline: SizedBox(),
                    //     isExpanded: true,
                    //     iconSize: 30.0,
                    //     style: TextStyle(color: purple2),
                    //     items: [
                    //       'กรุงไทย - KTB',
                    //       'ไทยพาณิชย์ - SCB',
                    //       'กสิกรไทย - KBANK',
                    //       'กรุงเทพ - BBL',
                    //       'กรุงศรีอยุธยา - BAY',
                    //       'ออมสิน - GSB',
                    //       'ทหารไทย - TMB',
                    //       'ซีไอเอ็มบี - CIMBT',
                    //       'ธนชาต - TBANK',
                    //       'ซิตี้แบงค์ - CITI',
                    //       'เกียรตินาคิน - KK',
                    //       'สแตนดาร์ดฯ - SCBT',
                    //       'ยูโอบี - UOBT',
                    //       'ทิสโก้ - TISCO',
                    //       'แลนด์ แอนด์ เฮ้าส์ - LHBANK',
                    //       'ธ.ก.ส. - BAAC',
                    //       'ธนาคารสงเคราะห์ - GHB',
                    //       'เอชเอสบีซี - HSBC',
                    //       'ไอซีบีซี (ไทย) - ICBCT',
                    //       'อิสลาม - ISBT',
                    //       'มิซูโอ - MIZUHO',
                    //       'ซูมิโตโม มิตซุย - SMBC',
                    //       'ไทยเครดิต - TCR',
                    //     ].map(
                    //       (val) {
                    //         return DropdownMenuItem<String>(
                    //           value: val,
                    //           child: Text(val),
                    //         );
                    //       },
                    //     ).toList(),
                    //     onChanged: (val) {
                    //       _dropDownValue = val;
                    //       print(_dropDownValue);
                    //       setState(
                    //         () {
                    //           _dropDownValue = val;
                    //           if (val.isEmpty) {
                    //             _bank = 'กรุงไทย - KTB';
                    //           } else {
                    //             _bank = val;
                    //           }
                    //         },
                    //       );
                    //     },
                    //     hint: _dropDownValue == null
                    //         ? Text(
                    //             '1',
                    //           )
                    //         : Text(
                    //             _dropDownValue,
                    //             style: TextStyle(color: purple2),
                    //           ),
                    //   ),
                    // ),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(
                                2.0, // horizontal, move right 10
                                2.0, // vertical, move down 10
                              ),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 10, bottom: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: _textController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.textsms, color: orange1),
                          hintText: 'ข้อความ',
                          hintStyle: TextStyle(
                            color: orange1, fontFamily: 'Kanit',
                            // fontWeight: FontWeight.w600,
                          ),
                        ),
                        // validator: (input) =>
                        //     input.trim().isEmpty ? 'กรุณาเลือกจุดเริ่มต้น' : null,
                        onChanged: (input) => _text = input,

                        // onSaved: (input) => _email = input,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 40),
                      constraints:
                          BoxConstraints.expand(height: 55, width: 340),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xff5A45A5)),
                        child: FlatButton(
                          onPressed: _submit,

                          // onPressed: _submit,
                          child: Text('แจ้งปัญหา/แจ้งเหตุ',
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
            ],
          ),
        ),
      ),
    );
  }

  todayDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedTime = DateFormat('kk:mm:a').format(now);
    String formattedDate = formatter.format(now);
    print(formattedTime);
    print(formattedDate);
    setState(() {
      //  this._date = formattedDate;
      // this._time = formattedTime;
    });
  }
  // @override

  // }
}
