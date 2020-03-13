import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:mythesis96/bt_bar/notifier_share.dart';
import 'package:mythesis96/bt_bar/sharefeeds/SharefeedsIn1.dart';
import 'package:mythesis96/bt_bar/sharefeeds/SharefeedsIn10.dart';
import 'package:mythesis96/bt_bar/sharefeeds/SharefeedsIn2.dart';
import 'package:mythesis96/bt_bar/sharefeeds/SharefeedsIn3.dart';
import 'package:mythesis96/bt_bar/sharefeeds/SharefeedsIn4.dart';
import 'package:mythesis96/bt_bar/sharefeeds/SharefeedsIn5.dart';
import 'package:mythesis96/bt_bar/sharefeeds/SharefeedsIn6.dart';
import 'package:mythesis96/bt_bar/sharefeeds/SharefeedsIn7.dart';
import 'package:mythesis96/bt_bar/sharefeeds/SharefeedsIn8.dart';
import 'package:mythesis96/bt_bar/sharefeeds/SharefeedsIn9.dart';
import 'package:mythesis96/bt_bar/sharefeeds/shareall.dart';
import 'package:mythesis96/m/share_posts.dart';
import 'package:provider/provider.dart';
import 'package:mythesis96/firebase/database_up.dart';

class Sharefeeds extends StatefulWidget {
  final String userId;
  Sharefeeds({Key key,this.userId}) : super(key: key);

  @override
  _SharefeedsState createState() => _SharefeedsState();
}

class _SharefeedsState extends State<Sharefeeds>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // ShareNotifier shareNotifier =
    //     Provider.of<ShareNotifier>(context, listen: false);
    // getShare(shareNotifier);
    // ShareNotifier2 shareNotifier2 =
    //     Provider.of<ShareNotifier2>(context, listen: false);

    // getShare2(shareNotifier2);

    // ShareNotifier3 shareNotifier3 =
    //     Provider.of<ShareNotifier3>(context, listen: false);

    // getShare3(shareNotifier3);

    _tabController = TabController(vsync: this, length: connamebar.length);
    super.initState();
  }

// var connamebar =['IU','HYUKOH','AB6IX','NOEL','GOT7','LIAM',
//   'GREENDAY','PARADOX','BAEKHO','JANGDONG'];
  var connamebar = [
    'มีนาคม',
    'เมษายน',
    'พฤษภาคม',
    'มิถุนายน',
    'กรกฎาคม',
    'สิงหาคม',
    'กันยายน',
    'ตุลาคม',
    'พฤศจิกายน',
    'ธันวาคม',
    'ธันวาคม'
  ];

  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void getData() {
    final databaseReference = Firestore.instance;
    databaseReference
        .collection("Concert")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data['NameCon']}}'));
      //snapshot.documents
      //     for (var index = 0; index < da.length; ++index) {
      // final value = values[index];
      // }
    });
  }

  final Color purple1 = Color(0xff5A45A5);
  final Color purple2 = Color(0xff2A1D59);
  final Color orange1 = Color(0xffF2551D);
  @override
  Widget build(BuildContext context) {
    ShareNotifier shareNotifier = Provider.of<ShareNotifier>(context);
    ShareNotifier2 shareNotifier2 = Provider.of<ShareNotifier2>(context);
    ShareNotifier3 shareNotifier3 = Provider.of<ShareNotifier3>(context);

    final Color purple1 = Color(0xff5A45A5);
    final Color purple2 = Color(0xff2A1D59);
    final Color purple3 = Color(0xffBDAEF2);
    final Color orage1 = Color(0xffF2551D);
    final Color purple4 = Color(0xffA99CD9);

    void somebar() {
      if (_tabController == connamebar[0]) {
        ShareNotifier shareNotifier =
            Provider.of<ShareNotifier>(context, listen: false);
        getShare(shareNotifier);
      } else if (_tabController == connamebar[1]) {
        ShareNotifier2 shareNotifier2 =
            Provider.of<ShareNotifier2>(context, listen: false);
        getShare(shareNotifier);
      } else if (_tabController == connamebar[2]) {
        ShareNotifier3 shareNotifier3 =
            Provider.of<ShareNotifier3>(context, listen: false);
        getShare(shareNotifier);
      }
    }

    return DefaultTabController(
      initialIndex: 0,
      length: 10,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text('การแชร์',
              style:
                  TextStyle(fontFamily: 'Kanit', color: purple2,fontWeight: FontWeight.w600)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: new Size(30.0, 30.0),
            child: Container(
              height: 40,
              child: TabBar(
                controller: _tabController,
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
                        Text('ทั้งหมด', style: TextStyle(fontFamily: 'Kanit'))
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
                        Text(connamebar[0],
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
                        Text(connamebar[1],
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
                        Text(connamebar[2],
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
                        Text(connamebar[3],
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
                        Text(connamebar[4],
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
                        Text(connamebar[5],
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
                        Text(connamebar[6],
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
                        Text(connamebar[7],
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
                        Text(connamebar[8],
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
                        Text(connamebar[9],
                            style: TextStyle(fontFamily: 'Kanit'))
                      ],
                    ),
                  ),
                  //  Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: <Widget>[
                  //       Tab(
                  //         icon: Icon(FontAwesomeIcons.music),
                  //       ),
                  //       Padding(padding: EdgeInsets.only(left: 10)),
                  //       Text('เดือน', style: TextStyle(fontFamily: 'Kanit'))
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            ///*******************************11111111111111111111111111111111 */
            Container(
              child: Shareall(),
            ),

            ///*******************************222222222222222222222222222222222222222222222222222 */
            Container(
              child: SharefeedsIn1(),
            ),

            ///*******************************333333333333333333333333333333333333333333 */
            Container(
              child: SharefeedsIn2(),
            ),

            ///*******************************444444444444 */
            Container(
              child: SharefeedsIn3(),
            ),

            ///*******************************555555555 */
            Container(
              child: SharefeedsIn4(),
            ),
            Container(
              child: SharefeedsIn5(),
            ),
            Container(
              child: SharefeedsIn6(),
            ),
            Container(
              child: SharefeedsIn7(),
            ),
            Container(
              child: SharefeedsIn8(),
            ),
            Container(
              child: SharefeedsIn9(),
            ),
            Container(
              child: SharefeedsIn10(),
            ),
            // Container(
            //   child: SharefeedsIn5(),
            // ),
          ],
        ),
      ),
    );
  }
}

getShare(ShareNotifier shareNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Shareposts')
      // .collection('Shareposts')
      .orderBy('Seat', descending: true)
      .getDocuments();
  List<Share> _shareList = [];
  snapshot.documents.forEach((document) {
    Share share = Share.fromMap(document.data);
    _shareList.add(share);
  });
  shareNotifier.shareList = _shareList;
}
