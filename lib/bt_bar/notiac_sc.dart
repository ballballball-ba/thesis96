// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flushbar/flushbar.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:mythesis96/firebase/constance.dart';
// import 'package:mythesis96/m/user_data.dart';
// import 'package:provider/provider.dart';

// class Notiac extends StatefulWidget {
//   final String userId;
//   const Notiac({Key key, this.userId}) : super(key: key);

//   @override
//   _NotiacState createState() => _NotiacState();
// }

// class _NotiacState extends State<Notiac> {
//   final Color purple1 = Color(0xff5A45A5);
//   final Color purple2 = Color(0xff2A1D59);
//   final Color orange1 = Color(0xffF2551D);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomPadding: false,
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         // leading: new IconButton(
//         //  // icon: new Icon(Icons.arrow_back_ios, color: purple2),
//         //   onPressed: () => Navigator.of(context).pop(),
//         // ),
//         title: Text("แจ้งเตือน",
//             style: TextStyle(
//               fontFamily: 'Kanit',
//               fontWeight: FontWeight.w600,
//               color: purple2,
//             )),
//         centerTitle: true,
//       ),
//       body: ListPage1(),
//     );
//   }
// }

// class ListPage1 extends StatefulWidget {
//   final String userId;
//   const ListPage1({Key key, this.userId}) : super(key: key);
//   @override
//   _ListPage1State createState() => _ListPage1State();
// }

// class _ListPage1State extends State<ListPage1> {
//   Future _data;

//   Future getPosts() async {
//     var firestore = Firestore.instance;

//     QuerySnapshot qn = await firestore
//         .collection('ShareRequest')
//         // .where('AuthorId',
//         //     isEqualTo: 'FXqc0t1icbcTDGTgPs5maJkUiOn1')
//         // .where('AuthorId',
//         //     isEqualTo: Provider.of<Userdata>(context).currentUserID.toString())
//         .getDocuments();
//     return qn.documents;
//   }

//   // navigatorToDetail(DocumentSnapshot post) {
//   //   Navigator.push(
//   //       context,
//   //       MaterialPageRoute(
//   //           builder: (context) => DetailPage(
//   //                 post: post,
//   //               )));
//   // }

//   @override
//   void initState() {
//     super.initState();

//     _data = getPosts();
//   }

