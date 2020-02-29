import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mythesis96/firebase/constance.dart';
import 'package:mythesis96/m/user_data.dart';
import 'package:provider/provider.dart';

class Notiac extends StatefulWidget {
  final String userId;
  const Notiac({Key key, this.userId}) : super(key: key);

  @override
  _NotiacState createState() => _NotiacState();
}

class _NotiacState extends State<Notiac> {
  final Color purple1 = Color(0xff5A45A5);
  final Color purple2 = Color(0xff2A1D59);
  final Color orange1 = Color(0xffF2551D);
  @override
  Widget build(BuildContext context) {
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
  }
}

class ListPage1 extends StatefulWidget {
  final String userId;
  const ListPage1({Key key, this.userId}) : super(key: key);
  @override
  _ListPage1State createState() => _ListPage1State();
}

class _ListPage1State extends State<ListPage1> {
  Future _data;

  Future getPosts() async {
    var firestore = Firestore.instance;

    QuerySnapshot qn = await firestore
        .collection('ShareRequest')
        // .where('AuthorId',
        //     isEqualTo: 'FXqc0t1icbcTDGTgPs5maJkUiOn1')
        // .where('AuthorId',
        //     isEqualTo: Provider.of<Userdata>(context).currentUserID.toString())
        .getDocuments();
    return qn.documents;
  }

  // navigatorToDetail(DocumentSnapshot post) {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => DetailPage(
  //                 post: post,
  //               )));
  // }

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
          future: shareRequestRef.document(widget.userId).get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (Provider.of<Userdata>(context).currentUserID ==
                    'A2jLoXTYDMRTyJTaTfKWhHQfRAS2' ||
                Provider.of<Userdata>(context).currentUserID ==
                    'FXqc0t1icbcTDGTgPs5maJkUiOn1') {
              return FutureBuilder(
                future: _data,
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text('กำลังโหลดข้อมูล'),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                              color: Colors.black54,
                            ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () => {print('111111')},
                            child: Container(
                              margin: EdgeInsets.all(10),
                              width: 400,
                              height: 65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Container(
                                //  margin: EdgeInsets.all(6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('แจ้งเตือน',
                                        style: TextStyle(
                                            fontFamily: 'Kanit',
                                            fontSize: 14,
                                            color: Colors.black38)),
                                    Text(
                                        snapshot
                                            .data[index].data['Concertname'],
                                        style: TextStyle(
                                            fontFamily: 'Kanit',
                                            fontSize: 16,
                                            color: Color(0xff5A45A5))),
                                    Text(
                                        'โปรดตรวจสอบรายละเอียดในหน้า "การแชร์ของฉัน"',
                                        style: TextStyle(
                                            fontFamily: 'Kanit',
                                            fontSize: 12,
                                            color: Colors.black38)),
                                    //  Divider(
                                    //   color: Colors.black,
                                    // ),
                                    // Text(
                                    //     'โปรดตรวจสอบรายละเอียดในหน้า "การแชร์ของฉัน"',
                                    //     style: TextStyle(
                                    //         fontFamily: 'Kanit',
                                    //         fontSize: 12,
                                    //         color: Colors.black38)),
                                    // Text(snapshot.data[index].data['timestamp'].toString(),
                                    //     style: TextStyle(
                                    //         fontFamily: 'Kanit',
                                    //         color: Colors.black54)),
                                  ],
                                ),
                              ),
                            ),
                          );
                          // ListTile(
                          //   title: Text(snapshot.data[index].data['Topic']),
                          //   onTap: () => navigatorToDetail(snapshot.data[index]),
                          // );
                        });
                  } else {
                    return Container(
                      child: FutureBuilder(
                          future: shareconfirmRef.document(widget.userId).get(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (Provider.of<Userdata>(context).currentUserID ==
                                    'A2jLoXTYDMRTyJTaTfKWhHQfRAS2' ||
                                Provider.of<Userdata>(context).currentUserID ==
                                    'FXqc0t1icbcTDGTgPs5maJkUiOn1') {
                              return FutureBuilder(
                                future: _data,
                                builder: (_, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: Text('กำลังโหลดข้อมูล'),
                                    );
                                  } else if (snapshot.hasData) {
                                    return ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            Divider(
                                              color: Colors.black54,
                                            ),
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (_, index) {
                                          return GestureDetector(
                                            onTap: () => {print('111111')},
                                            child: Container(
                                              margin: EdgeInsets.all(10),
                                              width: 400,
                                              height: 65,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                              ),
                                              child: Container(
                                                //  margin: EdgeInsets.all(6),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text('แจ้งเตือน',
                                                        style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            fontSize: 14,
                                                            color: Colors
                                                                .black38)),
                                                    Text(
                                                        snapshot.data[index]
                                                                .data[
                                                            'Concertname'],
                                                        style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            fontSize: 16,
                                                            color: Color(
                                                                0xff5A45A5))),
                                                    Text(
                                                        'กำลังดำเนินการ',
                                                        style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            fontSize: 12,
                                                            color: Colors
                                                                .black38)),
                                                    //  Divider(
                                                    //   color: Colors.black,
                                                    // ),
                                                    // Text(
                                                    //     'โปรดตรวจสอบรายละเอียดในหน้า "การแชร์ของฉัน"',
                                                    //     style: TextStyle(
                                                    //         fontFamily: 'Kanit',
                                                    //         fontSize: 12,
                                                    //         color: Colors.black38)),
                                                    // Text(snapshot.data[index].data['timestamp'].toString(),
                                                    //     style: TextStyle(
                                                    //         fontFamily: 'Kanit',
                                                    //         color: Colors.black54)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                          // ListTile(
                                          //   title: Text(snapshot.data[index].data['Topic']),
                                          //   onTap: () => navigatorToDetail(snapshot.data[index]),
                                          // );
                                        });
                                  } else {
                                    return Center(
                                      child: Text(
                                        'ไม่มีการแจ้งเตือน',
                                        style: TextStyle(
                                          fontFamily: 'Kanit',
                                          color: purple2,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              );
                            } else {
                              return Center(
                                child: Text(
                                  'ไม่มีการแจ้งเตือน',
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
                },
              );
            } else {
              return Center(
                child: Text(
                  'ไม่มีการแจ้งเตือน',
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
