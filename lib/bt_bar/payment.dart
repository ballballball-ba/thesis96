import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mythesis96/Api/api.dart';
import 'package:mythesis96/Api/apiuse.dart';
import 'package:mythesis96/bt_bar/detail/detailreqeustsuccess.dart';
import 'package:mythesis96/bt_bar/homemain.dart';
import 'package:mythesis96/bt_bar/notifier_share%20request.dart';
import 'package:mythesis96/firebase/constance.dart';
import 'package:mythesis96/firebase/database_up.dart';
import 'package:mythesis96/m/payment_data.dart';
import 'package:mythesis96/m/share_posts.dart';
import 'package:mythesis96/m/user_data.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as Http;
import 'dart:convert';
import 'package:intl/intl.dart' as intl;
//import 'package:intl/intl.dart';
import 'package:mythesis96/Api/apiuse.dart';

class Payment extends StatefulWidget {
  //Payment({Key key}) : super(key: key);
  final DocumentSnapshot post;

  final String userpay;
  const Payment({Key key, this.userpay, this.post}) : super(key: key);
  @override
  _PaymentState createState() => _PaymentState();
}

var maskFormatter1 = new MaskTextInputFormatter(
    mask: '#### #### #### ####', filter: {"#": RegExp(r'[0-9]')});
var maskFormatter2 =
    new MaskTextInputFormatter(mask: '##/##', filter: {"#": RegExp(r'[0-9]')});
var maskFormatter3 =
    new MaskTextInputFormatter(mask: '####', filter: {"#": RegExp(r'[0-9]')});
final Color purple1 = Color(0xff5A45A5);
final Color purple2 = Color(0xff2A1D59);
final Color orange1 = Color(0xffF2551D);
final Color orange2 = Color(0xffFF6D38);

final _formkey = GlobalKey<FormState>();

TextEditingController _cardnumController = TextEditingController();
TextEditingController _cardexpTimeController = TextEditingController();
TextEditingController _cardcvvTimeController = TextEditingController();
TextEditingController _cardnameTimeController = TextEditingController();

class _PaymentState extends State<Payment> {
  String _cardnum = '';
  String _cardexp = '';
  String _cardcvv = '';
  String _cardname = '';
  void onChangeValue1(String value1) {
    setState(() {
      _cardnum = '$value1';
    });
  }

  void onSubmitValue1(String value1) {
    setState(() {
      _cardnum = 'on Submitted: $value1';
    });
  }

  void onChangeValue2(String value2) {
    setState(() {
      _cardexp = '$value2';
    });
  }

  void onSubmitValue2(String value2) {
    setState(() {
      _cardexp = 'on Submitted: $value2';
    });
  }

  void onChangeValue3(String value3) {
    setState(() {
      _cardcvv = '$value3';
    });
  }

  void onSubmitValue3(String value3) {
    setState(() {
      _cardcvv = 'on Submitted: $value3';
    });
  }

  void onChangeValue4(String value4) {
    setState(() {
      _cardname = '$value4';
    });
  }

  void onSubmitValue4(String value4) {
    setState(() {
      _cardname = 'on Submitted: $value4';
    });
  }

  @override
  void initState() {
    ShareNotifierrequest2 shareNotifier3 =
        Provider.of<ShareNotifierrequest2>(context, listen: false);

    getShare3(shareNotifier3);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ShareNotifierrequest2 shareNotifier =
        Provider.of<ShareNotifierrequest2>(context, listen: false);
    ShareNotifierrequest2 shareNotifier3 =
        Provider.of<ShareNotifierrequest2>(context);

    String _concertname = widget.post.data['Concertname'];
    String _startplace = widget.post.data['StartPlace'];
    String _endplace = widget.post.data['Endplace'];
    String _price = widget.post.data['Price'];
    String _seat = widget.post.data['Seat'];
    String _seatyou = widget.post.data['Seatyou'];
    String _seatyou2 = widget.post.data['Seatyou2'];
    String _date = widget.post.data['Date'];
    String _time = widget.post.data['Time'];
    String _details = widget.post.data['details'];
    String _picpro = widget.post.data['picpro'];
    String _malereq = widget.post.data['Seatreqmale'];
    String _femalereq = widget.post.data['Seatreqfemale'];
    String _brandcar = widget.post.data['Brandcar'];
    String _gencar = widget.post.data['Gencar'];
    String _color = widget.post.data['Color'];
    String _licensecar = widget.post.data['licensecar'];
    String _authorshare = widget.post.data['authorshare'];
    var myInt = int.parse(widget.post.data['Price']);
    var myInt2 = int.parse(widget.post.data['Seatreqmale']);
    var myInt3 = int.parse(widget.post.data['Seatreqfemale']);
    var myInt4 = int.parse(widget.post.data['Seatyou']);
    var myInt5 = int.parse(widget.post.data['Seatyou2']);
    var seat = myInt2 + myInt3;
    var allint = myInt * (myInt2 + myInt3);
    var myresult1 = allint * 25 / 100;

    var allpeople = myInt2 + myInt3 + myInt4 + myInt5;
    var myresult = myInt - myresult1;
    // assert(myInt is int);
    // print(myInt);
    String _shareid = widget.post.documentID;
    String _money = myresult.toString();
    String _allpeople = allpeople.toString();
    //String _shareid = shareNotifier.currentShare.id;
    _submit() async {
      if (_formkey.currentState.validate()) {
        _formkey.currentState.save();
        var now = new DateTime.now();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return Home();
          // return Payment();
        }));
        _deleteData();
        // PaymentM payment = PaymentM(
        //   cardnum: _cardnum,
        //   cardexp: '',
        //   cardcvv: '',
        //   cardname: _cardname,
        //   allmoney: _money,
        //   shareid: _shareid,
        //   status: 'เสร็จสิ้นการแชร์',