//   final Color purple1 = Color(0xff5A45A5);
//   final Color purple2 = Color(0xff2A1D59);
//   final Color purple3 = Color(0xffBDAEF2);
//   final Color orage1 = Color(0xffF2551D);
//   final Color purple4 = Color(0xffA99CD9);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: FutureBuilder(
//           future: shareRequestRef.document(widget.userId).get(),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             if (Provider.of<Userdata>(context).currentUserID ==
//                     'A2jLoXTYDMRTyJTaTfKWhHQfRAS2' ||
//                 Provider.of<Userdata>(context).currentUserID ==
//                     'FXqc0t1icbcTDGTgPs5maJkUiOn1') {
//               return FutureBuilder(
//                 future: _data,
//                 builder: (_, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(
//                       child: Text('กำลังโหลดข้อมูล'),
//                     );
//                   } else if (snapshot.hasData) {
//                     return ListView.separated(
//                         separatorBuilder: (context, index) => Divider(
//                               color: Colors.black54,
//                             ),
//                         itemCount: snapshot.data.length,
//                         itemBuilder: (_, index) {
//                           return GestureDetector(
//                             onTap: () => {print('111111')},
//                             child: Container(
//                               margin: EdgeInsets.all(10),
//                               width: 400,
//                               height: 65,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.white,
//                               ),
//                               child: Container(
//                                 //  margin: EdgeInsets.all(6),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Text('แจ้งเตือน',
//                                         style: TextStyle(
//                                             fontFamily: 'Kanit',
//                                             fontSize: 14,
//                                             color: Colors.black38)),
//                                     Text(
//                                         snapshot
//                                             .data[index].data['Concertname'],
//                                         style: TextStyle(
//                                             fontFamily: 'Kanit',
//                                             fontSize: 16,
//                                             color: Color(0xff5A45A5))),
//                                     Text(
//                                         'โปรดตรวจสอบรายละเอียดในหน้า "การแชร์ของฉัน"',
//                                         style: TextStyle(
//                                             fontFamily: 'Kanit',
//                                             fontSize: 12,
//                                             color: Colors.black38)),
//                                     //  Divider(
//                                     //   color: Colors.black,
//                                     // ),
//                                     // Text(
//                                     //     'โปรดตรวจสอบรายละเอียดในหน้า "การแชร์ของฉัน"',
//                                     //     style: TextStyle(
//                                     //         fontFamily: 'Kanit',
//                                     //         fontSize: 12,
//                                     //         color: Colors.black38)),
//                                     // Text(snapshot.data[index].data['timestamp'].toString(),
//                                     //     style: TextStyle(
//                                     //         fontFamily: 'Kanit',
//                                     //         color: Colors.black54)),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                           // ListTile(
//                           //   title: Text(snapshot.data[index].data['Topic']),
//                           //   onTap: () => navigatorToDetail(snapshot.data[index]),
//                           // );
//                         });
//                   } else {
//                     return Container(
//                       child: FutureBuilder(
//                           future: shareconfirmRef.document(widget.userId).get(),
//                           builder:
//                               (BuildContext context, AsyncSnapshot snapshot) {
//                             if (Provider.of<Userdata>(context).currentUserID ==
//                                     'A2jLoXTYDMRTyJTaTfKWhHQfRAS2' ||
//                                 Provider.of<Userdata>(context).currentUserID ==
//                                     'FXqc0t1icbcTDGTgPs5maJkUiOn1') {
//                               return FutureBuilder(
//                                 future: _data,
//                                 builder: (_, snapshot) {
//                                   if (snapshot.connectionState ==
//                                       ConnectionState.waiting) {
//                                     return Center(
//                                       child: Text('กำลังโหลดข้อมูล'),
//                                     );
//                                   } else if (snapshot.hasData) {
//                                     return ListView.separated(
//                                         separatorBuilder: (context, index) =>
//                                             Divider(
//                                               color: Colors.black54,
//                                             ),
//                                         itemCount: snapshot.data.length,
//                                         itemBuilder: (_, index) {
//                                           return GestureDetector(
//                                             onTap: () => {print('111111')},
//                                             child: Container(
//                                               margin: EdgeInsets.all(10),
//                                               width: 400,
//                                               height: 65,
//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                                 color: Colors.white,
//                                               ),
//                                               child: Container(
//                                                 //  margin: EdgeInsets.all(6),
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: <Widget>[
//                                                     Text('แจ้งเตือน',
//                                                         style: TextStyle(
//                                                             fontFamily: 'Kanit',
//                                                             fontSize: 14,
//                                                             color: Colors
//                                                                 .black38)),
//                                                     Text(
//                                                         snapshot.data[index]
//                                                                 .data[
//                                                             'Concertname'],
//                                                         style: TextStyle(
//                                                             fontFamily: 'Kanit',
//                                                             fontSize: 16,
//                                                             color: Color(
//                                                                 0xff5A45A5))),
//                                                     Text(
//                                                         'กำลังดำเนินการ',
//                                                         style: TextStyle(
//                                                             fontFamily: 'Kanit',
//                                                             fontSize: 12,
//                                                             color: Colors
//                                                                 .black38)),
//                                                     //  Divider(
//                                                     //   color: Colors.black,
//                                                     // ),
//                                                     // Text(
//                                                     //     'โปรดตรวจสอบรายละเอียดในหน้า "การแชร์ของฉัน"',
//                                                     //     style: TextStyle(
//                                                     //         fontFamily: 'Kanit',
//                                                     //         fontSize: 12,
//                                                     //         color: Colors.black38)),
//                                                     // Text(snapshot.data[index].data['timestamp'].toString(),
//                                                     //     style: TextStyle(
//                                                     //         fontFamily: 'Kanit',
//                                                     //         color: Colors.black54)),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           );
//                                           // ListTile(
//                                           //   title: Text(snapshot.data[index].data['Topic']),
//                                           //   onTap: () => navigatorToDetail(snapshot.data[index]),
//                                           // );
//                                         });
//                                   } else {
//                                     return Center(
//                                       child: Text(
//                                         'ไม่มีการแจ้งเตือน',
//                                         style: TextStyle(
//                                           fontFamily: 'Kanit',
//                                           color: purple2,
//                                         ),
//                                       ),
//                                     );
//                                   }
//                                 },
//                               );
//                             } else {
//                               return Center(
//                                 child: Text(
//                                   'ไม่มีการแจ้งเตือน',
//                                   style: TextStyle(
//                                     fontFamily: 'Kanit',
//                                     color: purple2,
//                                   ),
//                                 ),
//                               );
//                             }
//                           }),
//                     );
//                   }
//                 },
//               );
//             } else {
//               return Center(
//                 child: Text(
//                   'ไม่มีการแจ้งเตือน',
//                   style: TextStyle(
//                     fontFamily: 'Kanit',
//                     color: purple2,
//                   ),
//                 ),
//               );
//             }
//           }),
//     );

//   }
// }
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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mythesis96/bt_bar/detail/detailreqeustsuccess.dart';
import 'package:mythesis96/bt_bar/notifier_share%20request.dart';
import 'package:mythesis96/bt_bar/payment.dart';
import 'package:mythesis96/m/share_posts.dart';
import 'package:provider/provider.dart';

class Notiac extends StatefulWidget {
  final DocumentSnapshot post;
  final String userId;
  Notiac({Key key, this.userId, this.post}) : super(key: key);

  @override
  _NotiacState createState() => _NotiacState();
}

class _NotiacState extends State<Notiac> {
  @override
  Future<bool> doesNameAlreadyExist(String name) async {
    final QuerySnapshot result = await Firestore.instance
        .collection('Notishare')
        .where('AuthorId', isEqualTo: 'A2jLoXTYDMRTyJTaTfKWhHQfRAS2')
        .limit(1)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    return documents.length == 1;
  }
  Future<bool> doesNameAlreadyExist2(String name) async {
    final QuerySnapshot result = await Firestore.instance
        .collection('Notishare')
        .where('AuthorId', isEqualTo: 'FXqc0t1icbcTDGTgPs5maJkUiOn1')
        .limit(1)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    return documents.length == 1;
  }


  //  future: doesNameAlreadyExist('1'),
  //       builder: (context, AsyncSnapshot<bool> result) {
  //         if (!result.hasData)
  //           return Container();

  @override
  final Color purple1 = Color(0xff5A45A5);
  final Color purple2 = Color(0xff2A1D59);
  final Color orange1 = Color(0xffF2551D);

  Widget build(BuildContext context) {
    ShareNotifierrequest2 shareNotifier =
        Provider.of<ShareNotifierrequest2>(context, listen: false);

    // Notisharedetails shareNotifier4 = Provider.of<Notisharedetails>(context);

    // ShareNotifierrequest shareNotifier2 =
    //     Provider.of<ShareNotifierrequest>(context, listen: false);

    return FutureBuilder(
        future: shareRequestRef.document(widget.userId).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (Provider.of<Userdata>(context).currentUserID ==
              'FXqc0t1icbcTDGTgPs5maJkUiOn1') {
            return FutureBuilder(
                future: doesNameAlreadyExist('1'),
                builder: (context, AsyncSnapshot<bool> result) {
                  if (!result.hasData)
                    return Scaffold(
                      resizeToAvoidBottomPadding: false,
                      backgroundColor: Colors.white,
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        // leading: new IconButton(
                        //  // icon: new Icon(Icons.arrow_back_ios, color: purple2),
                        //   onPressed: () => Navigator.of(context).pop(),
                        // ),
                        title: Text("แจ้งเตือน",
                            style: TextStyle(
                              fontFamily: 'Kanit',
                              fontWeight: FontWeight.w600,
                              color: purple2,
                            )),
                        centerTitle: true,
                      ),
                      body: Center(
                        child: Text('ไม่มีการแจ้งเตือน',
                            style: TextStyle(
                              fontFamily: 'Kanit',
                              color: purple2,
                            )),
                      ),
                    );
                  if (result.data)
                    return Scaffold(
                      resizeToAvoidBottomPadding: false,
                      backgroundColor: Colors.white,
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        // leading: new IconButton(
                        //  // icon: new Icon(Icons.arrow_back_ios, color: purple2),
                        //   onPressed: () => Navigator.of(context).pop(),
                        // ),
                        title: Text("แจ้งเตือน",
                            style: TextStyle(
                              fontFamily: 'Kanit',
                              fontWeight: FontWeight.w600,
                              color: purple2,
                            )),
                        centerTitle: true,
                      ),
                      body: ListPage1(),
                    );
                  return Scaffold(
                    resizeToAvoidBottomPadding: false,
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      // leading: new IconButton(
                      //  // icon: new Icon(Icons.arrow_back_ios, color: purple2),
                      //   onPressed: () => Navigator.of(context).pop(),
                      // ),
                      title: Text("แจ้งเตือน",
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontWeight: FontWeight.w600,
                            color: purple2,
                          )),
                      centerTitle: true,
                    ),
                    body: Center(
                      child: Text('ไม่มีการแจ้งเตือน',
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            color: purple2,
                          )),
                    ),
                  );
                });
                //*********************คนชับ***************************** */
          } else if (Provider.of<Userdata>(context).currentUserID ==
              'A2jLoXTYDMRTyJTaTfKWhHQfRAS2') {
            return FutureBuilder(
                future: doesNameAlreadyExist2('1'),
                builder: (context, AsyncSnapshot<bool> result) {
                  if (!result.hasData)
                    return Scaffold(
                      resizeToAvoidBottomPadding: false,
                      backgroundColor: Colors.white,
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        // leading: new IconButton(
                        //  // icon: new Icon(Icons.arrow_back_ios, color: purple2),
                        //   onPressed: () => Navigator.of(context).pop(),
                        // ),
                        title: Text("แจ้งเตือน",
                            style: TextStyle(
                              fontFamily: 'Kanit',
                              fontWeight: FontWeight.w600,
                              color: purple2,
                            )),
                        centerTitle: true,
                      ),
                      body: Center(
                        child: Text('ไม่มีการแจ้งเตือน',
                            style: TextStyle(
                              fontFamily: 'Kanit',
                              color: purple2,
                            )),
                      ),
                    );
                  if (result.data)
                    return Scaffold(
                      resizeToAvoidBottomPadding: false,
                      backgroundColor: Colors.white,
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        // leading: new IconButton(
                        //  // icon: new Icon(Icons.arrow_back_ios, color: purple2),
                        //   onPressed: () => Navigator.of(context).pop(),
                        // ),
                        title: Text("แจ้งเตือน",
                            style: TextStyle(
                              fontFamily: 'Kanit',
                              fontWeight: FontWeight.w600,
                              color: purple2,
                            )),
                        centerTitle: true,
                      ),
                      body: ListPage2pay(),
                    );
                  return Scaffold(
                    resizeToAvoidBottomPadding: false,
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      // leading: new IconButton(
                      //  // icon: new Icon(Icons.arrow_back_ios, color: purple2),
                      //   onPressed: () => Navigator.of(context).pop(),
                      // ),
                      title: Text("แจ้งเตือน",
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontWeight: FontWeight.w600,
                            color: purple2,
                          )),
                      centerTitle: true,
                    ),
                    body: Center(
                      child: Text('ไม่มีการแจ้งเตือน',
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            color: purple2,
                          )),
                    ),
                  );
                });
          } else {
            return Scaffold(
              resizeToAvoidBottomPadding: false,
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                // leading: new IconButton(
                //  // icon: new Icon(Icons.arrow_back_ios, color: purple2),
                //   onPressed: () => Navigator.of(context).pop(),
                // ),
                title: Text("แจ้งเตือน",
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontWeight: FontWeight.w600,
                      color: purple2,
                    )),
                centerTitle: true,
              ),
              body: Center(
                child: Text('ไม่มีการแจ้งเตือน',
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      color: purple2,
                    )),
              ),
            );
          }
        });
  }
}

