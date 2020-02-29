import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mythesis96/bt_bar/detail/detailreqeust.dart';
import 'package:mythesis96/bt_bar/detail/detailreqeustdriver.dart';
import 'package:mythesis96/bt_bar/detail/detailreqeustsuccess.dart';
import 'package:intl/intl.dart';
import 'package:mythesis96/bt_bar/notifier_share%20request.dart';
import 'package:mythesis96/bt_bar/notifier_share.dart';
import 'package:mythesis96/firebase/constance.dart';
import 'package:mythesis96/m/share_posts.dart';
import 'package:mythesis96/m/user_data.dart';
import 'package:mythesis96/m/user_m.dart';
import 'package:provider/provider.dart';
import 'package:mythesis96/firebase/database_up.dart';

class Activity extends StatefulWidget {
  //Activity({Key key}) : super(key: key);
  final String userId;

  const Activity({Key key, this.userId}) : super(key: key);

//construtor
  //Activity({this.userId});
  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  var connamebar = [
    'HYUKOH',
    'IU',
    'AB6IX',
    'NOEL',
    'GOT7',
    'LIAM',
    'GREENDAY',
    'PARADOX',
    'BAEKHO',
    'JANGDONG'
  ];

  final Color orange1 = Color(0xffF2551D);
  final Color purple1 = Color(0xff5A45A5);
  final Color purple2 = Color(0xff2A1D59);

  @override
  void initState() {
    ShareNotifier shareNotifier =
        Provider.of<ShareNotifier>(context, listen: false);
    getShare(shareNotifier);
    ShareNotifierrequest shareNotifier2 =
        Provider.of<ShareNotifierrequest>(context, listen: false);

    getShare2(shareNotifier2);

    ShareNotifierrequest2 shareNotifier3 =
        Provider.of<ShareNotifierrequest2>(context, listen: false);

    getShare3(shareNotifier3);

    super.initState();
  }