        //   // endplace: _endplace,
        //   // price: _price,
        //   // seat: _seat,
        //   // date: _date,
        //   // time: _time,
        //   timestamp: intl.DateFormat("dd-MM-yyyy hh:mm").format(now),
        //   // DateTime.now().toIso8601String().toString(),
        //   authorId: Provider.of<Userdata>(context).currentUserID,
        // );
        Paymentcheck paymentcheck = Paymentcheck(
          cardnum: _cardnum,

          cardname: _cardname,
          allmoney: _money,
          shareid: _shareid,
          status: 'เสร็จสิ้นการแชร์',
          concert: _concertname,
          from: _startplace,
          to: _endplace,
          licensecar: _licensecar,
          allpeople: _allpeople,
// 'concert': paymentcheck.concert,
//       'from': paymentcheck.from,
//       'to': paymentcheck.to,
//       'licensecar': paymentcheck.licensecar,
//       'allpeople': paymentcheck.allpeople,
          timestamp: intl.DateFormat("dd-MM-yyyy hh:mm").format(now),
          // DateTime.now().toIso8601String().toString(),
          authorId: Provider.of<Userdata>(context).currentUserID,
        );

        DatabaseSer.createPaycheck(paymentcheck);
        // DatabaseSer.createCar(car);

        // รีเซทข้อมูลให้ว่างเหมือนเดิม
        _cardnumController.clear();
        _cardexpTimeController.clear();
        _cardcvvTimeController.clear();
        _cardnameTimeController.clear();