class ListPage1 extends StatefulWidget {
  @override
  _ListPage1State createState() => _ListPage1State();
}

class _ListPage1State extends State<ListPage1> {
  Future _data;

  Future getPosts() async {
    var firestore = Firestore.instance;

    QuerySnapshot qn = await firestore
        .collection('Notishare')
        // .where('Topic', isEqualTo: 'แจ้งเหตุฉุกเฉิน')
        .getDocuments();
    return qn.documents;
  }

  navigatorToDetail(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(
                  post: post,
                )));
  }

  @override
  void initState() {
    super.initState();

    _data = getPosts();
  }

  final Color purple1 = Color(0xff5A45A5);
  final Color purple2 = Color(0xff2A1D59);
  final Color purple3 = Color(0xffBDAEF2);
  final Color orage1 = Color(0xffF2551D);
  final Color purple4 = Color(0xffA99CD9);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: _data,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text('กำลังโหลดข้อมูล'),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                        onTap: () => navigatorToDetail(snapshot.data[index]),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          width: 400,
                          height: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Container(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //  Text('User',
                              //     style: TextStyle(
                              //         fontFamily: 'Kanit',
                              //         fontSize: 14,
                              //         color: orage1)),
                              Text('แจ้งเตือน',
                                  style: TextStyle(
                                      fontFamily: 'Kanit',
                                      fontSize: 14,
                                      color: Colors.black38)),
                              Text('คนขับตอบรับคำขอของคุณ (กรุณาชำระ)',
                                  style: TextStyle(
                                      fontFamily: 'Kanit',
                                      fontSize: 16,
                                      color: Color(0xff5A45A5))),
                              Text(
                                  'ชำระเงินเพื่อแสดงรายละเอียดเพิ่มเติมสำหรับการเดินทาง',
                                  style: TextStyle(
                                      fontFamily: 'Kanit',
                                      fontSize: 12,
                                      color: Colors.black38)),
                            ],
                          )),
                        ));
                    // ListTile(
                    //   title: Text(snapshot.data[index].data['Topic']),
                    //   onTap: () => navigatorToDetail(snapshot.data[index]),
                    // );
                  });
            } else {
              return Center(
                child: Text(
                  'ไม่มีเหตุฉุกเฉิน',
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    color: purple2,
                  ),
                ),
              );
            }
          }),
    );
  }
}
//************************list 22222222222222222222222222 */
class ListPage2pay extends StatefulWidget {
  @override
  _ListPage2payState createState() => _ListPage2payState();
}

