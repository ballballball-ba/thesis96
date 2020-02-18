import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mythesis96/bt_bar/details_con.dart';
import 'package:mythesis96/bt_bar/details_con2.dart';
import 'package:mythesis96/bt_bar/driver_regis.dart';
import 'package:mythesis96/bt_bar/edit_profile.dart';
import 'package:mythesis96/bt_bar/notifier_con.dart';
import 'package:mythesis96/bt_bar/sharefeeds.dart';
import 'package:mythesis96/firebase/auth_service.dart';
import 'package:mythesis96/firebase/constance.dart';
import 'package:mythesis96/m/concert.dart';
import 'package:mythesis96/m/driver_regit.dart';
import 'package:mythesis96/firebase/database_up.dart';
import 'package:mythesis96/m/user_data.dart';
import 'package:mythesis96/m/user_m.dart';
import 'package:mythesis96/phone_auth.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'https://www.fungjaizine.com/wp-content/uploads/2019/11/hyukoh.jpg',
  'https://i2.wp.com/www.korseries.com/wp-content/uploads/2019/10/2019-iu-tour-concert-love-poem.jpg?fit=1000%2C596&ssl=1',
  'https://promotions.co.th/wp-content/uploads/2019/11/Cover-27.jpg',
  'https://www.beartai.com/wp-content/uploads/2019/12/Rockland.jpg',
  'https://siam2nite.media/vp_spd2atdhTGcvEsV6NdrKKIBE=/events/21285/facebook_46759ad9e81c9869df8241082b408240.jpg',
  'https://i1.wp.com/www.korseries.com/wp-content/uploads/2019/12/ab6ix-1st-world-tour-6ixense.jpg?resize=1000%2C596&ssl=1',
];
final List child = map<Widget>(
  imgList,
  (index) {},
).toList();

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class Feedhome extends StatefulWidget {
//construtor
  // Feedhome({this.userId});
  static final String id = 'feed_home';
  final String currentUserID;
  final String userId;
  Feedhome({this.currentUserID, this.userId});

  @override
  _FeedhomeState createState() => _FeedhomeState();
}

class CommonThings {
  static Size size;
}

class _FeedhomeState extends State<Feedhome> {
  final Color purple1 = Color(0xff5A45A5);
  final Color purple2 = Color(0xff2A1D59);
  final Color orange1 = Color(0xffF2551D);
  // final Color secondaryColor = Color(0xff3
  @override
  void initState() {
    ConNotifier conNotifier = Provider.of<ConNotifier>(context, listen: false);
    getShare(conNotifier);
ConNotifier2 conNotifier2 = Provider.of<ConNotifier2>(context, listen: false);
    getShare2(conNotifier2);
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ConNotifier conNotifier = Provider.of<ConNotifier>(context);
    ConNotifier2 conNotifier2 = Provider.of<ConNotifier2>(context);
 
    //Auto playing carousel
    final CarouselSlider autoPlayDemo = CarouselSlider(
      viewportFraction: 0.9,
      aspectRatio: 2.2,
      autoPlay: true,
      enlargeCenterPage: true,
      items: imgList.map(
        (url) {
          CommonThings.size = MediaQuery.of(context).size;
          return Container(
            margin: EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              child: Image.network(
                url,
                fit: BoxFit.cover,
                width: 1000.0,
              ),
            ),
          );
        },
      ).toList(),
    );

