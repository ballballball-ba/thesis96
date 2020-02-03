import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mythesis96/Api/api.dart';
import 'package:mythesis96/Api/apiuse.dart';
import 'package:mythesis96/firebase/database_up.dart';
import 'package:mythesis96/m/payment_data.dart';
import 'package:mythesis96/m/user_data.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as Http;
import 'dart:convert';

import 'package:mythesis96/Api/apiuse.dart';

class Payment extends StatefulWidget {
  //Payment({Key key}) : super(key: key);

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

  _submit() async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();

      // _showDialog();
      // _showapipay();
      FutureBuilder(
          future: ApiService.paymentApi(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Pay msg = snapshot.data;
              print("snap = " + msg.message);
              return Flushbar()..show(context);
            } else {
              return CircularProgressIndicator();
            }
          });
      Flushbar(
        flushbarStyle: FlushbarStyle.FLOATING,
        backgroundColor: orange1,
        boxShadows: [
          BoxShadow(
            color: Colors.red[800],
            offset: Offset(0.0, 2.0),
            blurRadius: 3.0,
          )
        ],
        message: 'ชำระเงินเรียบร้อย',
        icon: Icon(
          Icons.info,
          size: 28.0,
          color: Colors.white,
        ),
        duration: Duration(seconds: 5),
        //leftBarIndicatorColor: Colors.blue[300],
        margin: EdgeInsets.all(8),
        borderRadius: 10,
      )..show(context);
      PaymentM payment = PaymentM(
        cardnum: _cardnum,
        cardexp: _cardexp,
        cardcvv: _cardcvv,
        cardname: _cardname,
        // endplace: _endplace,
        // price: _price,
        // seat: _seat,
        // date: _date,
        // time: _time,
        timestamp: Timestamp.fromDate(DateTime.now()),
        authorId: Provider.of<Userdata>(context).currentUserID,
      );

      DatabaseSer.createPay(payment);
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
        // _endplace = '';
        // _price = '';
        // _seat = '';
        // _date = '';
        // _time = '';
        /////////////
        // _brandcar = '';
        // _gencar = '';
        // _color = '';
        // _licensecar = '';

        // _isloading = false;
      });
    }

    //  _formkey.currentState.validate();
    //  _formkey.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

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
                          color: orange2,
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
                          new EdgeInsets.only(top: 40, left: 15, right: 15),
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                          top: 15,
                        ),
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: <Widget>[
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
                        children: <Widget>[
                          Text(
                            'ข้อมูลบัตรของคุณ',
                            style: TextStyle(
                              fontFamily: 'Kanit',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: purple2,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 250,
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
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextFormField(
                                      controller: _cardexpTimeController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [maskFormatter2],
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        icon: Icon(Icons.date_range,
                                            color: Colors.white),
                                        // hintText: 'What do people call you?',
                                        labelText: 'Exp*',
                                      ),
                                      onChanged: onChangeValue2,
                                      onSaved: (String input) =>
                                          _cardexp = input,
                                      validator: (value) => value.trim().isEmpty
                                          ? 'กรุณาเลือกระบุCard Number'
                                          : null,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 15),
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextFormField(
                                      controller: _cardcvvTimeController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [maskFormatter3],
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        icon: Icon(Icons.credit_card,
                                            color: Colors.white),
                                        // hintText: 'What do people call you?',
                                        labelText: 'CVV/CVC*',
                                      ),
                                      onChanged: onChangeValue3,
                                      onSaved: (String input) =>
                                          _cardcvv = input,
                                      validator: (value) => value.trim().isEmpty
                                          ? 'กรุณาเลือกระบุCard Number'
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 15, top: 20),
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
                    Container(
                      margin: EdgeInsets.only(bottom: 40),
                      constraints:
                          BoxConstraints.expand(height: 55, width: 380),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Color(0xff5A45A5)),
                        child: FlatButton(
                          // onPressed: () {},

                          onPressed: _submit,
                          child: Text('ชำระเงิน',
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
        ));
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // title: Text(msg),
            content: Text('sad'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('close'))
            ],
          );
        });
  }
}