class _ListPage2payState extends State<ListPage2pay> {
  Future _data;

  Future getPosts() async {
    var firestore = Firestore.instance;

    QuerySnapshot qn = await firestore
        .collection('Notishare')
        // .where('Topic', isEqualTo: 'แจ้งเหตุฉุกเฉิน')
        .getDocuments();
    return qn.documents;
  }

  navigatorToDetail(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Payment(
                  post: post,
                )));
  }

  @override
  void initState() {
    super.initState();

    _data = getPosts();
  }

  final Color purple1 = Color(0xff5A45A5);
  final Color purple2 = Color(0xff2A1D59);
  final Color purple3 = Color(0xffBDAEF2);
  final Color orage1 = Color(0xffF2551D);
  final Color purple4 = Color(0xffA99CD9);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: _data,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text('กำลังโหลดข้อมูล'),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                        onTap: () => navigatorToDetail(snapshot.data[index]),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          width: 400,
                          height: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Container(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //  Text('User',
                              //     style: TextStyle(
                              //         fontFamily: 'Kanit',
                              //         fontSize: 14,
                              //         color: orage1)),
                              Text('แจ้งเตือน',
                                  style: TextStyle(
                                      fontFamily: 'Kanit',
                                      fontSize: 14,
                                      color: Colors.black38)),
                              Text('เสร็จสิ้นการแชร์ (กรุณากรอกขอมูลเพื่อรับเงิน)',
                                  style: TextStyle(
                                      fontFamily: 'Kanit',
                                      fontSize: 16,
                                      color: Color(0xff5A45A5))),
                              Text(
                                  'กรุณากรอกขอมูลเพื่อรับเงินสำหรับการแชร์ของคุณ',
                                  style: TextStyle(
                                      fontFamily: 'Kanit',
                                      fontSize: 12,
                                      color: Colors.black38)),
                            ],
                          )),
                        ));
                    // ListTile(
                    //   title: Text(snapshot.data[index].data['Topic']),
                    //   onTap: () => navigatorToDetail(snapshot.data[index]),
                    // );
                  });
            } else {
              return Center(
                child: Text(
                  'ไม่มีเหตุฉุกเฉิน',
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    color: purple2,
                  ),
                ),
              );
            }
          }),
    );
  }
}
//**************************************************************** */
class DetailPage extends StatefulWidget {
  final DocumentSnapshot post;
  final String userpay;
  DetailPage({Key key, this.userpay, this.post}) : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState();
}