        setState(() {
          _cardnum = '';
          _cardexp = '';
          _cardcvv = '';
          _cardname = '';
        });
      }

      //  _formkey.currentState.validate();
      //  _formkey.currentState.save();
    }
    // _formkey.currentState.validate()) {
    //     _formkey.currentState.save();

    _paydilog() async {
      if (_formkey.currentState.validate()) {
        _formkey.currentState.save();
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
                    "ยืนยันข้อมูล",
                    style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 18,
                        color: purple2,
                        fontWeight: FontWeight.w600),
                  ),
                  content: Column(
                    children: <Widget>[
                      Text(
                        "ยืนยันข้อมูล",
                        style: TextStyle(fontFamily: 'Kanit', color: orange1),
                      ),
                      Icon(FontAwesomeIcons.spinner, size: 40, color: orange1)
                    ],
                  ),
                  actions: <Widget>[
                    // usually buttons at the bottom of the dialog
                    new FlatButton(
                      child: new Text(
                        "ยืนยัน",
                        style: TextStyle(fontFamily: 'Kanit', color: purple2),
                      ),
                      onPressed: _submit,
                      //           onPressed: () =>  Navigator.of(context)
                      //     .push(MaterialPageRoute(builder: (BuildContext context) {

                      //   return Home();
                      //   // return Payment();
                      // }
                      // )
                      // ),
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
      } else {}
    }

    final bottom = MediaQuery.of(context).viewInsets.bottom;
    // 12345
    bool hide = true;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: purple2),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("ชำระเงิน",
              style: TextStyle(
                fontFamily: 'Kanit',
                fontWeight: FontWeight.w600,
                color: purple2,
              )),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Form(
            key: _formkey,
            child: Padding(
              padding: EdgeInsets.only(bottom: bottom),
              child: Container(
                child: Column(
                  children: <Widget>[
                    new Container(
                      height: 200,

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black12,
                          boxShadow: [
                            new BoxShadow(
                                color: Colors.black12,
                                //offset: new Offset(3.0, 3.0),
                                blurRadius: 4.0,
                                spreadRadius: 1.0),
                          ]),
                      margin: EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 40, bottom: 20),
                      padding:
                          new EdgeInsets.only(top: 20, left: 15, right: 15),
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                        ),
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              children: <Widget>[
                                Icon(FontAwesomeIcons.ccVisa,
                                    color: Colors.white, size: 30),
                                Padding(padding: EdgeInsets.only(left: 10)),
                                Icon(
                                  FontAwesomeIcons.ccMastercard,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                // Text(
                                //   '$_cardnum',
                                //   style: TextStyle(
                                //     fontFamily: 'Kanit',
                                //     fontWeight: FontWeight.w600,
                                //     fontSize: 24,
                                //     color: purple1,
                                //   ),
                                // ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  '$_cardnum',
                                  style: TextStyle(
                                    fontFamily: 'Kanit',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24,
                                    color: purple1,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 20),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              children: <Widget>[
                                Text(
                                  '$_cardexp',
                                  style: TextStyle(
                                    fontFamily: 'Kanit',
                                    fontSize: 14,
                                    color: purple1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                ),
                                Text(
                                  'VALID THRU',
                                  style: TextStyle(
                                    fontFamily: 'Kanit',
                                    fontSize: 10,
                                    color: purple1,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              children: <Widget>[
                                Text(
                                  '$_cardcvv',
                                  style: TextStyle(
                                    fontFamily: 'Kanit',
                                    fontSize: 14,
                                    color: purple1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                ),
                                Text(
                                  'CVV/CVC',
                                  style: TextStyle(
                                    fontFamily: 'Kanit',
                                    fontSize: 10,
                                    color: purple1,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  '$_cardname',
                                  style: TextStyle(
                                    fontFamily: 'Kanit',
                                    fontSize: 20,
                                    color: purple1,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
//               child: new Container(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: <Widget>[
// //                   new Text,
// //                   new TextField(
// // //              autocorrect: true,
// // //              autofocus: true,
// //                     keyboardType: TextInputType.text,
// //                     decoration: new InputDecoration(
// //                         icon: Icon(Icons.perm_identity),
// //                         hintText: 'hi',
// //                         labelText: 'Your name'),
// //                     onChanged: onChangeValue,
// //                     onSubmitted: onSubmitValue,
// //                   ),
// //                 ],
//               ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15, bottom: 20),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'จำนวนที่นั่งทั้งหมด',
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 14,
                                  color: purple2,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(left: 10)),
                              Text(
                                seat.toString(),
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: purple2,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(left: 5)),
                              Text(
                                'ที่นั่ง',
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: purple2,
                                ),
                              ),
                            ],
                          ),
                          // Row(
                          //   children: <Widget>[
                          //     Text(
                          //       'จำนวนเงิน',
                          //       style: TextStyle(
                          //         fontFamily: 'Kanit',
                          //         fontSize: 14,
                          //         color: purple2,
                          //       ),


                          
                          //     ),
                          //     Padding(padding: EdgeInsets.only(left: 10)),
                          //     Text(
                          //       allint.toString(),
                          //       style: TextStyle(
                          //         fontFamily: 'Kanit',
                          //         fontWeight: FontWeight.w600,
                          //         fontSize: 14,
                          //         color: purple2,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          Text(
                            'ข้อมูลบัตรของคุณ',
                            style: TextStyle(
                              fontFamily: 'Kanit',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: purple2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 170,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            new BoxShadow(
                                color: Colors.black12,
                                //offset: new Offset(3.0, 3.0),
                                blurRadius: 4.0,
                                spreadRadius: 1.0),
                          ]),
                      margin:
                          EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20),
                      alignment: Alignment.topLeft,
                      child: Container(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    left: 15.0,
                                    right: 15.0,
                                    top: 15,
                                    bottom: 20),
                                decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextFormField(
                                  controller: _cardnumController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [maskFormatter1],
                                  autocorrect: true,
                                  autofocus: true,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    icon: Icon(Icons.credit_card,
                                        color: Colors.white),
                                    // hintText: 'What do people call you?',
                                    labelText: 'Card Number *',
                                  ),
                                  onChanged: onChangeValue1,
                                  //    onSubmitted: onSubmitValue,
                                  //  onChanged: onChangeValue,
                                  //  onSubmitted: onSubmitValue,
                                  onSaved: (String input) => _cardnum = input,
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.

                                  validator: (value) => value.trim().isEmpty
                                      ? 'กรุณาเลือกระบุCard Number'
                                      : null,
                                  //  onChanged: (input) => _startplace = input,
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 15),
                                    width: 350,
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextFormField(
                                      controller: _cardnameTimeController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        icon: Icon(Icons.person,
                                            color: Colors.white),
                                        //  hintText: 'What do people call you?',
                                        labelText: 'Card Name*',
                                      ),
                                      onChanged: onChangeValue4,
                                      onSaved: (String input) =>
                                          _cardname = input,
                                      validator: (value) => value.trim().isEmpty
                                          ? 'กรุณาเลือกระบุCard Number'
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     shareNotifier3.currentShare =
                    //         shareNotifier3.shareList[0];
                    //     Navigator.of(context).push(
                    //         MaterialPageRoute(builder: (BuildContext context) {
                    //       // return DetailSharesuccess();
                    //       return Payment();
                    //     }));
                    //   },
                    // child:
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 40),
                        constraints:
                            BoxConstraints.expand(height: 55, width: 380),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color(0xff5A45A5)),
                          child: FlatButton(
                            // onPressed: () {
                            //   print('a');
                            // },

                            onPressed: _paydilog,

                            child: Text('ยืนยันข้อมูล',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Kanit',
                                  fontSize: 22,
                                )),
                          ),
                        ),
                      ),
                    ),

                    // Opacity(
                    //   opacity: 0.0,
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       color: Colors.black12,
                    //     ),
                    //     child: TextFormField(
                    //       controller: _cardnameTimeController,
                    //       decoration: const InputDecoration(
                    //         border: InputBorder.none,
                    //         icon: Icon(Icons.person, color: Colors.white),
                    //         //  hintText: 'What do people call you?',
                    //         labelText: 'Card Name*',
                    //       ),
                    //       onSaved: (String input) => _cardname = input,
                    //       validator: (value) => value.trim().isEmpty
                    //           ? 'กรุณาเลือกระบุCard Number'
                    //           : null,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  final databaseReference = Firestore.instance;
  void _deleteData() {
    databaseReference.collection('Notishare').getDocuments().then((snapshot) {
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

  void _showDialog2() {
    final Color purple1 = Color(0xff5A45A5);
    final Color purple2 = Color(0xff2A1D59);
    final Color orange1 = Color(0xffF2551D);
    final Color orange2 = Color(0xffFF6D38);
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
                "เสร็จสิ้นการแชร์",
                style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 18,
                    color: purple2,
                    fontWeight: FontWeight.w600),
              ),
              content: Column(
                children: <Widget>[
                  Text(
                    "เสร็จสิ้นการแชร์ เรียบร้อย",
                    style: TextStyle(fontFamily: 'Kanit', color: orange1),
                  ),
                  Icon(FontAwesomeIcons.spinner, size: 40, color: orange1)
                ],
              ),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text(
                    "ตกลง",
                    style: TextStyle(fontFamily: 'Kanit', color: purple2),
                  ),
                  // onPressed: _deleteData,
                  onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return Home();
                    // return Payment();
                  })),
                ),
                // new FlatButton(
                //   child: new Text(
                //     "ยกเลิก",
                //     style: TextStyle(fontFamily: 'Kanit', color: purple2),
                //   ),
                //   onPressed: () {
                //     Navigator.pop(context);
                //   },
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// final databaseReference = Firestore.instance;
// void deleteData(docId) {
//   databaseReference
//       .collection('Notishare')
//       .document(docId)
//       .delete()
//       .catchError((e) {
//     print(e);
//   });
//   //     .then((snapshot) {
//   //   // for (DocumentSnapshot ds in snapshot.documents) {
//   //   //   ds.reference.delete();
//   //   // }
//   // });
//   // try {
//   //   databaseReference.collection('ShareRequest').document('D55JNu4VVBpxsuKcwP30').delete();
//   // } catch (e) {
//   //   print(e.toString());
//   // }
// }

getShare3(ShareNotifierrequest2 shareNotifier3) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Shareconfirm')
      // .where('Concertname', isEqualTo: '2020 IU Tour <LOVE, POEM> In Bkk')
      //.where('Seatyou', isGreaterThanOrEqualTo: '1')
      .getDocuments();
  List<Sharereq> _shareList = [];
  snapshot.documents.forEach((document) {
    Sharereq share = Sharereq.fromMap(document.data);
    _shareList.add(share);
  });
  shareNotifier3.shareList = _shareList;
}