  checkuser() {
    Scaffold(
      body: FutureBuilder(
          future: userRef.document(widget.userId).get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              // return Center(
              //   child: CircularProgressIndicator(),
              // );
              User user = User.fromDoc(snapshot.data);
              return Text(user.id);
            }
            //  User user = User.fromDoc(snapshot.data);
            //  print(user.profileImgUrl);
          }),
    );
  }

  getShare(ShareNotifier shareNotifier) async {
    // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

    // _getToken() {
    //   _firebaseMessaging.getToken().then((deviceToken) {
    //     print('มาย55555device token: $deviceToken');
    //   });
    // }

    QuerySnapshot snapshot = await Firestore.instance
        .collection('ShareRequest')
        // .document(Provider.of<Userdata>(context).currentUserID)

        // .snapshots(),
        //.where('AuthorId', isEqualTo: 'authorshare')
        //**** */ .where('AuthorId', isEqualTo: checkuser())
        // .where('AuthorId', isEqualTo: 'FXqc0t1icbcTDGTgPs5maJkUiOn1')
        //.collection('Shareposts')
        // .orderBy('timestamp', descending: true)
        //  .orderBy('Date', descending: false)
        .getDocuments();

    List<Share> _shareList = [];
    snapshot.documents.forEach((document) {
      Share share = Share.fromMap(document.data);
      _shareList.add(share);
    });
    shareNotifier.shareList = _shareList;
  }

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

  void getData() {
    final _firestore = Firestore.instance;
    _firestore
        .collection('Concert')
        .document()
        .snapshots()
        .asyncMap((snap) async {
      List<String> groceryListsArr = snap.data['NameCon'];
      var groceryList = <DocumentSnapshot>[];
      for (var groceryPath in groceryListsArr) {
        groceryList.add(await _firestore.document(groceryPath).get());
      }
      return groceryList;
    });
  }

  @override
  Widget build(BuildContext context) {
    ShareNotifier shareNotifier = Provider.of<ShareNotifier>(context);
    ShareNotifierrequest shareNotifier2 =
        Provider.of<ShareNotifierrequest>(context, listen: false);
    ShareNotifierrequest2 shareNotifier3 =
        Provider.of<ShareNotifierrequest2>(context);

    final _formkey = GlobalKey<FormState>();

    _submit() async {
      if (_formkey.currentState.validate()) {
        _formkey.currentState.save();

        var now = new DateTime.now();
        Shareconfirm shareconfirm = Shareconfirm(
          timestamp: DateFormat("dd-MM-yyyy hh:mm").format(now),
          authorId: Provider.of<Userdata>(context).currentUserID,
        );
        DatabaseSer.createShareconfirm(shareconfirm);
        // DatabaseSer.createCar(car);

        // รีเซทข้อมูลให้ว่างเหมือนเดิม

        // setState(() {
        //   _malereq = '';
        //   _femalereq = '';
        // });
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

    return new DefaultTabController(
        length: 3,
        child: new Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: Text('การแชร์ของฉัน',
                  style: TextStyle(
                      fontFamily: 'Kanit',
                      color: purple2,
                      fontWeight: FontWeight.w600)),
              backgroundColor: Colors.transparent,
              elevation: 0,
              bottom: PreferredSize(
                preferredSize: new Size(30.0, 30.0),
                child: Container(
                  height: 40,
                  child: TabBar(
                    isScrollable: true,
                    labelColor: Colors.white,
                    // indicatorSize: TabBarIndicatorSize.values,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: purple1),
                    indicatorColor: purple1,
                    unselectedLabelColor: purple1,
                    tabs: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Tab(
                              icon: Icon(FontAwesomeIcons.car),
                            ),
                            Padding(padding: EdgeInsets.only(left: 10)),
                            Text('คนขอร่วมแชร์',
                                style: TextStyle(fontFamily: 'Kanit'))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Tab(
                              icon: Icon(FontAwesomeIcons.car),
                            ),
                            Padding(padding: EdgeInsets.only(left: 10)),
                            Text('คนขับ', style: TextStyle(fontFamily: 'Kanit'))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Tab(
                              icon: Icon(FontAwesomeIcons.carSide),
                            ),
                            Padding(padding: EdgeInsets.only(left: 10)),
                            Text('กำลังดำเนินการ',
                                style: TextStyle(fontFamily: 'Kanit'))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // body: FutureBuilder(
            //   future: shareRequestRef.document(widget.userId).get(),
            //   //future: FirebaseAuth.instance.currentUser(),
            //   builder: (BuildContext context, AsyncSnapshot snapshot) {
            //     if (!snapshot.hasData) {
            //       //   User user = User.fromDoc(snapshot.data);
            //       return Text('Loading...');

            //       //  return Text(snapshot.data.uid);
            //     } else {
            //     // else if ('FXqc0t1icbcTDGTgPs5maJkUiOn1' ==
            //     //    Provider.of<Userdata>(context).currentUserID ){
            //       Sharereq sharereq = Sharereq.fromDoc(snapshot.data);
            //       if (sharereq.authorId ==
            //           Provider.of<Userdata>(context).currentUserID) {
            body: FutureBuilder(
                future: FirebaseAuth.instance.currentUser(),
                builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
                  if (!snapshot.hasData) {
                    return Text('Loading...');

                    //  return Text(snapshot.data.uid);
                  } else if (snapshot.hasData) {
                    return TabBarView(
                      children: [
                        // body: StreamBuilder(
                        //   //   future: userRef.document(widget.userId).get(),
                        //   //future: FirebaseAuth.instance.currentUser(),
                        //   stream: Firestore.instance
                        //       .collection('ShareRequest')
                        //       //  .document(Provider.of<Userdata>(context).currentUserID)
                        //       .snapshots(),
                        //   builder: (context, snapshot) {
                        //     if (!snapshot.hasData) {
                        //       return Text('Loading...');

                        //       //  return Text(snapshot.data.uid);
                        //     } else if (snapshot.hasData) {

                        //       var userDocument = snapshot.va;
                        //       if (userDocument ==
                        //           Provider.of<Userdata>(context).currentUserID) {

//   checkuser() {
//   Scaffold(
//     body: FutureBuilder(
//         future: userRef.document(widget.userId).get(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.hasData) {
//             // return Center(
//             //   child: CircularProgressIndicator(),
//             // );
//             User user = User.fromDoc(snapshot.data);
//             return Text(user.id);
//           }
//           //  User user = User.fromDoc(snapshot.data);
//           //  print(user.profileImgUrl);
//         }),
//   );
// }

                        // StreamBuilder(
                        //     stream: Firestore.instance
                        //         .collection('ShareRequest')
                        //         // .document(Provider.of<Userdata>(context)
                        //         //     .currentUserID)
                        //         .where('AuthorId',
                        //             isEqualTo: Provider.of<Userdata>(context)
                        //                 .currentUserID)
                        //         //     .currentUserID)
                        //         // .collection('picprofileUrl')
                        //         .snapshots(),
                        //     builder: (context, snapshot) {
                        //       if (snapshot.hasData) {
                        FutureBuilder(
                            future:
                                shareRequestRef.document(widget.userId).get(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (Provider.of<Userdata>(context)
                                      .currentUserID ==
                                  'FXqc0t1icbcTDGTgPs5maJkUiOn1') {
                                return ListView.separated(
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        shareNotifier.currentShare =
                                            shareNotifier.shareList[index];
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder:
                                                (BuildContext context) {
                                          return DetailShareRequest();
                                        }));
                                      },
                                      child: Container(
                                        height: 155,
                                        margin: EdgeInsets.only(
                                            top: 20, left: 15, right: 15),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 4,
                                                spreadRadius: 2,
                                                offset: Offset(1, 3))
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                Container(
                                                  width: 80,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 1,
                                                          color: purple1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              60)),
                                                  child: CircleAvatar(
                                                    radius: 60,
                                                    backgroundColor:
                                                        Colors.grey,
                                                    backgroundImage: shareNotifier
                                                            .shareList[index]
                                                            .picpro
                                                            .isEmpty
                                                        ? AssetImage(
                                                            'assets/images/user_placeholder.jpg')
                                                        : NetworkImage(
                                                            shareNotifier
                                                                .shareList[
                                                                    index]
                                                                .picpro),
                                                  ),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10)),
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      'หญิง',
                                                      style: TextStyle(
                                                        fontFamily: 'Kanit',
                                                        color: orange1,
                                                      ),
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5)),
                                                    Text(
                                                      shareNotifier
                                                          .shareList[index]
                                                          .seatyou2,
                                                      style: TextStyle(
                                                        fontFamily: 'Kanit',
                                                        color: purple2,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      'ชาย',
                                                      style: TextStyle(
                                                        fontFamily: 'Kanit',
                                                        color: orange1,
                                                      ),
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5)),
                                                    Text(
                                                      shareNotifier
                                                          .shareList[index]
                                                          .seatyou,
                                                      style: TextStyle(
                                                        fontFamily: 'Kanit',
                                                        color: purple2,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(left: 5)),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.music_note,
                                                        color: orange1,
                                                        size: 20,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5),
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          shareNotifier
                                                              .shareList[index]
                                                              .concertname,
                                                          style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: purple2,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.place,
                                                        color: orange1,
                                                        size: 20,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5),
                                                      ),
                                                      Text(
                                                        'จาก',
                                                        style: TextStyle(
                                                          fontFamily: 'Kanit',
                                                          color: purple2,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 3),
                                                      ),
                                                      Text(
                                                        shareNotifier
                                                            .shareList[index]
                                                            .startplace,
                                                        style: TextStyle(
                                                          fontFamily: 'Kanit',
                                                          color: purple2,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.map,
                                                        color: orange1,
                                                        size: 20,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5),
                                                      ),
                                                      Text(
                                                        'ถึง',
                                                        style: TextStyle(
                                                          fontFamily: 'Kanit',
                                                          color: purple2,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 3),
                                                      ),
                                                      Text(
                                                        shareNotifier
                                                            .shareList[index]
                                                            .endplace,
                                                        style: TextStyle(
                                                          fontFamily: 'Kanit',
                                                          color: purple2,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons
                                                                .airline_seat_legroom_normal,
                                                            color: orange1,
                                                            size: 20,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 5),
                                                          ),
                                                          Text(
                                                            shareNotifier
                                                                .shareList[
                                                                    index]
                                                                .seat
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Kanit',
                                                              color: purple2,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 15),
                                                          ),
                                                          Icon(
                                                            Icons.attach_money,
                                                            color: orange1,
                                                            size: 20,
                                                          ),
                                                          Text(
                                                            shareNotifier
                                                                .shareList[
                                                                    index]
                                                                .price,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Kanit',
                                                              color: purple2,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.date_range,
                                                        color: orange1,
                                                        size: 20,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5),
                                                      ),
                                                      Text(
                                                        shareNotifier
                                                            .shareList[index]
                                                            .date,
                                                        style: TextStyle(
                                                          fontFamily: 'Kanit',
                                                          color: purple2,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.access_time,
                                                        color: orange1,
                                                        size: 20,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5),
                                                      ),
                                                      Text(
                                                        shareNotifier
                                                            .shareList[index]
                                                            .time,
                                                        style: TextStyle(
                                                          fontFamily: 'Kanit',
                                                          color: purple2,
                                                        ),
                                                      ),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 120)),
                                                      Row(
                                                        children: <Widget>[
                                                          Text(
                                                            'รอการตอบรับ',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Kanit',
                                                              color: purple1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: shareNotifier.shareList.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Divider(
                                      color: Colors.white,
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                  child: Text('ไม่มีการแชร์'),
                                );
                              }
                            }),

                        //  allshare(),
                        //*****************2222222222222222222***************************************************** */
                        FutureBuilder(
                            future:
                                shareRequestRef.document(widget.userId).get(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (Provider.of<Userdata>(context)
                                      .currentUserID ==
                                  'A2jLoXTYDMRTyJTaTfKWhHQfRAS2') {
                                // StreamBuilder(
                                //     stream: Firestore.instance
                                //         .collection('ShareRequest')
                                //         // .document(Provider.of<Userdata>(context)
                                //         //     .currentUserID)
                                //         // .where('authorshare',
                                //         //     isEqualTo: 'BeKfwcrxIfPw0BUDs7yRKYZgjcw1')
                                //         //     .currentUserID)
                                //         // .collection('picprofileUrl')
                                //         .snapshots(),
                                //     builder: (context, snapshot) {
                                //       if (snapshot.data['authorshare'] == Provider.of<Userdata>(context).currentUserID) {
                                return ListView.separated(
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        shareNotifier2.currentShare =
                                            shareNotifier2.shareList[index];
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder:
                                                (BuildContext context) {
                                          return DetailSharedriver();
                                        }));
                                      },
                                      child: Container(
                                        height: 160,
                                        margin: EdgeInsets.only(
                                            top: 20, left: 15, right: 15),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 4,
                                                spreadRadius: 2,
                                                offset: Offset(1, 3))
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                Container(
                                                  width: 80,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 1,
                                                          color: purple1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              60)),
                                                  child: CircleAvatar(
                                                    radius: 60,
                                                    backgroundColor:
                                                        Colors.grey,
                                                    backgroundImage: shareNotifier2
                                                            .shareList[index]
                                                            .picpro
                                                            .isEmpty
                                                        ? AssetImage(
                                                            'assets/images/user_placeholder.jpg')
                                                        : NetworkImage(
                                                            shareNotifier2
                                                                .shareList[
                                                                    index]
                                                                .picpro),
                                                  ),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10)),
                                                // Row(
                                                //   children: <Widget>[
                                                //     Text(
                                                //       'หญิง',
                                                //       style: TextStyle(
                                                //         fontFamily: 'Kanit',
                                                //         color: orange1,
                                                //       ),
                                                //     ),
                                                //     Padding(padding: EdgeInsets.only(left: 5)),
                                                //     Text(
                                                //       shareNotifier2.shareList[index].seatyou2,
                                                //       style: TextStyle(
                                                //         fontFamily: 'Kanit',
                                                //         color: purple2,
                                                //       ),
                                                //     )
                                                //   ],
                                                // ),
                                                // Row(
                                                //   children: <Widget>[
                                                //     Text(
                                                //       'ชาย',
                                                //       style: TextStyle(
                                                //         fontFamily: 'Kanit',
                                                //         color: orange1,
                                                //       ),
                                                //     ),
                                                //     Padding(padding: EdgeInsets.only(left: 5)),
                                                //     Text(
                                                //       shareNotifier2.shareList[index].seatyou,
                                                //       style: TextStyle(
                                                //         fontFamily: 'Kanit',
                                                //         color: purple2,
                                                //       ),
                                                //     )
                                                //   ],
                                                // ),
                                              ],
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(left: 5)),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.music_note,
                                                        color: orange1,
                                                        size: 20,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5),
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          shareNotifier2
                                                              .shareList[index]
                                                              .concertname,
                                                          style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: purple2,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.place,
                                                        color: orange1,
                                                        size: 20,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5),
                                                      ),
                                                      Text(
                                                        'จาก',
                                                        style: TextStyle(
                                                          fontFamily: 'Kanit',
                                                          color: purple2,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 3),
                                                      ),
                                                      Text(
                                                        shareNotifier2
                                                            .shareList[index]
                                                            .startplace,
                                                        style: TextStyle(
                                                          fontFamily: 'Kanit',
                                                          color: purple2,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.map,
                                                        color: orange1,
                                                        size: 20,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5),
                                                      ),
                                                      Text(
                                                        'ถึง',
                                                        style: TextStyle(
                                                          fontFamily: 'Kanit',
                                                          color: purple2,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 3),
                                                      ),
                                                      Text(
                                                        shareNotifier2
                                                            .shareList[index]
                                                            .endplace,
                                                        style: TextStyle(
                                                          fontFamily: 'Kanit',
                                                          color: purple2,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons
                                                                .airline_seat_legroom_normal,
                                                            color: orange1,
                                                            size: 20,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 5),
                                                          ),
                                                          Text(
                                                            shareNotifier2
                                                                .shareList[
                                                                    index]
                                                                .seat
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Kanit',
                                                              color: purple2,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 15),
                                                          ),
                                                          Icon(
                                                            Icons.attach_money,
                                                            color: orange1,
                                                            size: 20,
                                                          ),
                                                          Text(
                                                            shareNotifier2
                                                                .shareList[
                                                                    index]
                                                                .price,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Kanit',
                                                              color: purple2,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      Column(
                                                        children: <Widget>[
                                                          Row(
                                                            children: <Widget>[
                                                              Text(
                                                                'คำขอหญิง',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Kanit',
                                                                  color:
                                                                      purple2,
                                                                ),
                                                              ),
                                                              Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              5)),
                                                              Text(
                                                                shareNotifier2
                                                                    .shareList[
                                                                        index]
                                                                    .reqseat2,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Kanit',
                                                                    color:
                                                                        orange1,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: <Widget>[
                                                              Text(
                                                                'คำขอชาย',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Kanit',
                                                                  color:
                                                                      purple2,
                                                                ),
                                                              ),
                                                              Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              5)),
                                                              Text(
                                                                shareNotifier2
                                                                    .shareList[
                                                                        index]
                                                                    .reqseat1,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Kanit',
                                                                    color:
                                                                        orange1,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: shareNotifier2.shareList.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Divider(
                                      color: Colors.white,
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                  child: Text('ไม่มีคำร้องขอการแชร์'),
                                );
                              }
                            }),

                        ///*************333333333333333333333333333333333333333333333 */
                        // Icon(Icons.ac_unit)

                        FutureBuilder(
                            future:
                                shareRequestRef.document(widget.userId).get(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (Provider.of<Userdata>(context)
                                          .currentUserID ==
                                      'A2jLoXTYDMRTyJTaTfKWhHQfRAS2' ||
                                  Provider.of<Userdata>(context)
                                          .currentUserID ==
                                      'FXqc0t1icbcTDGTgPs5maJkUiOn1') {
                                return ListView.separated(
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        shareNotifier3.currentShare =
                                            shareNotifier3.shareList[index];
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder:
                                                (BuildContext context) {
                                          return DetailSharesuccess();
                                        }));
                                      },
                                      child: Container(
                                        height: 110,
                                        margin: EdgeInsets.only(
                                            top: 20, left: 15, right: 15),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 4,
                                                spreadRadius: 2,
                                                offset: Offset(1, 3))
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                Container(
                                                  width: 80,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 1,
                                                          color: purple1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              60)),
                                                  child: CircleAvatar(
                                                    radius: 60,
                                                    backgroundColor:
                                                        Colors.grey,
                                                    backgroundImage: shareNotifier3
                                                            .shareList[index]
                                                            .picpro
                                                            .isEmpty
                                                        ? AssetImage(
                                                            'assets/images/user_placeholder.jpg')
                                                        : NetworkImage(
                                                            shareNotifier3
                                                                .shareList[
                                                                    index]
                                                                .picpro),
                                                  ),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10)),
                                              ],
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(left: 5)),
                                            Expanded(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.music_note,
                                                          color: orange1,
                                                          size: 20,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5),
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            shareNotifier3
                                                                .shareList[
                                                                    index]
                                                                .concertname,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Kanit',
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: purple2,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.place,
                                                          color: orange1,
                                                          size: 20,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5),
                                                        ),
                                                        Text(
                                                          'จาก',
                                                          style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            color: purple2,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 3),
                                                        ),
                                                        Text(
                                                          shareNotifier3
                                                              .shareList[index]
                                                              .startplace,
                                                          style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            color: purple2,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.map,
                                                          color: orange1,
                                                          size: 20,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5),
                                                        ),
                                                        Text(
                                                          'ถึง',
                                                          style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            color: purple2,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 3),
                                                        ),
                                                        Text(
                                                          shareNotifier3
                                                              .shareList[index]
                                                              .endplace,
                                                          style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            color: purple2,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ]),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: shareNotifier3.shareList.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Divider(
                                      color: Colors.white,
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                  child: Text('ไม่มีการแชร์'),
                                );
                              }
                            }),
                      ],
                    );
                    // } else {
                    //   return Center(
                    //     child: Text('ไม่มีการแชร์'),
                    //   );
                    // }

                    //child: child,
                    // } else {}
                    // } else {
                    //  return Center(
                    //       child: Text('ไม่มีการแชร์'),
                    //     );
                    // }

                  } else {
                    return Center(
                      child: Text(
                        'ไม่มีการแชร์ของคุณในตอนนี้',
                        style: TextStyle(
                          fontFamily: 'Kanit',
                          fontSize: 14,
                          //fontWeight: FontWeight.w600,
                          color: purple2,
                        ),
                      ),
                    );
                  }
                })));
  }
}

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

_getToken() {
  _firebaseMessaging.getToken().then((deviceToken) {
    print('มาย55555device token: $deviceToken');
  });
}

// checkuser() {
//   Scaffold(
//     body: FutureBuilder(
//         future: userRef.document(widget.userId).get(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (!snapshot.hasData) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//            User user = User.fromDoc(snapshot.data);
//         }),
//   );
// }

getShare2(ShareNotifierrequest shareNotifier2) async {
  QuerySnapshot snapshot = await Firestore.instance
      // .collection('Users')
      // .document()
      .collection('ShareRequest')
      // .where('Seatyou2', isGreaterThanOrEqualTo: '1')
      .where('authorshare', isEqualTo: 'BeKfwcrxIfPw0BUDs7yRKYZgjcw1')
      // .where('Seatyou2', isGreaterThanOrEqualTo: '1')
      //.collection('Shareposts')
      //.orderBy('timestamp', descending: true)
      .getDocuments();
  List<Sharereq> _shareList = [];
  snapshot.documents.forEach((document) {
    Sharereq share = Sharereq.fromMap(document.data);
    _shareList.add(share);
  });
  shareNotifier2.shareList = _shareList;
}

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
