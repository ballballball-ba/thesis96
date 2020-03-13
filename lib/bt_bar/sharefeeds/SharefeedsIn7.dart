import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mythesis96/bt_bar/detail_share.dart';
import 'package:mythesis96/bt_bar/notifier_share.dart';
import 'package:mythesis96/m/share_posts.dart';
import 'package:provider/provider.dart';
import 'package:mythesis96/firebase/database_up.dart';

class SharefeedsIn7 extends StatefulWidget {
  SharefeedsIn7({Key key}) : super(key: key);

  @override
  _SharefeedsIn7State createState() => _SharefeedsIn7State();
}

class _SharefeedsIn7State extends State<SharefeedsIn7> {
  @override
  void initState() {
    ShareNotifier shareNotifier =
        Provider.of<ShareNotifier>(context, listen: false);
    getShare(shareNotifier);

    ShareNotifier2 shareNotifier2 =
        Provider.of<ShareNotifier2>(context, listen: false);

    getShare2(shareNotifier2);

    ShareNotifier3 shareNotifier3 =
        Provider.of<ShareNotifier3>(context, listen: false);

    getShare3(shareNotifier3);

    super.initState();
  }

  void getData() {
    // final databaseReference = Firestore.instance;
    // databaseReference
    //     .collection("Concert")
    //     .getDocuments()
    //     .then((QuerySnapshot snapshot) {
    //   snapshot.documents.forEach((f) => print('${f.data['NameCon']}}'));
    //   //snapshot.documents
    //   //     for (var index = 0; index < da.length; ++index) {
    //   // final value = values[index];
    //   // }
    // });
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

  final Color purple1 = Color(0xff5A45A5);
  final Color purple2 = Color(0xff2A1D59);
  final Color orange1 = Color(0xffF2551D);
  @override
  Widget build(BuildContext context) {
    ShareNotifier shareNotifier = Provider.of<ShareNotifier>(context);
    ShareNotifier2 shareNotifier2 = Provider.of<ShareNotifier2>(context);
    ShareNotifier3 shareNotifier3 = Provider.of<ShareNotifier3>(context);
    return new DefaultTabController(
      length: 3,
      child: new Scaffold(
          backgroundColor: Colors.white,
          appBar: new PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: new Container(
              margin: EdgeInsets.only(top: 10),
              height: 40.0,
              child: new TabBar(
                isScrollable: true,
                labelColor: Colors.white,
                indicatorColor: purple2,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(40), color: Color(0xffA99CD9)),
                unselectedLabelColor: Color(0xffA99CD9),
                tabs: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Tab(
                            icon: Icon(FontAwesomeIcons.car),
                          ),
                          Padding(padding: EdgeInsets.only(left: 10)),
                          Text('ทั้งหมด', style: TextStyle(fontFamily: 'Kanit'))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Tab(
                          icon: Icon(FontAwesomeIcons.female),
                        ),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Text('หญิง', style: TextStyle(fontFamily: 'Kanit'))
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
                          icon: Icon(FontAwesomeIcons.male),
                        ),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Text('ชาย', style: TextStyle(fontFamily: 'Kanit'))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          //     body: TabBarView(
          //       children: [
          //         Icon(Icons.directions_car),
          //         Icon(Icons.directions_transit),
          //         Icon(Icons.directions_bike),
          //       ],
          //     ),
          //   ),
          // );

          body: TabBarView(
            children: [
              ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      shareNotifier.currentShare =
                          shareNotifier.shareList[index];
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return DetailShare();
                      }));
                    },
                    child: Container(
                      height: 155,
                      margin: EdgeInsets.only(top: 20, left: 15, right: 15),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              spreadRadius: 2,
                              offset: Offset(1, 3))
                        ],
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                               Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(width: 1, color: purple1),
                                    borderRadius: BorderRadius.circular(60)),
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: shareNotifier
                                          .shareList[index].picpro.isEmpty
                                      ? AssetImage(
                                          'assets/images/user_placeholder.jpg')
                                      : NetworkImage(shareNotifier
                                          .shareList[index].picpro),
                                ),
                               
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'หญิง',
                                    style: TextStyle(
                                      fontFamily: 'Kanit',
                                      color: orange1,
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 5)),
                                  Text(
                                    shareNotifier.shareList[index].seatyou2,
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
                                  Padding(padding: EdgeInsets.only(left: 5)),
                                  Text(
                                    shareNotifier.shareList[index].seatyou,
                                    style: TextStyle(
                                      fontFamily: 'Kanit',
                                      color: purple2,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(left: 5)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.music_note,
                                      color: orange1,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                    ),
                                    Flexible(
                                      child: Text(
                                        shareNotifier
                                            .shareList[index].concertname,
                                        style: TextStyle(
                                          fontFamily: 'Kanit',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
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
                                      padding: EdgeInsets.only(left: 5),
                                    ),
                                    Text(
                                      'จาก',
                                      style: TextStyle(
                                        fontFamily: 'Kanit',
                                        color: purple2,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3),
                                    ),
                                    Text(
                                      shareNotifier.shareList[index].startplace,
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
                                      padding: EdgeInsets.only(left: 5),
                                    ),
                                    Text(
                                      'ถึง',
                                      style: TextStyle(
                                        fontFamily: 'Kanit',
                                        color: purple2,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3),
                                    ),
                                    Text(
                                      shareNotifier.shareList[index].endplace,
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
                                          Icons.airline_seat_legroom_normal,
                                          color: orange1,
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                        ),
                                        Text(
                                          shareNotifier.shareList[index].seat,
                                          style: TextStyle(
                                            fontFamily: 'Kanit',
                                            color: purple2,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 15),
                                        ),
                                        Icon(
                                          Icons.attach_money,
                                          color: orange1,
                                          size: 20,
                                        ),
                                        Text(
                                          shareNotifier.shareList[index].price,
                                          style: TextStyle(
                                            fontFamily: 'Kanit',
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
                                      padding: EdgeInsets.only(left: 5),
                                    ),
                                    Text(
                                      shareNotifier.shareList[index].date,
                                      style: TextStyle(
                                        fontFamily: 'Kanit',
                                        color: purple2,
                                      ),
                                    ),
                                   Padding(
                                      padding: EdgeInsets.only(left: 20),
                                    ),
                                     Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.access_time,
                                      color: orange1,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                    ),
                                    Text(
                                      shareNotifier.shareList[index].time,
                                      style: TextStyle(
                                        fontFamily: 'Kanit',
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
                                      FontAwesomeIcons.venusMars,
                                      color: orange1,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                    ),
                                    Text(
                                      'ต้องการเพศ : '+shareNotifier.shareList[index].gender,
                                      style: TextStyle(
                                        fontFamily: 'Kanit',
                                        color: purple2,
                                      ),
                                    )
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
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: Colors.white,
                  );
                },
              ),
              //  allshare(),
              //*****************2222222222222222222***************************************************** */
              ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      shareNotifier2.currentShare =
                          shareNotifier2.shareList[index];
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return DetailShare();
                      }));
                    },
                    child: Container(
                      height: 155,
                      margin: EdgeInsets.only(top: 20, left: 15, right: 15),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              spreadRadius: 2,
                              offset: Offset(1, 3))
                        ],
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    border:
                                        Border.all(width: 1, color: purple1),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://via.placeholder.com/150'),
                                    )),
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'หญิง',
                                    style: TextStyle(
                                      fontFamily: 'Kanit',
                                      color: orange1,
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 5)),
                                  Text(
                                    shareNotifier2.shareList[index].seatyou2,
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
                                  Padding(padding: EdgeInsets.only(left: 5)),
                                  Text(
                                    shareNotifier2.shareList[index].seatyou,
                                    style: TextStyle(
                                      fontFamily: 'Kanit',
                                      color: purple2,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(left: 5)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.music_note,
                                      color: orange1,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                    ),
                                    Flexible(
                                      child: Text(
                                        shareNotifier2
                                            .shareList[index].concertname,
                                        style: TextStyle(
                                          fontFamily: 'Kanit',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
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
                                      padding: EdgeInsets.only(left: 5),
                                    ),
                                    Text(
                                      'จาก',
                                      style: TextStyle(
                                        fontFamily: 'Kanit',
                                        color: purple2,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3),
                                    ),
                                    Text(
                                      shareNotifier2
                                          .shareList[index].startplace,
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
                                      padding: EdgeInsets.only(left: 5),
                                    ),
                                    Text(
                                      'ถึง',
                                      style: TextStyle(
                                        fontFamily: 'Kanit',
                                        color: purple2,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3),
                                    ),
                                    Text(
                                      shareNotifier2.shareList[index].endplace,
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
                                          Icons.airline_seat_legroom_normal,
                                          color: orange1,
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                        ),
                                        Text(
                                          shareNotifier2.shareList[index].seat,
                                          style: TextStyle(
                                            fontFamily: 'Kanit',
                                            color: purple2,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 15),
                                        ),
                                        Icon(
                                          Icons.attach_money,
                                          color: orange1,
                                          size: 20,
                                        ),
                                        Text(
                                          shareNotifier2.shareList[index].price,
                                          style: TextStyle(
                                            fontFamily: 'Kanit',
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
                                      padding: EdgeInsets.only(left: 5),
                                    ),
                                    Text(
                                      shareNotifier2.shareList[index].date,
                                      style: TextStyle(
                                        fontFamily: 'Kanit',
                                        color: purple2,
                                      ),
                                    ),
                                   Padding(
                                      padding: EdgeInsets.only(left: 20),
                                    ),
                                     Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.access_time,
                                      color: orange1,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                    ),
                                    Text(
                                      shareNotifier.shareList[index].time,
                                      style: TextStyle(
                                        fontFamily: 'Kanit',
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
                                      FontAwesomeIcons.venusMars,
                                      color: orange1,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                    ),
                                    Text(
                                      'ต้องการเพศ : '+shareNotifier.shareList[index].gender,
                                      style: TextStyle(
                                        fontFamily: 'Kanit',
                                        color: purple2,
                                      ),
                                    )
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
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: Colors.white,
                  );
                },
              ),

              ///*************333333333333333333333333333333333333333333333 */
              // Icon(Icons.ac_unit)
              ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      shareNotifier3.currentShare =
                          shareNotifier3.shareList[index];
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return DetailShare();
                      }));
                    },
                    child: Container(
                      height: 155,
                      margin: EdgeInsets.only(top: 20, left: 15, right: 15),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              spreadRadius: 2,
                              offset: Offset(1, 3))
                        ],
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    border:
                                        Border.all(width: 1, color: purple1),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://via.placeholder.com/150'),
                                    )),
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'หญิง',
                                    style: TextStyle(
                                      fontFamily: 'Kanit',
                                      color: orange1,
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 5)),
                                  Text(
                                    shareNotifier3.shareList[index].seatyou2,
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
                                  Padding(padding: EdgeInsets.only(left: 5)),
                                  Text(
                                    shareNotifier3.shareList[index].seatyou,
                                    style: TextStyle(
                                      fontFamily: 'Kanit',
                                      color: purple2,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(left: 5)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.music_note,
                                      color: orange1,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                    ),
                                    Flexible(
                                      child: Text(
                                        shareNotifier3
                                            .shareList[index].concertname,
                                        style: TextStyle(
                                          fontFamily: 'Kanit',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
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
                                      padding: EdgeInsets.only(left: 5),
                                    ),
                                    Text(
                                      'จาก',
                                      style: TextStyle(
                                        fontFamily: 'Kanit',
                                        color: purple2,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3),
                                    ),
                                    Text(
                                      shareNotifier3
                                          .shareList[index].startplace,
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
                                      padding: EdgeInsets.only(left: 5),
                                    ),
                                    Text(
                                      'ถึง',
                                      style: TextStyle(
                                        fontFamily: 'Kanit',
                                        color: purple2,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3),
                                    ),
                                    Text(
                                      shareNotifier3.shareList[index].endplace,
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
                                          Icons.airline_seat_legroom_normal,
                                          color: orange1,
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                        ),
                                        Text(
                                          shareNotifier3.shareList[index].seat,
                                          style: TextStyle(
                                            fontFamily: 'Kanit',
                                            color: purple2,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 15),
                                        ),
                                        Icon(
                                          Icons.attach_money,
                                          color: orange1,
                                          size: 20,
                                        ),
                                        Text(
                                          shareNotifier3.shareList[index].price,
                                          style: TextStyle(
                                            fontFamily: 'Kanit',
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
                                      padding: EdgeInsets.only(left: 5),
                                    ),
                                    Text(
                                      shareNotifier3.shareList[index].date,
                                      style: TextStyle(
                                        fontFamily: 'Kanit',
                                        color: purple2,
                                      ),
                                    ),
                                   Padding(
                                      padding: EdgeInsets.only(left: 20),
                                    ),
                                     Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.access_time,
                                      color: orange1,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                    ),
                                    Text(
                                      shareNotifier.shareList[index].time,
                                      style: TextStyle(
                                        fontFamily: 'Kanit',
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
                                      FontAwesomeIcons.venusMars,
                                      color: orange1,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                    ),
                                    Text(
                                      'ต้องการเพศ : '+shareNotifier.shareList[index].gender,
                                      style: TextStyle(
                                        fontFamily: 'Kanit',
                                        color: purple2,
                                      ),
                                    )
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
                itemCount: shareNotifier3.shareList.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: Colors.white,
                  );
                },
              ),
            ],
          )

          //child: child,
          ),
    );
