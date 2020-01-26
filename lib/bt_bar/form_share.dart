import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  _ShareformState createState() => _ShareformState();
}

class _ShareformState extends State<Shareform> {
  DateTime pickedDate;
  TimeOfDay time;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
  }
  // DateTime selectedDate = DateTime.now();

  // final _formkey = GlobalKey<FormState>();
  var selectedCurrency, selectdatetime;
  final format = DateFormat("HH:mm");
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();

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
  DateTime _date;
  String _time = '';

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
  //final Color bg_orange = Color(0xffF48C67);
  final _formkey = GlobalKey<FormState>();
  // String _username, _email, _password;

  // _submit() {
  //   if (_formkey.currentState.validate()) {
  //     _formkey.currentState.save();
  //     // Logging in the user w/ Firebase
  //     AuthService.signUpUser(context, _username, _email, _password);
  //   }
  // }
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

      Share sharepost = Share(
        concertname: _concertname,
        startplace: _startplace,
        endplace: _endplace,
        price: _price,
        seat: _seat,
        date: _date,
        time: _time,
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
        _date;
        _time = '';
        /////////////
        _brandcar = '';
        _gencar = '';
        _color = '';
        _licensecar = '';

        // _isloading = false;
      });
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
   // final Share newContact = new Share();
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "สร้างการแชร์",
          style: TextStyle(color: purple1),
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
                                          snap.data['NameCon'],
                                          style: TextStyle(
                                              color: orage1, fontSize: 12,fontFamily: 'Kanit',),
                                        ),
                                      ),
                                      value: "${snap.data['NameCon']}",
                                    ),
                                  );
                                }
                                return Row(
                                  children: <Widget>[
                                    //  SizedBox(width: 50.0),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: purple3,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: EdgeInsets.only(
                                          left: 15.0,
                                          right: 15.0,
                                          top: 10,
                                          bottom: 10),
                                      child: DropdownButton(
                                        items: currencyItems,
                                        icon: Icon(Icons.arrow_drop_down,
                                            size: 25.0, color: orage1),
                                        // onChanged:((input)  => _concertname = input),
                                        onChanged: (input) {
                                          this._concertname = input;
                                          print('$input');
                                          // final snackBar = SnackBar(
                                          //   content: Text(
                                          //     'คอนเสิร์ต $input',
                                          //     style: TextStyle(
                                          //         color: Color(0xff11b719)),
                                          //   ),
                                          // );
                                          // Scaffold.of(context)
                                          //     .showSnackBar(snackBar);
                                          setState(() {
                                            // this._concertname = input;
                                            selectedCurrency = input;
                                          });
                                        },
                                        value: selectedCurrency,

                                        isExpanded: false,

                                        hint: Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: new Text(
                                            "เลือกคอนเสิร์ต",
                                            style: TextStyle(color: orage1,fontFamily: 'Kanit',),
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
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: purple3,
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 10, bottom: 20),
                        child: TextFormField(
                          controller: _startplaceController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.place, color: Colors.white),
                            hintText: 'จุดเริ่มต้น',
                             hintStyle: TextStyle(
                                    color: Colors.white,fontFamily: 'Kanit',
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
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: purple3,
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 10, bottom: 20),
                        child: TextFormField(
                          controller: _endplaceController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.place, color: Colors.white),
                            hintText: 'ปลายทาง',
                             hintStyle: TextStyle(
                                    color: Colors.white,fontFamily: 'Kanit',
                                   // fontWeight: FontWeight.w600,
                                  ),
                          ),
                          validator: (input) =>
                              input.trim().isEmpty ? 'กรุณากำหนดปลายทาง' : null,
                          // onSaved: (input) => _password = input,
                          // obscureText: true,
                          onChanged: (input) => _endplace = input,
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(
                            left: 15.0, right: 200.0, top: 10, bottom: 20),
                        decoration: BoxDecoration(
                            color: purple3,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          controller: _priceController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon:
                                Icon(Icons.attach_money, color: Colors.white),
                            hintText: 'ราคา/ที่นั่ง',
                             hintStyle: TextStyle(
                                    color: Colors.white,fontFamily: 'Kanit',
                                   // fontWeight: FontWeight.w600,
                                  ),
                          ),
                          validator: (input) =>
                              input.trim().isEmpty ? 'กรุณากำหนดราคา' : null,
                          onChanged: (input) => _price = input,
                        ),
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: purple3,
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 10, bottom: 20),
                        child: Column(
                          children: <Widget>[
                            // new Text('data seect ${_date.toString()}'),

                            // new RaisedButton(
                            //   child: new Text('select'),
                            //   onPressed: () {
                            //     // createRecord();
                            //      _selectDate(context);
                            //     // onChanged:
                            //     // (context) => _datetime = context;

                            //     // this._datetime=input;

                            //   },
                            // ),
                            // new Text('time seect ${_time.toString()}'),
                            // new RaisedButton(
                            //   child: new Text('select'),
                            //   onPressed: () {
                            //     _selectTime(context);
                            //   },
                            // ),
                            //////////////////////////// ไม่เอา
                            //            Text(_pickedDate == null ? 'Nothing has been picked yet' : _pickedDate.toString()),
                            //            RaisedButton(
                            //              child: Text('Pick a date'),
                            //              onPressed: (){
                            //                showDatePicker(
                            //                  context: context,
                            //                 initialDate: _pickedDate == null ? DateTime.now() : _pickedDate,
                            // firstDate: DateTime(2001),
                            // lastDate: DateTime(2021)
                            //                ).then((date){
                            //                  setState(() {
                            //                    _pickedDate = date;
                            //                  });

                            //                });
                            //              },

                            //            ),
                            // //////////////////////////// ไม่เอา
                            // TextFormField(

                            //   // title: Text(
                            //   //   'วันเวลา: ${pickedDate.year}-${pickedDate.month}-${pickedDate.day}  -  ${time.hour}:${time.minute}',
                            //   // ),
                            //   // trailing:
                            //   //     Icon(Icons.date_range, color: Colors.white),
                            //   readOnly: true,
                            //   decoration: InputDecoration(
                            //     border: InputBorder.none,
                            //     prefixIcon: Icon(Icons.date_range, color:Colors.white),
                            //     hintText: 'วันเวลา',
                            //   ),
                            //   onTap: _pickDatetime,
                            //   keyboardType: TextInputType.datetime,

                            // ),
                            //     new Row(children: <Widget>[
                            //       new Expanded(
                            //           child: new TextFormField(
                            //         decoration: new InputDecoration(
                            //           icon: const Icon(Icons.calendar_today),
                            //           hintText: 'Enter your date of birth',
                            //           labelText: 'Dob',
                            //         ),
                            //         controller: _controller,
                            //         keyboardType: TextInputType.datetime,
                            //       //  onChanged: (datetime) {
                            //       //    setState(() {
                            //       //      this._time = datetime;
                            //       //      print(datetime);
                            //       //    });
                            //       //  }
                            //       onSaved: (val) => _date = convertToDate(val),
                            //   )
                            //   ),

                            //   new IconButton(
                            //     icon: new Icon(Icons.more_horiz),
                            //     tooltip: 'Choose date',

                            //     onPressed: (() {
                            //       _chooseDate(context, _controller.text);
                            //     }),

                            //   )
                            // ]),
                            // GestureDetector(
                            //   onTap: () {
                            //     _pickDatetime(); // Call Function that has showDatePicker()
                            //   },

                            //   child: AbsorbPointer(
                            //       child: TextFormField(
                            //           // controller: _datetimeController,
                            //           decoration: InputDecoration(
                            //             border: InputBorder.none,
                            //             prefixIcon: Icon(Icons.date_range,
                            //                 color: Colors.white),
                            //             // labelText:
                            //             //     'วันเวลา: ${pickedDate.year}-${pickedDate.month}-${pickedDate.day}  -  ${time.hour}:${time.minute}',
                            //             hintText: 'ระบุวันเวลา',
                            //           ),

                            //           onSaved: (String val) => _datetime = val,

                            //           ////////////////////////////////////////////////////////////////////////
                            //           // validator: (input) => input.trim().isEmpty
                            //           //     ? 'กรุณากำหนดวันและเวลา'
                            //           //     : null,
                            //           // onSaved: (input) => _password = input,
                            //           // obscureText: true,

                            //           //  onChanged: (input) => _datetime = input,
                            //           )),
                            // ),
                            // GestureDetector(
                            //   onTap: () => _selectDate(context),
                            //   child: AbsorbPointer(
                            //     child: TextFormField(
                            //         controller: _date,
                            //         keyboardType: TextInputType.datetime,
                            //         decoration: InputDecoration(
                            //           hintText: 'Date of Birth',
                            //           prefixIcon: Icon(
                            //             Icons.dialpad,
                            //             color: Colors.black,
                            //           ),
                            //         ),
                            //         validator: (selectedDate) =>
                            //             selectedDate.isEmpty
                            //                 ? 'กรุณาระบุวันเวลา'
                            //                 : null,
                            //         //  onChanged: (input) {
                            //         //    this._datetime =input;
                            //         //    print('change $input');
                            //         //   //  setState(() {
                            //         //   //    selectdatetime = input;
                            //         //   //  });
                            //         //  }
                            //          onChanged: (context) {
                            //            print('data to $context');
                            //          }
                            //         // onChanged: (String picked) {
                            //         //   setState(
                            //         //       () => picked = 'Change: ${picked}');
                            //         // }
                            //         ),
                            //   ),
                            // ),
                            // Text('Basic date & time field (${format.pattern})'),
///////////////////////////////////////////////////////////////
                            Container(
                               margin: EdgeInsets.only(
                            left: 15.0),
                              child: DateTimeField(
                                textAlign: TextAlign.left,
                                format: DateFormat("yyyy-MM-dd – kk:mm"),
                                readOnly: true,
                                 style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w600,
                                ),
                                
                                decoration: InputDecoration(
                                  
                                  icon: Icon(Icons.date_range,color: Colors.white),
                                  hintText: "เลือกเวลา",
                                  hintStyle: TextStyle(
                                    color: Colors.white,fontFamily: 'Kanit',
                                   // fontWeight: FontWeight.w600,
                                  ),
                                  border: InputBorder.none,
                                ),
                                //  DateTime dateTime = DateFormat.parse("2019-07-19 8:40:23");
                                onChanged: (currentValue) {
                                  this._date = currentValue;
                                  print(currentValue);
                                },
                                onShowPicker: (context, currentValue) async {
                                  final date = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(2020),
                                      initialDate: currentValue ?? DateTime.now(),
                                      lastDate: DateTime(2021));

                                  if (date != null) {
                                    final time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                          currentValue ?? DateTime.now()),
                                    );
                                    setState(() {});
                                    //setState(() => _date = date.toString() );
                                    //  setState(() => _time = time.toString());
                                    setState(() {
                                      print('day $date');
                                      print('time $time');
                                      //print(currentValue);
                                      //this._date = date;
                                    });
                                    return DateTimeField.combine(date, time);
                                    // print('{$date}{$time}');

                                  } else {
                                    return currentValue;
                                  }
                                },
                              ),
                            ),
                            ///////////////////////////////////////////////
                            ///
                            ///
                            // Container(
                            //   width: 200,
                            //   child: DateTimeField(
                            //     controller: _startTimeController,
                            //     decoration: InputDecoration(
                            //         enabledBorder: UnderlineInputBorder(
                            //           borderSide: BorderSide(color: orage1),
                            //         ),
                            //         focusedBorder: UnderlineInputBorder(
                            //           borderSide: BorderSide(color: purple1),
                            //         )),
                            //         style: TextStyle(color: Colors.white),
                            //         format: format,
                            //         onShowPicker: (context, currentValue) async{
                            //           final time = await showTimePicker(
                            //             context: context,
                            //             initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),

                            //           );
                            //           //setState(() => _date = time.toString() );
                            //           //   setState((currentValue)
                            //           // {
                            //           //    this._date = a;

                            //           //  });
                            //           return DateTimeField.convert(time);

                            //         },
                            //   ),
                            //  ),

                            // DateTimeField(
                            //   textAlign: TextAlign.center,
                            //   format: DateFormat("yyyy-MM-dd – kk:mm"),
                            //   readOnly: true,
                            //   style: TextStyle(
                            //     color: Colors.white,
                            //     decoration: TextDecoration.none,
                            //     fontWeight: FontWeight.w600,
                            //   ),
                            //   decoration: InputDecoration(
                            //     hintText: "เลือกเวลา",
                            //     hintStyle: TextStyle(
                            //       color: Colors.white,
                            //       fontWeight: FontWeight.w600,
                            //     ),
                            //     border: InputBorder.none,
                            //   ),
                            //   onShowPicker: (context, currentValue) {
                            //     return showDatePicker(

                            //         context: context,
                            //         firstDate: DateTime(2020, 1, 1),
                            //         initialDate:
                            //         currentValue ?? DateTime.now(),
                            //         lastDate: DateTime(2021, 12, 30));

                            //   },
                            //   onChanged: (DateTime date){
                            //     setState(() {
                            //       print(context);
                            //       print(date);
                            //      // print(currentValue);
                            //      print(DateTime);
                            //    // setState(() => _date = date.toString() );
                            //     });
                            //   } ,
                            //  // onChanged: (context) => _date = context,
                            // ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black38,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: purple3,
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.only(
                            left: 15.0, right: 150, top: 10, bottom: 20),
                        child: TextFormField(
                          controller: _brandcarControlle,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon:
                                Icon(Icons.directions_car, color: Colors.white),
                            hintText: 'ยี่ห้อรถ',
                             hintStyle: TextStyle(
                                    color: Colors.white,fontFamily: 'Kanit',
                                   // fontWeight: FontWeight.w600,
                                  ),
                          ),
                          validator: (input) =>
                              input.trim().isEmpty ? 'กรุณาระบุยี่ห้อรถ' : null,
                          // onSaved: (input) => _password = input,
                          // obscureText: true,
                          onChanged: (input) => _gencar = input,
                        ),
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: purple3,
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.only(
                            left: 15.0, right: 150, top: 10, bottom: 20),
                        child: TextFormField(
                          controller: _gencarControlle,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon:
                                Icon(Icons.directions_car, color: Colors.white),
                            hintText: 'รุ่นรถ',
                             hintStyle: TextStyle(
                                    color: Colors.white,fontFamily: 'Kanit',
                                   // fontWeight: FontWeight.w600,
                                  ),
                          ),
                          validator: (input) =>
                              input.trim().isEmpty ? 'กรุณาระบุรุ่นรถ' : null,
                          // onSaved: (input) => _password = input,
                          // obscureText: true,
                          onChanged: (input) => _gencar = input,
                        ),
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: purple3,
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.only(
                            left: 15.0, right: 150, top: 10, bottom: 20),
                        child: TextFormField(
                          controller: _colorControlle,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon:
                                Icon(Icons.color_lens, color: Colors.white),
                            hintText: 'สีรถ',
                             hintStyle: TextStyle(
                                    color: Colors.white,fontFamily: 'Kanit'
                                   // fontWeight: FontWeight.w600,
                                  ),
                          ),
                          validator: (input) =>
                              input.trim().isEmpty ? 'กรุณาระบุสี' : null,
                          // onSaved: (input) => _password = input,
                          // obscureText: true,
                          onChanged: (input) => _color = input,
                        ),
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: purple3,
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.only(
                            left: 15.0, right: 150.0, top: 10, bottom: 20),
                        child: TextFormField(
                          controller: _licensecarControlle,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.format_list_numbered,
                                color: Colors.white),
                            hintText: 'เลขะเบียน',
                             hintStyle: TextStyle(
                                    color: Colors.white,fontFamily: 'Kanit',
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
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: purple3,
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.only(
                            left: 15.0, right: 150.0, top: 10, bottom: 20),
                        child: TextFormField(
                          controller: _seatController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon:
                                Icon(Icons.event_seat, color: Colors.white),
                            hintText: 'ที่นั่งว่าง',
                             hintStyle: TextStyle(
                                    color: Colors.white,fontFamily: 'Kanit',
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
                    ])),
              ),
              SizedBox(height: 20.0),
              Container(
                margin: EdgeInsets.only(bottom: 40),
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
                          color: Colors.white,fontFamily: 'Kanit',
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

  _pickDatetime() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 2),
      initialDate: pickedDate,
    );
    TimeOfDay t = await showTimePicker(context: context, initialTime: time);
    if (date != null && t != null)
      setState(() {
        pickedDate = date;
        time = t;
        print(date);
        print(t);
        print(time);
      });
  }
}