var maskFormatter1 = new MaskTextInputFormatter(
    mask: '#### #### #### ####', filter: {"#": RegExp(r'[0-9]')});
var maskFormatter2 =
    new MaskTextInputFormatter(mask: '##/##', filter: {"#": RegExp(r'[0-9]')});
var maskFormatter3 =
    new MaskTextInputFormatter(mask: '####', filter: {"#": RegExp(r'[0-9]')});

class _DetailPageState extends State<DetailPage> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController _cardnumController = TextEditingController();
  TextEditingController _cardexpTimeController = TextEditingController();
  TextEditingController _cardcvvTimeController = TextEditingController();
  TextEditingController _cardnameTimeController = TextEditingController();

  final Color purple1 = Color(0xff5A45A5);
  final Color purple2 = Color(0xff2A1D59);
  final Color purple3 = Color(0xffBDAEF2);
  final Color orage1 = Color(0xffF2551D);
  final Color purple4 = Color(0xffA99CD9);
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

    String _dropDownValue;
    String dropdownValue = 'One';
    var currentSelectedValue;
    const deviceTypes = ["Mac", "Windows", "Mobile"];
    String _bank = '';
    String _topic = '';
    var myInt = int.parse(widget.post.data['Price']);
    var myInt2 = int.parse(widget.post.data['Seatreqmale']);
    var myInt3 = int.parse(widget.post.data['Seatreqfemale']);
    var seat = myInt2 + myInt3;
    var allint = myInt * (myInt2 + myInt3);
    var myresult = allint * 25 / 100;

    String _money = allint.toString();
    String _shareid = widget.post.documentID;
    _submit() async {
      if (_formkey.currentState.validate()) {
        _formkey.currentState.save();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return Home();
          // return Payment();
        }));
