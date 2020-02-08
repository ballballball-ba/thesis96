import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mythesis96/firebase/constance.dart';
import 'package:mythesis96/firebase/auth_service.dart';
import 'package:mythesis96/firebase/database_up.dart';
import 'package:mythesis96/m/car_data.dart';
import 'package:mythesis96/m/share_posts.dart';
import 'package:mythesis96/m/user_data.dart';
import 'package:mythesis96/signup_driver.dart';
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
  // something like 2019-Jun-20
  // DateTime now = DateTime.now();
  // var format = DateFormat.yMd('ar');
  //String dateString = format.format(DateTime.now());
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   pickedDate = DateTime.now();
  //   time = TimeOfDay.now();
  // }
  // DateTime selectedDate = DateTime.now();

  // final _formkey = GlobalKey<FormState>();
  var selectedCurrency, selectpicpro;
  // final format = DateFormat("HH:mm");

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
  // String _username, _email, _password;

  // stream: Firestore.instance.collection('Users').snapshots(),
  //         builder: (context, snapshot) {
  //           if (!snapshot.hasData) return Text('asd');

  // _submit() {
  //   if (_formkey.currentState.validate()) {
  //     _formkey.currentState.save();
  //     // Logging in the user w/ Firebase
  //     AuthService.signUpUser(context, _username, _email, _password);
  //   }
  // }
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
        var userDocument = snapshot.data;
        return Text(userDocument['picprofileUrl'].toString());

        //
      },
    );
  }

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
      // setState(() {
      //   _isloading = true;
      //       // });
      //  if (!_isloading &&
      //         _concertname.isNotEmpty &&
      //         _startplace.isNotEmpty &&
      //         _endplace.isNotEmpty &&
      //         _price != null &&
      //         _seat != null &&
      //         _datetime.isNotEmpty &&
      //         //car
      //         _brandcar.isNotEmpty &&
      //         _gencar.isNotEmpty &&
      //         _color.isNotEmpty &&
      //         _licensecar.isNotEmpty) {
      //       setState(() {
      //         _isloading = true;
      //       });
      // สร้างแชร
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
        picpro: _picpro,
        //********************** */
        brandcar: _brandcar,
        gencar: _gencar,
        color: _color,
        licensecar: _licensecar,

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

  //final databaseReference = Firestore.instance;
  //  void createRecord() async {
  //     await databaseReference.collection("Shareposts_web")
  //         .document("1")
  //         .setData({
  //           'title': 'Mastering Flutter',
  //           'description': 'Programming Guide for Dart'
  //         });
  // DateTime _date = new DateTime.now();
  // TimeOfDay _time = new TimeOfDay.now();

  // Future<Null> _selectDate(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: _date,
  //       firstDate: new DateTime(2016),
  //       lastDate: new DateTime(2021));

  //   if (picked != null && picked != _date) {
  //     print('เลือก: ${_date.toString()}');

  //     setState(() {
  //       _date = picked;
  //       // _datetime = picked as String;
  //     });
  //   }
  // }

  // Future<AboutListTile> _selectTime(BuildContext context) async {
  //   final TimeOfDay picked = await showTimePicker(
  //     context: context,
  //     initialTime: _time,
  //     //  firstDate: new DateTime(2016),
  //     //   lastDate:  new DateTime(2021)
  //   );
  //   if (picked != null && picked != _time) {
  //     print('เลือก: ${_date.toString()}');
  //     setState(() {
  //       _time = picked;
  //     });
  //   }
  // }

  // Future<Null> _selectDate(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(1901, 1),
  //       lastDate: DateTime(2100));
  //   if (picked != null && picked != selectedDate) print('5555555$selectedDate');

  //   setState(() {
  //     selectedDate = picked;
  //     _date.value = TextEditingValue(text: picked.toString());
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // getpicpro() {
    //   return new StreamBuilder(
    //       stream: Firestore.instance.collection('Users').document().snapshots(),
    //       builder: (context, snapshot) {
    //         if (!snapshot.hasData) {
    //           return new Text("Loading");
    //         }
    //         var userDocument = snapshot.data;
    //         return new Text(userDocument["picprofileUrl"]);
    //       });
    // }

    // DateTime now = DateTime.now();
    // String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    // final Share newContact = new Share();
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
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
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('Users')
              .document(Provider.of<Userdata>(context).currentUserID)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('is somthing worg about database.....');
            }

            return SingleChildScrollView(
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
                              //
                              //
                              //
                              //
                              //
                              //////////////////////////neweeeeeeeeeeeeeeeeeeeeeeeeeeee
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: Firestore.instance
                                      .collection("Concert")
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData)
                                      const Text("Loading.....");
                                    else {
                                      List<DropdownMenuItem> currencyItems = [];
                                      for (int i = 0;
                                          i < snapshot.data.documents.length;
                                          i++) {
                                        DocumentSnapshot snap =
                                            snapshot.data.documents[i];
                                        currencyItems.add(
                                          DropdownMenuItem(
                                            child: Container(
                                              margin: EdgeInsets.only(left: 5),
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
                                                  BorderRadius.circular(10),
                                            ),
                                            margin: EdgeInsets.only(
                                                left: 15.0,
                                                right: 15.0,
                                                top: 10,
                                                bottom: 10),
                                            child: DropdownButton(
                                              underline: SizedBox(),
                                              items: currencyItems,
                                              icon: Icon(Icons.arrow_drop_down,
                                                  size: 25.0, color: orage1),
                                              // onChanged:((input)  => _concertname = input),
                                              onChanged: (input) {
                                                this._concertname = input;
                                                print('$input');

                                                setState(() {
                                                  // this._concertname = input;
                                                  selectedCurrency = input;
                                                });
                                              },
                                              value: selectedCurrency,

                                              isExpanded: false,

                                              hint: Container(
                                                margin:
                                                    EdgeInsets.only(left: 10),
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
                              // child: TextFormField(
                              //   controller: _concertnameController,
                              //   decoration: InputDecoration(
                              //     labelText: 'เลือกคอนเสิร์ต',
                              //   ),
                              //   validator: (input) => input.trim().isEmpty
                              //       ? 'กรุณาเลือกคอนเสิร์ต'
                              //       : null,
                              //   onChanged: (input) => _concertname = input,
                              // ),
                            ),
                            // Container(
                            //   height: 50,
                            //   decoration: BoxDecoration(
                            //       color: purple4,
                            //       borderRadius: BorderRadius.circular(10)),
                            //   margin: EdgeInsets.only(
                            //       left: 15.0, right: 15.0, top: 10, bottom: 20),
                            // child: TextFormField(
                            //   controller: _startplaceController,
                            //   decoration: InputDecoration(
                            //     border: InputBorder.none,
                            //     prefixIcon: Icon(Icons.place, color: Colors.white),
                            //     hintText: 'จุดเริ่มต้น',
                            //     hintStyle: TextStyle(
                            //       color: Colors.white70, fontFamily: 'Kanit',
                            //       // fontWeight: FontWeight.w600,
                            //     ),
                            //   ),
                            //   validator: (input) => input.trim().isEmpty
                            //       ? 'กรุณาเลือกจุดเริ่มต้น'
                            //       : null,
                            //   onChanged: (input) => _startplace = input,

                            //   // onSaved: (input) => _email = input,
                            // ),
                            //   child: Column(
                            //     children: <Widget>[
                            //       Text(snapshot.data.documents[authorId]
                            //           ['picprofileUrl'])
                            //     ],
                            //   ),
                            // ),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: purple4,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 10, bottom: 20),
                              child: TextFormField(
                                controller: _startplaceController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon:
                                      Icon(Icons.place, color: Colors.white),
                                  hintText: 'จุดเริ่มต้น',
                                  hintStyle: TextStyle(
                                    color: Colors.white70, fontFamily: 'Kanit',
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
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 10, bottom: 20),
                              child: TextFormField(
                                controller: _endplaceController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon:
                                      Icon(Icons.place, color: Colors.white),
                                  hintText: 'ปลายทาง',
                                  hintStyle: TextStyle(
                                    color: Colors.white70, fontFamily: 'Kanit',
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
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(3),
                                ],
                                controller: _priceController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.attach_money,
                                      color: Colors.white),
                                  hintText: 'ราคา/ที่นั่ง',
                                  hintStyle: TextStyle(
                                    color: Colors.white70, fontFamily: 'Kanit',
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
                                      borderRadius: BorderRadius.circular(10)),
                                  // margin: EdgeInsets.only(
                                  //     left: 15.0, right: 150, top: 10, bottom: 20),

                                  child: TextFormField(
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
                                    validator: (input) => input.trim().isEmpty
                                        ? 'กรุณาระบุวันที่'
                                        : null,
                                    // onSaved: (input) => _password = input,
                                    // obscureText: true,
                                    onChanged: (input) => _date = input,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  height: 50,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      color: purple4,
                                      borderRadius: BorderRadius.circular(10)),
                                  // margin: EdgeInsets.only(
                                  //     left: 15.0, right: 150, top: 10, bottom: 20),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [timeFormatter],
                                    controller: _timeController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.access_time,
                                          color: Colors.white),
                                      hintText: 'เวลา 18:00',
                                      hintStyle: TextStyle(
                                        color: Colors.white70,
                                        fontFamily: 'Kanit',
                                        // fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    validator: (input) => input.trim().isEmpty
                                        ? 'กรุณาระบุระบุเวลา'
                                        : null,
                                    // onSaved: (input) => _password = input,
                                    // obscureText: true,
                                    onChanged: (input) => _time = input,
                                  ),
                                ),
                              ],
                            ),

                            //
///////////////////////////////////////////////////////////////
////// ล่าสุดดดดดดดดดดดดดดดดดดดดดดดดดด
                            // Container(
                            //   margin: EdgeInsets.only(left: 15.0),
                            //   child: DateTimeField(
                            //     textAlign: TextAlign.left,
                            //     // format: DateFormat("yyyy-MM-dd – kk:mm"),

                            //     readOnly: true,
                            //     style: TextStyle(
                            //       color: Colors.blue,
                            //       decoration: TextDecoration.none,
                            //       fontWeight: FontWeight.w600,
                            //     ),

                            //     decoration: InputDecoration(
                            //       icon: Icon(Icons.date_range, color: Colors.black),
                            //       hintText: "เลือกเวลา",
                            //       hintStyle: TextStyle(
                            //         color: Colors.black, fontFamily: 'Kanit',
                            //         // fontWeight: FontWeight.w600,
                            //       ),
                            //       border: InputBorder.none,
                            //     ),
                            //     //  DateTime dateTime = DateFormat.parse("2019-07-19 8:40:23");
                            //     onChanged: (currentValue) {
                            //       //    this._date = currentValue;
                            //       print(currentValue);
                            //     },
                            //     onShowPicker: (context, currentValue) async {
                            //       final date = await showDatePicker(
                            //           context: context,
                            //           firstDate: DateTime(2020),
                            //           initialDate: currentValue ?? DateTime.now(),
                            //           lastDate: DateTime(2021));
                            //       // var formatter = new DateFormat('yyyy-MMM-dd');
                            //       // String formatted = formatter.format(now);
                            //       // print(formatted);
                            //       // this._date = formatted;
                            //       if (date != null) {
                            //         final time = await showTimePicker(
                            //           context: context,
                            //           initialTime: TimeOfDay.fromDateTime(
                            //               currentValue ?? DateTime.now()),
                            //         );
                            //         // String formatDate(DateTime date) =>
                            //         //     new DateFormat("MMMM d").format(date);
                            //         // print(new DateFormat.yMMMd()
                            //         //     .format(new DateTime.now()));
                            //         main() {
                            //           var now = new DateTime.now();
                            //           var formatter = new DateFormat('yyyy-MMM-dd');
                            //           String formatted = formatter.format(now);
                            //           print(formatted); // something like 2019-Jun-20
                            //           this._date = formatted;
                            //         }

                            //         //setState(() => _date = date.toString() );
                            //         //  setState(() => _time = time.toString());
                            //         setState(() {
                            //           main();
                            //           print('day $date');
                            //           print('time $time');
                            //           //print(currentValue);
                            //         });
                            //         return DateTimeField.combine(date, time);
                            //         // print('{$date}{$time}');

                            //       } else {
                            //         return currentValue;
                            //       }
                            //     },
                            //   ),
                            // ),
                            ///////////////////////////////////////////////
                            ///
                            ///
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
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.only(left: 15.0),
                                  child: TextFormField(
                                    controller: _brandcarControlle,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.directions_car,
                                          color: Colors.white),
                                      hintText: 'ยี่ห้อรถ',
                                      hintStyle: TextStyle(
                                        color: Colors.white70,
                                        fontFamily: 'Kanit',
                                        // fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    validator: (input) => input.trim().isEmpty
                                        ? 'กรุณาระบุยี่ห้อรถ'
                                        : null,
                                    // onSaved: (input) => _password = input,
                                    // obscureText: true,
                                    onChanged: (input) => _brandcar = input,
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      color: purple4,
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.only(
                                    left: 15.0,
                                  ),
                                  child: TextFormField(
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
                                    validator: (input) => input.trim().isEmpty
                                        ? 'กรุณาระบุสี'
                                        : null,
                                    // onSaved: (input) => _password = input,
                                    // obscureText: true,
                                    onChanged: (input) => _color = input,
                                  ),
                                ),
                                // Column(
                                //   children: <Widget>[
                                //     Container(
                                //       height: 50,
                                //       width: 140,
                                //       decoration: BoxDecoration(
                                //           color: purple4,
                                //           borderRadius: BorderRadius.circular(10)),
                                //       margin: EdgeInsets.only(
                                //         left: 15.0,
                                //       ),
                                //       child: TextFormField(
                                //         controller: _gencarControlle,
                                //         decoration: InputDecoration(
                                //           border: InputBorder.none,
                                //           prefixIcon: Icon(Icons.directions_car,
                                //               color: Colors.white),
                                //           hintText: 'รุ่นรถ',
                                //           hintStyle: TextStyle(
                                //             color: Colors.white70, fontFamily: 'Kanit',
                                //             // fontWeight: FontWeight.w600,
                                //           ),
                                //         ),

                                //         // onSaved: (input) => _password = input,
                                //         // obscureText: true,
                                //         onChanged: (input) => _gencar = input,
                                //       ),
                                //     ),
                                //     // Text('ไม่บังคับ',style: TextStyle(
                                //     //         color: Colors.white70, fontFamily: 'Kanit',fontSize: 10,
                                //     //         // fontWeight: FontWeight.w600,
                                //     //       ))
                                //   ],
                                // ),
                              ],
                            ),

                            Row(
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 160,
                                  decoration: BoxDecoration(
                                      color: purple4,
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.only(
                                      left: 15.0, top: 30, bottom: 20),
                                  child: TextFormField(
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
                                    validator: (input) => input.trim().isEmpty
                                        ? 'กรุณาระบุเลขทะเบียน'
                                        : null,
                                    // onSaved: (input) => _password = input,
                                    // obscureText: true,
                                    onChanged: (input) => _licensecar = input,
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'เราจะไม่บอกเลขทะเบียน',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontFamily: 'Kanit',
                                          fontSize: 13),
                                    ),
                                    Text(
                                      '   ก่อนจะมีการตอบรับคำร้อง',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontFamily: 'Kanit',
                                          fontSize: 13),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            // Row(
                            //   children: <Widget>[
                            //     Container(
                            //       height: 50,
                            //       width: 160,
                            //       decoration: BoxDecoration(
                            //           color: purple4,
                            //           borderRadius: BorderRadius.circular(10)),
                            //       margin: EdgeInsets.only(
                            //           left: 15.0, top: 10, bottom: 20),
                            //       child: TextFormField(
                            //         controller: _colorControlle,
                            //         decoration: InputDecoration(
                            //           border: InputBorder.none,
                            //           prefixIcon:
                            //               Icon(Icons.color_lens, color: Colors.white),
                            //           hintText: 'สีรถ',
                            //           hintStyle: TextStyle(
                            //               color: Colors.white70, fontFamily: 'Kanit'
                            //               // fontWeight: FontWeight.w600,
                            //               ),
                            //         ),
                            //         validator: (input) =>
                            //             input.trim().isEmpty ? 'กรุณาระบุสี' : null,
                            //         // onSaved: (input) => _password = input,
                            //         // obscureText: true,
                            //         onChanged: (input) => _color = input,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 160,
                                  decoration: BoxDecoration(
                                      color: purple4,
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.only(
                                      top: 10, left: 15, bottom: 20),
                                  child: TextFormField(
                                    controller: _seatController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.event_seat,
                                          color: Colors.white),
                                      hintText: 'ที่นั่งว่าง',
                                      hintStyle: TextStyle(
                                        color: Colors.white70,
                                        fontFamily: 'Kanit',
                                        // fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    validator: (input) => input.trim().isEmpty
                                        ? 'กรุณาระบบที่นั่งว่าง'
                                        : null,
                                    // onSaved: (input) => _password = input,
                                    // obscureText: true,
                                    onChanged: (input) => _seat = input,
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
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.only(
                                      top: 10, left: 15, bottom: 20),
                                  child: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(2),
                                    ],
                                    controller: _seatyouController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(FontAwesomeIcons.male,
                                          color: Colors.white),
                                      hintText: 'ช',
                                      hintStyle: TextStyle(
                                        color: Colors.white70,
                                        fontFamily: 'Kanit',
                                        // fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    validator: (input) => input.trim().isEmpty
                                        ? 'กรุณาระบบที่นั่งว่าง'
                                        : null,
                                    // onSaved: (input) => _password = input,
                                    // obscureText: true,
                                    onChanged: (input) => _seatyou = input,
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: purple4,
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.only(
                                      top: 10, left: 15, bottom: 20),
                                  child: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(2),
                                    ],
                                    controller: _seatyou2Controller,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(FontAwesomeIcons.female,
                                          color: Colors.white),
                                      hintText: 'ญ',
                                      hintStyle: TextStyle(
                                        color: Colors.white70,
                                        fontFamily: 'Kanit',
                                        // fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    validator: (input) => input.trim().isEmpty
                                        ? 'กรุณาระบบที่นั่งว่าง'
                                        : null,
                                    // onSaved: (input) => _password = input,
                                    // obscureText: true,
                                    onChanged: (input) => _seatyou2 = input,
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
                                      '   คนภายในรถของคุณ',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontFamily: 'Kanit',
                                          fontSize: 13),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              height: 80,
                              decoration: BoxDecoration(
                                  color: purple4,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                                top: 10,
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller: _detailsController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon:
                                      Icon(Icons.info, color: Colors.white),
                                  hintText:
                                      'รายละเอียดเพิ่มติม เช่น ขึ้นทางด่วน',
                                  hintStyle: TextStyle(
                                    color: Colors.white70, fontFamily: 'Kanit',
                                    // fontWeight: FontWeight.w600,
                                  ),
                                ),

                                // onSaved: (input) => _password = input,
                                // obscureText: true,
                                onChanged: (input) => _details = input,
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 15))
                            // Column(
                            //   children: <Widget>[
                            //     //  Text('เพศ'),
                            //     ButtonBar(
                            //       alignment: MainAxisAlignment.start,
                            //       children: <Widget>[
                            //         Row(
                            //           children: <Widget>[
                            //             Radio(
                            //               onChanged: (String _gender) {
                            //                 setRadioValue(_gender);
                            //               },
                            //               activeColor: Colors.red,
                            //               value: 'ชาย',
                            //               groupValue: radiovalue,
                            //             ),
                            //             Text(
                            //               'ชาย',
                            //               style: TextStyle(
                            //                 color: Colors.white,
                            //                 fontFamily: 'Kanit',
                            //                 // fontSize: 24,
                            //                 // fontWeight: FontWeight.w600,
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //         // Row(
                            //         //   children: <Widget>[
                            //         //     Radio(
                            //         //       onChanged: (String _picpro) {
                            //         //         setRadioValue(_picpro);
                            //         //       },
                            //         //       activeColor: Colors.purple,
                            //         //       //  value: userDocument['picprofileUrl'].toString(),
                            //         //       // value: getpicpro(),
                            //         //       value: 's',
                            //         //       groupValue: radiovalue,
                            //         //     ),
                            //         //     Text(
                            //         //       'หญิง',
                            //         //       style: TextStyle(
                            //         //         color: Colors.white,
                            //         //         fontFamily: 'Kanit',
                            //         //         // fontSize: 24,
                            //         //         // fontWeight: FontWeight.w600,
                            //         //       ),
                            //         //     ),
                            //         //   ],
                            //         // ),
                            //       ],
                            //     )

                            //     // Container(
                            //     //   margin: EdgeInsets.only(
                            //     //       left: 15.0, right: 15.0, top: 10, bottom: 20),
                            //     //   child: Radio(
                            //     //     value: 1,
                            //     //     groupValue: 1,
                            //     //     activeColor: Colors.purple,
                            //     //     onChanged: (T) {
                            //     //       print('ชาย');

                            //     //     },

                            //     //   ),

                            //     //   // TextFormField(
                            //     //   //   decoration: InputDecoration(labelText: 'Password'),
                            //     //   //   validator: (input) => input.length < 6
                            //     //   //       ? 'Must be at least 6 characters'
                            //     //   //       : null,
                            //     //   //   onSaved: (input) => _password = input,
                            //     //   //   obscureText: true,
                            //     //   // ),
                            //     // ),
                            //   ],
                            // ),
                            //                     Container(
                            //   // child: getpicpro(),
                            //   child: TextFormField(
                            //     // controller: _detailsController,

                            //    initialValue: userDocument['picprofileUrl'].toString(),
                            //     // initialValue: 'https://firebasestorage.googleapis.com/v0/b/thesis96-a41c0.appspot.com/o/images%2Fusers%2FuserProfile_91050f0d-96bb-4fa8-824a-f4c46f550f49.jpg?alt=media&token=7d6c9039-4a56-4bcc-8998-c82b41557ac9',
                            //     // userDocument['picprofileUrl'],
                            //     // onSaved: (input) => _password = input,
                            //     // obscureText: true,
                            //     // value = getpicpro(),
                            //     onChanged: (initialValue) {
                            //       setState(() {
                            //         this._picpro = initialValue;
                            //       });
                            //     }
                            //   ),
                            // ),
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
            );
          }),
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
  getpicurl({Key key}) : super(key: key);

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
                      .collection('Concert')
                      // .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot){
                         if (!snapshot.hasData) {
                      return Text('is somthing worg about database.....');
                      }
                      int length = snapshot.data.documents.length;
                  return (
Text('s')
                  );
                      })
    );
  }
}