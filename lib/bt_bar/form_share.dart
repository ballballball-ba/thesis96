import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mythesis96/bt_bar/homemain.dart';
import 'package:mythesis96/firebase/constance.dart';
import 'package:mythesis96/firebase/auth_service.dart';
import 'package:mythesis96/firebase/database_up.dart';
import 'package:mythesis96/m/car_data.dart';
import 'package:mythesis96/m/share_posts.dart';
import 'package:mythesis96/m/user_data.dart';
import 'package:mythesis96/m/user_m.dart';
import 'package:provider/provider.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class Shareform extends StatefulWidget {
  static final String id = 'Shareform_screen';
  final String userId;

//construtor
  Shareform({this.userId});
  @override
  _ShareformState createState() => _ShareformState();
}

var dateFormatter = new MaskTextInputFormatter(
    mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});
var timeFormatter = new MaskTextInputFormatter(
    mask: '##:## น.', filter: {"#": RegExp(r'[0-9]')});
// var priceFormatter = new MaskTextInputFormatter(
//     mask: '##', filter: {"#": RegExp(r'[0-9]')});
// main() {
//   var now = new DateTime.now();
//   var formatter = new DateFormat('yyyy-MMM-dd');
//   String formatted = formatter.format(now);
//   print(formatted); // something like 2019-Jun-20
// }

class _ShareformState extends State<Shareform> {
  final TextEditingController _picController = TextEditingController();

  String dateFormate;
  DateTime pickedDate;
  TimeOfDay time;
  String _dropDownValue;
  String _dropDownValue2;
  String _dropDownValue3;
  String _dropDownValue4;
  String _dropDownValue5;

  var selectedCurrency, selectpicpro;

  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();

  TextEditingController _concertnameController = TextEditingController();
  TextEditingController _startplaceController = TextEditingController();
  TextEditingController _endplaceController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _seatController = TextEditingController();
  TextEditingController _seatyouController = TextEditingController();
  TextEditingController _seatyou2Controller = TextEditingController();
  TextEditingController _datetimeController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _detailsController = TextEditingController();

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
  String _seatyou = '';
  String _seatyou2 = '';
  String _date = '';
  String _time = '';
  String _details = '';
  String _picpro = '';
  String _gender = '';

  ///car
  String _brandcar = '';
  String _gencar = '';
  String _color = '';
  String _licensecar = '';

  bool _isloading = false;
  final Color purple1 = Color(0xff5A45A5);
  final Color purple2 = Color(0xff2A1D59);
  final Color purple3 = Color(0xffBDAEF2);
  final Color orage1 = Color(0xffF2551D);
  final Color purple4 = Color(0xffA99CD9);
  // final Color fonts = Color(0xffb3b3b3);
  //final Color bg_orange = Color(0xffF48C67);
  final _formkey = GlobalKey<FormState>();

  String radiovalue;

  setRadioValue(String value) {
    setState(() {
      radiovalue = value;
      _picpro = value;
      print(radiovalue);
      print(_picpro);
    });
  }