_deleteData();
        // _showDialog();
        // _showapipay();
        FutureBuilder(
            future: ApiService.paymentApi(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Pay msg = snapshot.data;
                print("snap = " + msg.message);
                // return Flushbar()..show(context);
              } else {
                return CircularProgressIndicator();
              }
            });
       
        var now = new DateTime.now();

        PaymentM payment = PaymentM(
          cardnum: _cardnum,
          cardexp: '',
          cardcvv: '',
          cardname: _cardname,
          allmoney: _money,
          shareid: _shareid,
          
          status: 'ชำระเงินเรียบร้อย',
          // endplace: _endplace,
          // price: _price,
          // seat: _seat,
          // date: _date,
          // time: _time,
          timestamp: intl.DateFormat("dd-MM-yyyy hh:mm").format(now),

          authorId: Provider.of<Userdata>(context).currentUserID,
        );

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
          authorshare: _authorshare,

          timestamp: intl.DateFormat("dd-MM-yyyy hh:mm:ss").format(now),
          authorId: Provider.of<Userdata>(context).currentUserID,
        );
        DatabaseSer.createShareconfirm(shareconfirm);
        Sharereq sharereq = Sharereq();
        DatabaseSer.createPay(payment, sharereq);
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
                    "ยืนยันการชำระเงิน",
                    style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 18,
                        color: purple2,
                        fontWeight: FontWeight.w600),
                  ),
                  content: Column(
                    children: <Widget>[
                      Text(
                        "ยืนยันการชำระเงิน",
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
                      // onPressed: () => {print('s')},
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
_paydilog2() async {
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
                      // onPressed: () => {print('s')},
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
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: DropdownButton(
                        underline: SizedBox(),
                        isExpanded: true,
                        iconSize: 30.0,
                        style: TextStyle(color: purple2),
                        items: [
                          'กรุงไทย - KTB',
                          'ไทยพาณิชย์ - SCB',
                          'กสิกรไทย - KBANK',
                          'กรุงเทพ - BBL',
                          'กรุงศรีอยุธยา - BAY',
                          'ออมสิน - GSB',
                          'ทหารไทย - TMB',
                          'ซีไอเอ็มบี - CIMBT',
                          'ธนชาต - TBANK',
                          'ซิตี้แบงค์ - CITI',
                          'เกียรตินาคิน - KK',
                          'สแตนดาร์ดฯ - SCBT',
                          'ยูโอบี - UOBT',
                          'ทิสโก้ - TISCO',
                          'แลนด์ แอนด์ เฮ้าส์ - LHBANK',
                          'ธ.ก.ส. - BAAC',
                          'ธนาคารสงเคราะห์ - GHB',
                          'เอชเอสบีซี - HSBC',
                          'ไอซีบีซี (ไทย) - ICBCT',
                          'อิสลาม - ISBT',
                          'มิซูโอ - MIZUHO',
                          'ซูมิโตโม มิตซุย - SMBC',
                          'ไทยเครดิต - TCR',
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
                                _bank = 'กรุงไทย - KTB';
                              } else {
                                _bank = val;
                              }
                            },
                          );
                        },
                        hint: _dropDownValue == null
                            ? Text(
                                '1',
                              )
                            : Text(
                                _dropDownValue,
                                style: TextStyle(color: purple2),
                              ),
                      ),
                    ),

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
                          Row(
                            children: <Widget>[
                              Text(
                                'จำนวนที่ต้องชำระ',
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 14,
                                  color: purple2,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(left: 10)),
                              Text(
                                allint.toString(),
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: purple2,
                                ),
                              ),
                            ],
                          ),
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

                    // Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 20),
                    //   child: FormField<String>(
                    //     builder: (FormFieldState<String> state) {
                    //       return InputDecorator(
                    //         decoration: InputDecoration(
                    //             border: OutlineInputBorder(
                    //                 borderRadius: BorderRadius.circular(5.0))),
                    //         child: DropdownButtonHideUnderline(
                    //           child: DropdownButton<String>(
                    //             hint: Text("Select Device"),
                    //             value: currentSelectedValue,
                    //             isDense: true,
                    //             onChanged: (newValue) {
                    //               setState(() {
                    //                 currentSelectedValue = newValue;
                    //               });
                    //               print(currentSelectedValue);
                    //             },
                    //             items: deviceTypes.map((String value) {
                    //               return DropdownMenuItem<String>(
                    //                 value: value,
                    //                 child: Text(value),
                    //               );
                    //             }).toList(),
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
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
                                  // autofocus: true,
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

                          onPressed: _paydilog,
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
        )
        );
  }

  final databaseReference = Firestore.instance;
  void _deleteData() {
    databaseReference.collection('Notishare').getDocuments().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
        ds.reference.delete();
      }
    });
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Home();
      // return Payment();
    }));
    // try {
    //   databaseReference.collection('ShareRequest').document('D55JNu4VVBpxsuKcwP30').delete();
    // } catch (e) {
    //   print(e.toString());
    // }
  }
}