    return Scaffold(
      backgroundColor: Colors.white30,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              overflow: Overflow.visible,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 522.0,
                  decoration: BoxDecoration(
                      gradient: new LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xff5A45A5), Colors.white30])),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 55)),
                      Container(
                        child: Text(
                          'Welcome',
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontWeight: FontWeight.w600,
                            fontSize: 36,
                            color: purple2,
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 20)),
                      autoPlayDemo,
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(left: 35)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.music_note,
                                  color: orange1,
                                ),
                                Text(
                                  'คอนเสิร์ตเดียวกัน ไปด้วยกัน',
                                  style: TextStyle(
                                    fontFamily: 'Kanit',
                                    // fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: orange1,
                                  ),
                                ),
                                Icon(
                                  Icons.music_note,
                                  color: orange1,
                                ),
                              ],
                            ),
                            Text(
                              'หาเพื่อนร่วมทางไปดูดนตรี แล้วมาแชร์ค่าเดินทางกัน',
                              style: TextStyle(
                                fontFamily: 'Kanit',
                                // fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: purple1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: 120,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 4,
                                            offset: Offset(
                                              2.0, // horizontal, move right 10
                                              2.0, // vertical, move down 10
                                            ),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(
                                              Icons.search,
                                              color: purple1,
                                              size: 40,
                                            ),
                                            onPressed: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => Sharefeeds(),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'ค้นหาการแชร์',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: orange1,
                                              fontFamily: 'Kanit',
                                            ),
                                          )
                                        ],
                                      ),
                                      padding: EdgeInsets.only(top: 5),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: 120,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 4,
                                            offset: Offset(
                                              2.0, // horizontal, move right 10
                                              2.0, // vertical, move down 10
                                            ),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(
                                              Icons.directions_car,
                                              color: purple1,
                                              size: 40,
                                            ),
                                            onPressed: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => Driverregis(),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'สร้างการแชร์',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: orange1,
                                              fontFamily: 'Kanit',
                                            ),
                                          ),
                                        ],
                                      ),
                                      padding: EdgeInsets.only(top: 5),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              constraints: BoxConstraints.expand(width: 411, height: 500),
              margin: EdgeInsets.only(bottom: 30, left: 30, right: 30),
              padding: EdgeInsets.symmetric(vertical: 5),
              color: Colors.transparent,
              child: DefaultTabController(
                
                  //ขนาดกล่อง
                  length: 2,
                  child: Scaffold(
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
                              borderRadius: BorderRadius.circular(40),
                              color: Color(0xffA99CD9)),
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
                                      icon: Icon(FontAwesomeIcons.music),
                                    ),
                                    Padding(padding: EdgeInsets.only(left: 10)),
                                    Text('กำลังจะมาถึง',
                                        style: TextStyle(fontFamily: 'Kanit'))
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
                                    icon: Icon(FontAwesomeIcons.music),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10)),
                                  Text('คอนเสิร์ตทั้งหมด',
                                      style: TextStyle(fontFamily: 'Kanit'))
                                ],
                              ),
                            ),
                           
                          ],
                        ),
                      ),
                    ),
                    body: TabBarView(children: [
                      ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              conNotifier.currentShare =
                                  conNotifier.shareList[index];
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return Detailcon();
                                
                              }));
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(top: 20, left: 15, right: 15),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                      spreadRadius: 2,
                                      offset: Offset(1, 3))
                                ],
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: InkWell(
                                            child: Container(
                                              width: 321,
                                              height: 130,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        const Radius.circular(
                                                            10.0),
                                                    topRight:
                                                        const Radius.circular(
                                                            10.0),
                                                  ),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          conNotifier
                                                              .shareList[index]
                                                              .picurl))),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 10)),
                                        Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10)),
                                                Icon(
                                                  Icons.music_note,
                                                  color: orange1,
                                                  size: 18,
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5)),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      conNotifier
                                                          .shareList[index]
                                                          .nameconshort,
                                                      style: TextStyle(
                                                        fontFamily: 'Kanit',
                                                        color: purple2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Column(
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10)),
                                                        Icon(
                                                          Icons.place,
                                                          color: orange1,
                                                          size: 18,
                                                        ),
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 5)),
                                                        Column(
                                                          children: <Widget>[
                                                            Text(
                                                              conNotifier
                                                                  .shareList[
                                                                      index]
                                                                  .place,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Kanit',
                                                                  color:
                                                                      purple2,
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Column(
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10)),
                                                        Icon(
                                                          Icons.date_range,
                                                          color: orange1,
                                                          size: 18,
                                                        ),
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 5)),
                                                        Column(
                                                          children: <Widget>[
                                                            Text(
                                                              conNotifier
                                                                  .shareList[
                                                                      index]
                                                                  .day,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Kanit',
                                                                  color:
                                                                      purple2,
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 10)),
                                      ]),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: conNotifier.shareList.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            color: Colors.white,
                          );
                        },
                      ),

                      ///**************2222222222222222222222222222222************************** */
                     ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              conNotifier2.currentShare =
                                  conNotifier2.shareList[index];
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return Detailcon2();
                              }));
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(top: 20, left: 15, right: 15),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                      spreadRadius: 2,
                                      offset: Offset(1, 3))
                                ],
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: InkWell(
                                            child: Container(
                                              width: 321,
                                              height: 130,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        const Radius.circular(
                                                            10.0),
                                                    topRight:
                                                        const Radius.circular(
                                                            10.0),
                                                  ),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          conNotifier2
                                                              .shareList[index]
                                                              .picurl))),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 10)),
                                        Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10)),
                                                Icon(
                                                  Icons.music_note,
                                                  color: orange1,
                                                  size: 18,
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5)),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      conNotifier2
                                                          .shareList[index]
                                                          .nameconshort,
                                                      style: TextStyle(
                                                        fontFamily: 'Kanit',
                                                        color: purple2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Column(
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10)),
                                                        Icon(
                                                          Icons.place,
                                                          color: orange1,
                                                          size: 18,
                                                        ),
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 5)),
                                                        Column(
                                                          children: <Widget>[
                                                            Text(
                                                              conNotifier2
                                                                  .shareList[
                                                                      index]
                                                                  .place,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Kanit',
                                                                  color:
                                                                      purple2,
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Column(
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10)),
                                                        Icon(
                                                          Icons.date_range,
                                                          color: orange1,
                                                          size: 18,
                                                        ),
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 5)),
                                                        Column(
                                                          children: <Widget>[
                                                            Text(
                                                              conNotifier2
                                                                  .shareList[
                                                                      index]
                                                                  .day,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Kanit',
                                                                  color:
                                                                      purple2,
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 10)),
                                      ]),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: conNotifier2.shareList.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            color: Colors.white,
                          );
                        },
                      ),
                      //*************33333333333333333333333333333333333************ */
                   
                    ]),
                  )
                 
                  //     }),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

getShare(ConNotifier conNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Concert')
      // .where('Day', isGreaterThanOrEqualTo: '03/01/2020')
      // .where('Day', isLessThanOrEqualTo: '03/31/2020')
      // .collection('Shareposts')
      .orderBy('Day', descending: false)
      //  .orderBy('Date', descending: false)
      .getDocuments();
  List<Concertview> _conList = [];
  snapshot.documents.forEach((document) {
    Concertview share = Concertview.fromMap(document.data);
    _conList.add(share);
  });
  conNotifier.shareList = _conList;
}
getShare2(ConNotifier2 conNotifier2) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Concert')
      //  .where('Day', isGreaterThanOrEqualTo: '2020-02-31')
      //  .where('Day', isLessThanOrEqualTo: '2020-03-31')
      // .collection('Shareposts')
      //.orderBy('Day', descending: false)
      //  .orderBy('Date', descending: false)
      .getDocuments();
  List<Concertview> _conList = [];
  snapshot.documents.forEach((document) {
    Concertview share = Concertview.fromMap(document.data);
    _conList.add(share);
  });
  conNotifier2.shareList = _conList;
}