  _submit() async {
    //  if (_formkey.currentState.validate()) {
    //   _formkey.currentState.save();
    //   // Logging in the user w/ Firebase

    // }
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Home(),
        ),
      );

      Flushbar(
        message: 'สร้างการแชร์เรียบร้อย เรียบร้อย',
        backgroundColor: Colors.green,
        icon: Icon(
          Icons.assignment_turned_in,
          size: 28.0,
          color: Colors.white,
        ),
        duration: Duration(seconds: 4),
        //leftBarIndicatorColor: Colors.blue[300],
        margin: EdgeInsets.all(8),
        borderRadius: 10,
      )..show(context);
      var now = new DateTime.now();

      getpicpro() {
        return StreamBuilder(
          stream: Firestore.instance
              .collection('Users')
              .document(Provider.of<Userdata>(context).currentUserID)
              // .collection('picprofileUrl')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('wait');
            }
            var userDocument = snapshot.data['picprofileUrl'].toString();
          },
        );
      }

      // picpro() {
      //   Scaffold(
      //     body: FutureBuilder(
      //         future: userRef.document(widget.userId).get(),
      //         builder: (BuildContext context, AsyncSnapshot snapshot) {
      //           if (!snapshot.hasData) {
      //             return Center(
      //               child: CircularProgressIndicator(),
      //             );
      //           }
      //           User user = User.fromDoc(snapshot.data);

      Share sharepost = Share(
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
        gender: _gender,
        //  picpro: userDocument,
        picpro: 'https://firebasestorage.googleapis.com/v0/b/thesis96-a41c0.appspot.com/o/images%2Fusers%2FuserProfile_00d4f1e1-cbbf-4efb-81fe-3dab782788d5.jpg?alt=media&token=4739e9c2-40b4-4709-809a-010e50eaa799',
        //********************** */
        brandcar: _brandcar,
        gencar: _gencar,
        color: _color,
        licensecar: _licensecar,

        timestamp: DateFormat("dd-MM-yyyy hh:mm").format(now),
        authorId: Provider.of<Userdata>(context).currentUserID,
      );
      DatabaseSer.createShare(sharepost);
      Cardata car = Cardata(
        brandcar: _brandcar,
        gencar: _gencar,
        color: _color,
        licensecar: _licensecar,
        timestamp: DateFormat("dd-MM-yyyy hh:mm").format(now),
        authorId: Provider.of<Userdata>(context).currentUserID,
      );

      DatabaseSer.createCar(car);

      // รีเซทข้อมูลให้ว่างเหมือนเดิม
      _concertnameController.clear();
      _startplaceController.clear();
      _endplaceController.clear();
      _priceController.clear();
      _seatController.clear();
      _seatyouController.clear();
      _seatyou2Controller.clear();
      _datetimeController.clear();
      _dateController.clear();
      _timeController.clear();
      _detailsController.clear();
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
        _seatyou = '';
        _seatyou2 = '';
        _date = '';
        _time = '';
        _details = '';
        _picpro = '';
        /////////////
        _brandcar = '';
        _gencar = '';
        _color = '';
        _licensecar = '';

        // _isloading = false;
      });
      //         }),
      //   );
      // }

    } else {
      Flushbar(
        message: 'ไม่สามารถสร้างการแชร์ได้ ลองอีกครั้ง',
        backgroundColor: Colors.red,
        icon: Icon(
          Icons.assignment_turned_in,
          size: 28.0,
          color: Colors.white,
        ),
        duration: Duration(seconds: 4),
        //leftBarIndicatorColor: Colors.blue[300],
        margin: EdgeInsets.all(8),
        borderRadius: 10,
      )..show(context);
    }

    //  _formkey.currentState.validate();
    //  _formkey.currentState.save();
  }

  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: purple2),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("สร้างการแชร์",
            style: TextStyle(
              fontFamily: 'Kanit',
              fontWeight: FontWeight.w600,
              color: purple2,
            )),
        centerTitle: true,
      ),

      ///แก้ button float
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: Firestore.instance
                .collection('Users')
                .document(Provider.of<Userdata>(context).currentUserID)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('is somthing worg about database.....');
              }
              // else if(snapshot.data['picprofileUrl'].toString().isNotEmpty){
              //  //  var userDocument = snapshot.data['picprofileUrl'].toString();
              // }
              if (snapshot.data['picprofileUrl'].toString() != null) {
                var userDocument = snapshot.data['picprofileUrl'].toString();
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
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
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.blue),
                                  ),
                                )
                              : SizedBox.shrink(),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: purple3,
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
                                key: _formkey,
                                child: Column(children: <Widget>[
                                  Container(
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: Firestore.instance
                                            .collection("Concert")
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData)
                                            const Text("Loading.....");
                                          else {
                                            List<DropdownMenuItem>
                                                currencyItems = [];
                                            for (int i = 0;
                                                i <
                                                    snapshot
                                                        .data.documents.length;
                                                i++) {
                                              DocumentSnapshot snap =
                                                  snapshot.data.documents[i];
                                              currencyItems.add(
                                                DropdownMenuItem(
                                                  child: Container(
                                                    width: 286,
                                                    margin: EdgeInsets.only(
                                                        left: 5),
                                                    child: Text(
                                                      snap.data['nameconshort'],
                                                      style: TextStyle(
                                                        color: orage1,
                                                        fontSize: 14,
                                                        fontFamily: 'Kanit',
                                                      ),
                                                    ),
                                                  ),
                                                  value:
                                                      "${snap.data['nameconshort']}",
                                                ),
                                              );
                                            }
                                            return Row(
                                              children: <Widget>[
                                                //  SizedBox(width: 50.0),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: purple4,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  margin: EdgeInsets.only(
                                                      left: 15.0,
                                                      right: 15.0,
                                                      top: 10,
                                                      bottom: 10),
                                                  child: DropdownButton(
                                                    underline: SizedBox(),
                                                    items: currencyItems,
                                                    icon: Icon(
                                                        Icons.arrow_drop_down,
                                                        size: 25.0,
                                                        color: orage1),
                                                    // onChanged:((input)  => _concertname = input),
                                                    onChanged: (input) {
                                                      this._concertname = input;
                                                      print('$input');

                                                      setState(() {
                                                        // this._concertname = input;
                                                        selectedCurrency =
                                                            input;
                                                      });
                                                    },
                                                    value: selectedCurrency,

                                                    isExpanded: false,

                                                    hint: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      child: new Text(
                                                        "เลือกคอนเสิร์ต",
                                                        style: TextStyle(
                                                          color: orage1,
                                                          fontFamily: 'Kanit',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 100.0,
                                                ),
                                              ],
                                            );
                                          }
                                        }),

                                    /////////////////////////////////
                                  ),

                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: purple4,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 15.0,
                                        right: 15.0,
                                        top: 10,
                                        bottom: 20),
                                    child: TextFormField(
                                      autofocus: true,
                                      controller: _startplaceController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.place,
                                            color: Colors.white),
                                        hintText: 'จุดเริ่มต้น',
                                        hintStyle: TextStyle(
                                          color: Colors.white70,
                                          fontFamily: 'Kanit',
                                          // fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      validator: (input) => input.trim().isEmpty
                                          ? 'กรุณาเลือกจุดเริ่มต้น'
                                          : null,
                                      onChanged: (input) => _startplace = input,

                                      // onSaved: (input) => _email = input,
                                    ),
                                  ),
                                  //  Opacity(child: Container(child:getpicpro(),)),

                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: purple4,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 15.0,
                                        right: 15.0,
                                        top: 10,
                                        bottom: 20),
                                    child: TextFormField(
                                      autofocus: true,

                                      controller: _endplaceController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.place,
                                            color: Colors.white),
                                        hintText: 'ปลายทาง',
                                        hintStyle: TextStyle(
                                          color: Colors.white70,
                                          fontFamily: 'Kanit',
                                          // fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      validator: (input) => input.trim().isEmpty
                                          ? 'กรุณากำหนดปลายทาง'
                                          : null,
                                      // onSaved: (input) => _password = input,
                                      // obscureText: true,
                                      onChanged: (input) => _endplace = input,
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    margin: EdgeInsets.only(
                                        left: 15.0,
                                        right: 200.0,
                                        top: 10,
                                        bottom: 20),
                                    decoration: BoxDecoration(
                                        color: purple4,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextFormField(
                                      autofocus: true,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(3),
                                      ],
                                      controller: _priceController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.attach_money,
                                            color: Colors.white),
                                        hintText: 'ราคา/ที่นั่ง',
                                        hintStyle: TextStyle(
                                          color: Colors.white70,
                                          fontFamily: 'Kanit',
                                          // fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      validator: (input) => input.trim().isEmpty
                                          ? 'กรุณากำหนดราคา'
                                          : null,
                                      onChanged: (input) => _price = input,
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: 15),
                                        height: 50,
                                        width: 160,
                                        decoration: BoxDecoration(
                                            color: purple4,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        // margin: EdgeInsets.only(
                                        //     left: 15.0, right: 150, top: 10, bottom: 20),

                                        child: TextFormField(
                                          autofocus: true,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [dateFormatter],

                                          controller: _dateController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            prefixIcon: Icon(Icons.date_range,
                                                color: Colors.white),
                                            hintText: 'วันที่ ดด/วว/ปปปป',
                                            hintStyle: TextStyle(
                                                color: Colors.white70,
                                                fontFamily: 'Kanit',
                                                fontSize: 14
                                                // fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                          validator: (input) =>
                                              input.trim().isEmpty
                                                  ? 'กรุณาระบุวันที่'
                                                  : null,
                                          // onSaved: (input) => _password = input,
                                          // obscureText: true,
                                          onChanged: (input) => _date = input,
                                        ),
                                      ),
                                      // Container(
                                      //   margin: EdgeInsets.only(
                                      //       top: 80.0, left: 28.0),
                                      //   child: Icon(
                                      //     Icons.person,
                                      //     color: Colors.redAccent,
                                      //     size: 20.0,
                                      //   ),
                                      // ),
                                      Container(
                                        margin: EdgeInsets.only(left: 15),
                                        height: 50,
                                        width: 140,

                                        decoration: BoxDecoration(
                                            color: purple4,
                                            borderRadius:
                                                BorderRadius.circular(10)),

                                        // margin: EdgeInsets.only(
                                        //     left: 15.0, right: 150, top: 10, bottom: 20),
                                        // child: TextFormField(
                                        //   autofocus: true,
                                        //   keyboardType: TextInputType.number,
                                        //   inputFormatters: [timeFormatter],
                                        //   controller: _timeController,
                                        //   decoration: InputDecoration(
                                        //     border: InputBorder.none,
                                        //     prefixIcon: Icon(Icons.access_time,
                                        //         color: Colors.white),
                                        //     hintText: 'เวลา 18:00',
                                        //     hintStyle: TextStyle(
                                        //       color: Colors.white70,
                                        //       fontFamily: 'Kanit',
                                        //       // fontWeight: FontWeight.w600,
                                        //     ),
                                        //   ),
                                        //   validator: (input) =>
                                        //       input.trim().isEmpty
                                        //           ? 'กรุณาระบุระบุเวลา'
                                        //           : null,
                                        //   // onSaved: (input) => _password = input,
                                        //   // obscureText: true,
                                        //   onChanged: (input) => _time = input,
                                        // ),
                                        child: DropdownButton(
                                          iconEnabledColor: Colors.white,
                                          iconDisabledColor: Colors.white,
                                          underline: SizedBox(),
                                          isExpanded: true,
                                          iconSize: 30.0,
                                          style: TextStyle(color: purple2),
                                          items: [
                                            '00:00 น.',
                                            '00:30 น.',
                                            '01:00 น.',
                                            '01:30 น.',
                                            '09:00 น.',
                                            '09:30 น.',
                                            '10:00 น.',
                                            '10:30 น.',
                                            '11:00 น.',
                                            '11:30 น.',
                                            '12:00 น.',
                                            '12:30 น.',
                                            '13:00 น.',
                                            '13:30 น.',
                                            '14:00 น.',
                                            '14:30 น.',
                                            '15:00 น.',
                                            '15:30 น.',
                                            '16:00 น.',
                                            '16:30 น.',
                                            '17:00 น.',
                                            '17:30 น.',
                                            '18:00 น.',
                                            '18:30 น.',
                                            '19:00 น.',
                                            '19:30 น.',
                                            '20:00 น.',
                                            '20:30 น.',
                                            '21:00 น.',
                                            '21:30 น.',
                                            '22:00 น.',
                                            '22:30 น.',
                                            '23:00 น.',
                                            '23:30 น.',
                                          ].map(
                                            (val) {
                                              return DropdownMenuItem<String>(
                                                value: val,
                                                child: Text(val),
                                              );
                                            },
                                          ).toList(),
                                          onChanged: (val) {
                                            _dropDownValue = val;
                                            print(_dropDownValue);
                                            setState(
                                              () {
                                                _dropDownValue = val;
                                                if (val.isEmpty) {
                                                  _time = val;
                                                } else {
                                                  _time = val;
                                                }
                                              },
                                            );
                                          },
                                          hint: _dropDownValue == null
                                              ? Center(
                                                  child: Text(
                                                    'กรุณาระบุเวลา',
                                                    style: TextStyle(
                                                      color: Colors.white70,
                                                      fontFamily: 'Kanit',
                                                      // fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                )
                                              : Center(
                                                  child: Text(
                                                    _dropDownValue,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Kanit',
                                                      // fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  //

                                  Padding(padding: EdgeInsets.only(bottom: 15)),
                                  Divider(
                                    color: Colors.black38,
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 15)),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        height: 50,
                                        width: 160,
                                        decoration: BoxDecoration(
                                            color: purple4,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        margin: EdgeInsets.only(left: 15.0),
                                        child: TextFormField(
                                          autofocus: true,
                                          controller: _brandcarControlle,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            prefixIcon: Icon(
                                                Icons.directions_car,
                                                color: Colors.white),
                                            hintText: 'ยี่ห้อรถ',
                                            hintStyle: TextStyle(
                                              color: Colors.white70,
                                              fontFamily: 'Kanit',
                                              // fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          validator: (input) =>
                                              input.trim().isEmpty
                                                  ? 'กรุณาระบุยี่ห้อรถ'
                                                  : null,
                                          // onSaved: (input) => _password = input,
                                          // obscureText: true,
                                          onChanged: (input) =>
                                              _brandcar = input,
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width: 140,
                                        decoration: BoxDecoration(
                                            color: purple4,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        margin: EdgeInsets.only(
                                          left: 15.0,
                                        ),
                                        child: TextFormField(
                                          autofocus: true,
                                          controller: _colorControlle,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            prefixIcon: Icon(Icons.color_lens,
                                                color: Colors.white),
                                            hintText: 'สีรถ',
                                            hintStyle: TextStyle(
                                                color: Colors.white70,
                                                fontFamily: 'Kanit'
                                                // fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                          validator: (input) =>
                                              input.trim().isEmpty
                                                  ? 'กรุณาระบุสี'
                                                  : null,
                                          // onSaved: (input) => _password = input,
                                          // obscureText: true,
                                          onChanged: (input) => _color = input,
                                        ),
                                      ),
                                    ],
                                  ),

                                  Row(
                                    children: <Widget>[
                                      Container(
                                        height: 50,
                                        width: 160,
                                        decoration: BoxDecoration(
                                            color: purple4,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        margin: EdgeInsets.only(
                                            left: 15.0, top: 30, bottom: 20),
                                        child: TextFormField(
                                          autofocus: true,
                                          controller: _licensecarControlle,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            prefixIcon: Icon(
                                                Icons.format_list_numbered,
                                                color: Colors.white),
                                            hintText: 'เลขะเบียน',
                                            hintStyle: TextStyle(
                                              color: Colors.white70,
                                              fontFamily: 'Kanit',
                                              // fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          validator: (input) =>
                                              input.trim().isEmpty
                                                  ? 'กรุณาระบุเลขทะเบียน'
                                                  : null,
                                          // onSaved: (input) => _password = input,
                                          // obscureText: true,
                                          onChanged: (input) =>
                                              _licensecar = input,
                                        ),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            'เราจะไม่บอกเลขทะเบียน',
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontFamily: 'Kanit',
                                                fontSize: 14),
                                          ),
                                          Text(
                                            '   ก่อนจะมีการตอบรับคำร้อง',
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontFamily: 'Kanit',
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),

                                  //   ],
                                  // ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        height: 50,
                                        width: 160,
                                        decoration: BoxDecoration(
                                            color: purple4,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        margin: EdgeInsets.only(
                                            top: 10, left: 15, bottom: 20),
                                        child: DropdownButton(
                                          iconEnabledColor: Colors.white,
                                          iconDisabledColor: Colors.white,
                                          underline: SizedBox(),
                                          isExpanded: true,
                                          iconSize: 30.0,
                                          style: TextStyle(color: purple2),
                                          items: [
                                            '1',
                                            '2',
                                            '3',
                                            '4',
                                            '5',
                                            '6',
                                            '7',
                                            '8',
                                            '9',
                                            '10',
                                            '11',
                                            '12',
                                            '13',
                                          ].map(
                                            (val) {
                                              return DropdownMenuItem<String>(
                                                value: val,
                                                child: Text(val),
                                              );
                                            },
                                          ).toList(),
                                          onChanged: (val) {
                                            _dropDownValue2 = val;
                                            print(_dropDownValue2);
                                            setState(
                                              () {
                                                _dropDownValue2 = val;
                                                if (val.isEmpty) {
                                                  _seat = val;
                                                } else {
                                                  _seat = val;
                                                }
                                              },
                                            );
                                          },
                                          hint: _dropDownValue2 == null
                                              ? Center(
                                                  child: Text(
                                                    'ระบุจำนวนที่ต้องการ',
                                                    style: TextStyle(
                                                      color: Colors.white70,
                                                      fontFamily: 'Kanit',
                                                      // fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                )
                                              : Center(
                                                  child: Text(
                                                    _dropDownValue2,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Kanit',
                                                      // fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width: 140,
                                        decoration: BoxDecoration(
                                            color: purple4,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        margin: EdgeInsets.only(
                                            top: 10, left: 15, bottom: 20),
                                        child: DropdownButton(
                                          iconEnabledColor: Colors.white,
                                          iconDisabledColor: Colors.white,
                                          underline: SizedBox(),
                                          isExpanded: true,
                                          iconSize: 30.0,
                                          style: TextStyle(color: purple2),
                                          items: [
                                            'ทั้งหมด',
                                            'ชาย',
                                            'หญิง',
                                          ].map(
                                            (val) {
                                              return DropdownMenuItem<String>(
                                                value: val,
                                                child: Text(val),
                                              );
                                            },
                                          ).toList(),
                                          onChanged: (val) {
                                            _dropDownValue3 = val;
                                            print(_dropDownValue3);
                                            setState(
                                              () {
                                                _dropDownValue3 = val;
                                                if (val.isEmpty) {
                                                  _gender = val;
                                                } else {
                                                  _gender = val;
                                                }
                                              },
                                            );
                                          },
                                          hint: _dropDownValue3 == null
                                              ? Center(
                                                  child: Text(
                                                    'ระบุเพศที่ต้องการ',
                                                    style: TextStyle(
                                                      color: Colors.white70,
                                                      fontFamily: 'Kanit',
                                                      // fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                )
                                              : Center(
                                                  child: Text(
                                                    _dropDownValue3,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Kanit',
                                                      // fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        height: 50,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            color: purple4,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        margin: EdgeInsets.only(
                                            top: 10, left: 15, bottom: 20),
                                        child: DropdownButton(
                                          iconEnabledColor: Colors.white,
                                          iconDisabledColor: Colors.white,
                                          underline: SizedBox(),
                                          isExpanded: true,
                                          iconSize: 30.0,
                                          style: TextStyle(color: purple2),
                                          items: [
                                            '0',
                                            '1',
                                            '2',
                                            '3',
                                            '4',
                                            '5',
                                            '6',
                                            '7',
                                            '8',
                                            '9',
                                            '10',
                                            '11',
                                            '12',
                                            '13',
                                          ].map(
                                            (val) {
                                              return DropdownMenuItem<String>(
                                                value: val,
                                                child: Text(val),
                                              );
                                            },
                                          ).toList(),
                                          onChanged: (val) {
                                            _dropDownValue4 = val;
                                            print(_dropDownValue4);
                                            setState(
                                              () {
                                                _dropDownValue4 = val;
                                                if (val.isEmpty) {
                                                  _seatyou = val;
                                                } else {
                                                  _seatyou = val;
                                                }
                                              },
                                            );
                                          },
                                          hint: _dropDownValue4 == null
                                              ? Center(
                                                  child: Text(
                                                    'ชาย',
                                                    style: TextStyle(
                                                      color: Colors.white70,
                                                      fontFamily: 'Kanit',
                                                      // fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                )
                                              : Center(
                                                  child: Text(
                                                    _dropDownValue4,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Kanit',
                                                      // fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            color: purple4,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        margin: EdgeInsets.only(
                                            top: 10, left: 15, bottom: 20),
                                        child: DropdownButton(
                                          iconEnabledColor: Colors.white,
                                          iconDisabledColor: Colors.white,
                                          underline: SizedBox(),
                                          isExpanded: true,
                                          iconSize: 30.0,
                                          style: TextStyle(color: purple2),
                                          items: [
                                            '0',
                                            '1',
                                            '2',
                                            '3',
                                            '4',
                                            '5',
                                            '6',
                                            '7',
                                            '8',
                                            '9',
                                            '10',
                                            '11',
                                            '12',
                                            '13',
                                          ].map(
                                            (val) {
                                              return DropdownMenuItem<String>(
                                                value: val,
                                                child: Text(val),
                                              );
                                            },
                                          ).toList(),
                                          onChanged: (val) {
                                            _dropDownValue5 = val;
                                            print(_dropDownValue5);
                                            setState(
                                              () {
                                                _dropDownValue5 = val;
                                                if (val.isEmpty) {
                                                  _seatyou2 = val;
                                                } else {
                                                  _seatyou2 = val;
                                                }
                                              },
                                            );
                                          },
                                          hint: _dropDownValue5 == null
                                              ? Center(
                                                  child: Text(
                                                    'หญิง',
                                                    style: TextStyle(
                                                      color: Colors.white70,
                                                      fontFamily: 'Kanit',
                                                      // fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                )
                                              : Center(
                                                  child: Text(
                                                    _dropDownValue5,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Kanit',
                                                      // fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            'กรุณาระบุจำนวน',
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontFamily: 'Kanit',
                                                fontSize: 14),
                                          ),
                                          Text(
                                            '   คนภายในรถของคุณ',
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontFamily: 'Kanit',
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 80,
                                    decoration: BoxDecoration(
                                        color: purple4,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                      left: 15.0,
                                      right: 15.0,
                                      top: 10,
                                    ),
                                    child: TextFormField(
                                      autofocus: true,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      controller: _detailsController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.info,
                                            color: Colors.white),
                                        hintText:
                                            'รายละเอียดเพิ่มติม เช่น ขึ้นทางด่วน',
                                        hintStyle: TextStyle(
                                          color: Colors.white70,
                                          fontFamily: 'Kanit',
                                          // fontWeight: FontWeight.w600,
                                        ),
                                      ),

                                      // onSaved: (input) => _password = input,
                                      // obscureText: true,
                                      onChanged: (input) => _details = input,
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(bottom: 15)),

                                  //   Container(
                                  //     // child: TextField(
                                  //     //   onChanged: (userDocument) {
                                  //     //     this._picpro =userDocument;
                                  //     //     print("First text field: $userDocument");
                                  //     //   },
                                  //     // ),

                                  //    // child: getpicpro(),
                                  //     child: TextFormField(
                                  //         // controller: _detailsController,

                                  //        initialValue: userDocument =
                                  //             snapshot.data['picprofileUrl'].toString(),
                                  //         // initialValue: 'https://firebasestorage.googleapis.com/v0/b/thesis96-a41c0.appspot.com/o/images%2Fusers%2FuserProfile_91050f0d-96bb-4fa8-824a-f4c46f550f49.jpg?alt=media&token=7d6c9039-4a56-4bcc-8998-c82b41557ac9',
                                  //         // userDocument['picprofileUrl'],
                                  //         // onSaved: (input) => _password = input,
                                  //       //  obscureText: true,
                                  //         //  value = userDocument,
                                  //         //  onChanged: (input) => _details = input,

                                  //         onChanged: (userDocument) => picpro = userDocument
                                  //         // {

                                  //         //   setState(() {
                                  //         //     userDocument = snapshot.data['picprofileUrl'].toString();
                                  //         //     initialValue = userDocument;
                                  //         //     this._picpro = initialValue;
                                  //         //   });
                                  //         // }
                                  //         // {
                                  //         //   setState(() {
                                  //         //     this._picpro = initialValue;
                                  //         //   });
                                  //         // }
                                  //         ),
                                  //  ),
                                ])),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            margin: EdgeInsets.only(bottom: 40),
                            constraints:
                                BoxConstraints.expand(height: 55, width: 340),
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
                );
              }
            }),
      ),
    );
  }
}

main() {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MMM-dd');
  String formatted = formatter.format(now);
  print(formatted); // something like 2019-Jun-20
}

todayDate() {
  var now = new DateTime.now();
  var formatter = new DateFormat('dd-MM-yyyy');
  String formattedTime = DateFormat('kk:mm:a').format(now);
  String formattedDate = formatter.format(now);
  print(formattedTime);
  print(formattedDate);
}

class getpicurl extends StatefulWidget {
  @override
  _getpicurlState createState() => _getpicurlState();
}

class _getpicurlState extends State<getpicurl> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder(
      stream: Firestore.instance
          // .collection('Concert').where('Place', isEqualTo: 'ธันเดอร์โดม Thunder Dome, Muangthong Thani')
          .collection('Users')
          .document(Provider.of<Userdata>(context).currentUserID)
          // .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('wait');
        }
        return Text(snapshot.data['picprofileUrl'].toString());
        // var userDocument = snapshot.data['picprofileUrl'].toString();
      },
    ));
  }
}
// class getpicurl extends StatefulWidget {
//   getpicurl({Key key}) : super(key: key);

//   @override
//   _getpicurlState createState() => _getpicurlState();
// }

// class _getpicurlState extends State<getpicurl> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: StreamBuilder(
//             stream: Firestore.instance
//                 // .collection('Concert').where('Place', isEqualTo: 'ธันเดอร์โดม Thunder Dome, Muangthong Thani')
//                 .collection('Users')
//           .document(Provider.of<Userdata>(context).currentUserID)
//                 // .orderBy('timestamp', descending: true)
//                 .snapshots(),
//            builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return Text('wait');
//         }
//         return Text(snapshot.data['picprofileUrl'].toString());
//         // var userDocument = snapshot.data['picprofileUrl'].toString();
//       },
//             ));
//   }
// }
// // getpicpro() {
//     return StreamBuilder(
//       stream: Firestore.instance
//           .collection('Users')
//           .document(Provider.of<Userdata>(context).currentUserID)
//           // .collection('picprofileUrl')
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return Text('wait');
//         }
//         var userDocument = snapshot.data['picprofileUrl'].toString();
//       },
//     );
//   }