//     allshare(){
//    final Color purple1 = Color(0xff5A45A5);
//   final Color purple2 = Color(0xff2A1D59);
//   final Color orange1 = Color(0xffF2551D);
//   ShareNotifier shareNotifier = Provider.of<ShareNotifier>(context);

// }
  }
}

//***************************************** */
getShare(ShareNotifier shareNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Shareposts')
      // .where('Concertname', isEqualTo: 'Noel Gallagher’s  2020')
      // .collection('Shareposts')
      .where('Date', isGreaterThanOrEqualTo: '09/01/2020')
      .where('Date', isLessThanOrEqualTo: '09/31/2020')
      .getDocuments();
  List<Share> _shareList = [];
  snapshot.documents.forEach((document) {
    Share share = Share.fromMap(document.data);
    _shareList.add(share);
  });
  shareNotifier.shareList = _shareList;
}

getShare2(ShareNotifier2 shareNotifier2) async {
  QuerySnapshot snapshot = await Firestore.instance
      // .collection('Users')
      // .document()
      .collection('Shareposts')
      .where('Date', isGreaterThanOrEqualTo: '09/01/2020')
      .where('Date', isLessThanOrEqualTo: '09/31/2020')
      // .where('Seatyou2', isGreaterThanOrEqualTo: '1')
      // .where('Concertname', isEqualTo: 'Noel Gallagher’s  2020')
      // .where('Seatyou2', isGreaterThanOrEqualTo: '1')
      //.collection('Shareposts')
      //.orderBy('timestamp', descending: true)
      .orderBy('Date', descending: true)
      .getDocuments();
  List<Share> _shareList = [];
  snapshot.documents.forEach((document) {
    Share share = Share.fromMap(document.data);
    _shareList.add(share);
  });
  shareNotifier2.shareList = _shareList;
}

getShare3(ShareNotifier3 shareNotifier3) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Shareposts')
      .where('Date', isGreaterThanOrEqualTo: '09/01/2020')
      .where('Date', isLessThanOrEqualTo: '09/31/2020')
      //  .where('Seatyou', isGreaterThanOrEqualTo: '1')
      // .orderBy('Date', descending: true)
      .getDocuments();
  List<Share> _shareList = [];
  snapshot.documents.forEach((document) {
    Share share = Share.fromMap(document.data);
    _shareList.add(share);
  });
  // nameQuery1.documents.forEach((document) {
  //   Share share = Share.fromMap(document.data);
  //   _shareList.add(share );
  // });
  shareNotifier3.shareList = _shareList;
}
