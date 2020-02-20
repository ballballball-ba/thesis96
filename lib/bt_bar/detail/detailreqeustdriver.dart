import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mythesis96/bt_bar/homemain.dart';
import 'package:mythesis96/bt_bar/notiac_sc.dart';
import 'package:mythesis96/bt_bar/notifier_share%20request.dart';
import 'package:mythesis96/bt_bar/notifier_share.dart';
import 'package:mythesis96/bt_bar/payment.dart';
import 'package:mythesis96/firebase/database_up.dart';
import 'package:mythesis96/m/share_posts.dart';
import 'package:mythesis96/m/user_data.dart';
import 'package:provider/provider.dart';

class DetailSharedriver extends StatefulWidget {
  final Share concertname;
  // DetailShare({Key key}) : super(key: key);
  DetailSharedriver({this.concertname});
  @override
  _DetailSharedriverState createState() => _DetailSharedriverState();
}

class _DetailSharedriverState extends State<DetailSharedriver> {
  final Color purple1 = Color(0xff5A45A5);
  final Color purple2 = Color(0xff2A1D59);
  final Color purple3 = Color(0xffBDAEF2);
  final Color orage1 = Color(0xffF2551D);
  final Color purple4 = Color(0xffA99CD9);

  TextEditingController _maleController = TextEditingController();
  TextEditingController _femaleController = TextEditingController();
//driver

  @override
  Widget build(BuildContext context) {
    // ShareNotifierrequest1 shareNotifier =
    //     Provider.of<ShareNotifierrequest1>(context, listen: false);
    ShareNotifierrequest shareNotifier =
        Provider.of<ShareNotifierrequest>(context, listen: false);

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
    String _malereq = shareNotifier.currentShare.reqseat1;
    String _femalereq = shareNotifier.currentShare.reqseat2;
    String _brandcar = shareNotifier.currentShare.brandcar;
    // String _gencar = shareNotifier.currentShare.gencar;
    String _color = shareNotifier.currentShare.color;
    String _licensecar = shareNotifier.currentShare.licensecar;
    final _formkey = GlobalKey<FormState>();
    _submit() async {
      if (1 + 1 == 2) {
        //Navigator.pushReplacement(context, MaterialPageRoute( builder: (_) => Home(), ));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Home(),
          ),
        );
        _showDialog();
        deleteData();
        var now = new DateTime.now();
        Shareconfirm shareconfirm = Shareconfirm(
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

          timestamp: DateFormat("dd-MM-yyyy hh:mm:ss").format(now),
          authorId: Provider.of<Userdata>(context).currentUserID,
        );
        DatabaseSer.createShareconfirm(shareconfirm);
        // DatabaseSer.createCar(car);

        // รีเซทข้อมูลให้ว่างเหมือนเดิม

      } else {
        Flushbar(
          message: 'ไม่สามารถ ขอร่วมเดินทางได้ ลองอีกครั้ง!',
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

    return Scaffold(
      backgroundColor: purple3,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: purple2),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("รายละเอียดการแชร์ (รอการตอบรับ)",
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
            height: 870,
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
                          "รายละเอียดการแชร์ (รอการตอบรับ)",
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
                                          Text(shareNotifier.currentShare.seat,
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
                                        FontAwesomeIcons.car,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.male,
                                        color: orange1,
                                        size: 20,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'คำขอชาย',
                                                style: TextStyle(
                                                  fontFamily: 'Kanit',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  color: purple2,
                                                ),
                                              ),
                                              Text(
                                                  shareNotifier
                                                      .currentShare.reqseat1,
                                                  style: TextStyle(
                                                      fontFamily: 'Kanit',
                                                      color: orage1,
                                                      fontSize: 20)),
                                            ],
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 20)),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'คำขอหญิง',
                                                style: TextStyle(
                                                  fontFamily: 'Kanit',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  color: purple2,
                                                ),
                                              ),
                                              Text(
                                                  shareNotifier
                                                      .currentShare.reqseat2,
                                                  style: TextStyle(
                                                      fontFamily: 'Kanit',
                                                      color: orage1,
                                                      fontSize: 20)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  Divider(),

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
                        borderRadius: BorderRadius.circular(30), color: orage1),
                    child: FlatButton(
                      onPressed: _submit,
                      //  () {
                      //    print('ยืนยัน');
                      //  },

                      // onPressed: _submit,
                      child: Text('ยืนยันคำขอ',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Kanit',
                            fontSize: 22,
                          )),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  constraints: BoxConstraints.expand(height: 55, width: 340),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.black38),
                    child: FlatButton(
                      onPressed: () {
                        deleteData();
                        print('เรียบร้อย');
                      },

                      // onPressed: _submit,
                      child: Text('ปฏิเสธคำขอ',
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

  final databaseReference = Firestore.instance;
  void deleteData() {
    databaseReference
        .collection('ShareRequest')
        .getDocuments()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
        ds.reference.delete();
      }
    });
    // try {
    //   databaseReference.collection('ShareRequest').document('D55JNu4VVBpxsuKcwP30').delete();
    // } catch (e) {
    //   print(e.toString());
    // }
  }

  license() {
    ShareNotifierrequest shareNotifier =
        Provider.of<ShareNotifierrequest>(context, listen: false);
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
                "ยืนยันการร่วมเดินทาง",
                style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 18,
                    color: purple2,
                    fontWeight: FontWeight.w600),
              ),
              content: Column(
                children: <Widget>[
                  Text(
                    "ตรวจสอบรายละเอียดได้ที่ 'การแชร์ของฉัน'",
                    style: TextStyle(fontFamily: 'Kanit', color: orage1),
                  ),
                  Icon(FontAwesomeIcons.spinner, size: 40, color: orage1)
                ],
              ),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text(
                    "ยืนยัน",
                    style: TextStyle(fontFamily: 'Kanit', color: purple2),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                new FlatButton(
                  child: new Text(
                    "ยกเลิก",
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

  DateFormat(String s) {}
}
//
