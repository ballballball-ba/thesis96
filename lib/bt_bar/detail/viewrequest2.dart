import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mythesis96/Api/googlemap.dart';
import 'package:mythesis96/bt_bar/alert_report.dart';
import 'package:mythesis96/bt_bar/chat.dart';
import 'package:mythesis96/bt_bar/homemain.dart';
import 'package:mythesis96/bt_bar/notiac_sc.dart';
import 'package:mythesis96/bt_bar/notifier_share%20request.dart';
import 'package:mythesis96/bt_bar/notifier_share.dart';
import 'package:mythesis96/bt_bar/payment.dart';
import 'package:mythesis96/firebase/constance.dart';
import 'package:mythesis96/firebase/database_up.dart';
import 'package:mythesis96/m/share_posts.dart';
import 'package:mythesis96/m/srervices.dart';
import 'package:mythesis96/m/user_data.dart';
import 'package:mythesis96/m/userlocation.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Viewreqdriv2 extends StatefulWidget {
  Viewreqdriv2({Key key}) : super(key: key);
  static final String id = 'feed_home';
  @override
  _Viewreqdriv2State createState() => _Viewreqdriv2State();
}

class _Viewreqdriv2State extends State<Viewreqdriv2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading: new IconButton(
        //   icon: new Icon(Icons.arrow_back_ios, color: Color(0xff5A45A5)),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
        title: Text("แจ้งเหตุ/ปัญหา",
            style: TextStyle(
                fontFamily: 'Kanit',
                fontWeight: FontWeight.w600,
                color: Color(0xff5A45A5))),
        centerTitle: true,
      ),
      body: ListPage2confirm(),
    );
  }
}

class ListPage2confirm extends StatefulWidget {
  final String userId;

  const ListPage2confirm({Key key, this.userId}) : super(key: key);
  @override
  _ListPage2confirmState createState() => _ListPage2confirmState();
}

class _ListPage2confirmState extends State<ListPage2confirm> {
  Future _data;

  Future getPosts() async {
    var firestore = Firestore.instance;

    QuerySnapshot qn =
        await firestore.collection('Shareconfirm').getDocuments();
    return qn.documents;
  }

  navigatorToDetail(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailShareconfirm(
                  post: post,
                )));
  }

  @override
  void initState() {
    super.initState();

    _data = getPosts();
  }

  @override
  final Color purple1 = Color(0xff5A45A5);
  final Color purple2 = Color(0xff2A1D59);
  final Color orange1 = Color(0xffF2551D);
  Widget build(BuildContext context) {
    return  StreamProvider<UserLocation>(
         builder: (context) => Locationservices().locationStream,
          child: Container(
        child: FutureBuilder(
            future: shareRequestRef.document(widget.userId).get(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (1 + 1 == 2) {
                return FutureBuilder(
                    future: _data,
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Text('กำลังโหลดข้อมูล'),
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (_, index) {
                              return GestureDetector(
                                onTap: () =>
                                    navigatorToDetail(snapshot.data[index]),
                                child: Container(
                                  height: 100,
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
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                                  child: Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: 70,
                                            height: 70,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(60)),
                                            child: CircleAvatar(
                                              radius: 60,
                                              backgroundColor: Colors.grey,
                                              backgroundImage: snapshot
                                                          .data[index]
                                                          .data['picpro'] ==
                                                      null
                                                  ? AssetImage(
                                                      'assets/images/user_placeholder.jpg')
                                                  : NetworkImage(snapshot
                                                      .data[index]
                                                      .data['picpro']),
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(left: 5)),
                                        ],
                                      ),
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
                                                padding: EdgeInsets.only(left: 5),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  snapshot.data[index]
                                                      .data['Concertname'],
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
                                                snapshot.data[index]
                                                    .data['StartPlace'],
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
                                                snapshot
                                                    .data[index].data['Endplace'],
                                                style: TextStyle(
                                                  fontFamily: 'Kanit',
                                                  color: purple2,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      )),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    });
              } else {
                return Center(
                  child: Text('ไม่มีคำร้อง'),
                );
              }
            }),
      ),
    );
  }
}

class DetailShareconfirm extends StatefulWidget {
  final Share concertname;
  final DocumentSnapshot post;
  // DetailShare({Key key}) : super(key: key);
  DetailShareconfirm({this.concertname, this.post});
  @override
  _DetailShareconfirmState createState() => _DetailShareconfirmState();
}

class _DetailShareconfirmState extends State<DetailShareconfirm> {
  final Color purple1 = Color(0xff5A45A5);
  final Color purple2 = Color(0xff2A1D59);
  final Color purple3 = Color(0xffBDAEF2);
  final Color orage1 = Color(0xffF2551D);
  final Color purple4 = Color(0xffA99CD9);

  TextEditingController _maleController = TextEditingController();
  TextEditingController _femaleController = TextEditingController();
//driver

  @override
  Widget build(BuildContext context) {
    // ShareNotifierrequest1 shareNotifier =
    //     Provider.of<ShareNotifierrequest1>(context, listen: false);
    ShareNotifierrequest shareNotifier =
        Provider.of<ShareNotifierrequest>(context, listen: false);

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
    final _formkey = GlobalKey<FormState>();
    _submit() async {
      if (1 + 1 == 2) {
        //Navigator.pushReplacement(context, MaterialPageRoute( builder: (_) => Home(), ));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Home(),
          ),
        );
        _showDialog();
        deleteData();
        deleteData2();
        var now = new DateTime.now();
        Notishare notishare = Notishare(
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

          timestamp: DateFormat("dd-MM-yyyy hh:mm:ss").format(now),
          authorId: Provider.of<Userdata>(context).currentUserID,
        );
        DatabaseSer.createNotisharem(notishare);
        // DatabaseSer.createCar(car);

        // รีเซทข้อมูลให้ว่างเหมือนเดิม

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

    return StreamProvider<UserLocation>(
      builder: (context) => Locationservices().locationStream,
          child: Scaffold(
        backgroundColor: purple3,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: purple2),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("รายละเอียดการแชร์ (กำลังดำเนินการ)",
              style: TextStyle(
                fontFamily: 'Kanit',
                fontWeight: FontWeight.w600,
                color: purple2,
              )),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 20.0),

          // width: 500,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(50.0),
              topRight: const Radius.circular(50.0),
              // bottomLeft: const Radius.circular(10.0),
              // bottomRight: const Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 4,
                offset: Offset(
                  5.0, // horizontal, move right 10
                  4.0, // vertical, move down 10
                ),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Container(
              height: 970,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(25),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "รายละเอียดการแชร์ (กำลังดำเนินการ)",
                            style: TextStyle(
                              fontFamily: 'Kanit',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: purple2,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Divider(
                          color: Colors.black38,
                        ),
                        Wrap(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        width: 100,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 2.0,
                                              offset: Offset(2, 0),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(
                                                Icons.chat,
                                                color: purple1,
                                                size: 40,
                                              ),
                                              onPressed: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => Chat(
                                                    
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'แชท',
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
                                        width: 100,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 2.0,
                                              offset: Offset(2, 0),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(
                                                FontAwesomeIcons
                                                    .exclamationTriangle,
                                                color: purple1,
                                                size: 35,
                                              ),
                                              onPressed: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => Alertreport(),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'แจ้งปัญหา/แจ้งเหตุ',
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
                                        width: 100,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 2.0,
                                              offset: Offset(2, 0),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(
                                                Icons.call,
                                                color: purple1,
                                                size: 40,
                                              ),
                                              onPressed: _launchURL,
                                            ),
                                            Text(
                                              '191',
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
                              ],
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 10)),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          Icons.music_note,
                                          color: orange1,
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                        ),
                                        Text(
                                          'ชื่อคอนเสิร์ต',
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: 30),
                                        ),
                                        Text(widget.post.data['Concertname'],
                                            style: TextStyle(
                                              fontFamily: 'Kanit',
                                              color: purple1,
                                            )),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          Icons.music_note,
                                          color: orange1,
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'จุดเริ่มต้น',
                                              style: TextStyle(
                                                fontFamily: 'Kanit',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: purple2,
                                              ),
                                            ),
                                            Text(widget.post.data['StartPlace'],
                                                style: TextStyle(
                                                  fontFamily: 'Kanit',
                                                  color: purple1,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          Icons.music_note,
                                          color: orange1,
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'ปลายทาง',
                                              style: TextStyle(
                                                fontFamily: 'Kanit',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: purple2,
                                              ),
                                            ),
                                            Text(widget.post.data['Endplace'],
                                                style: TextStyle(
                                                  fontFamily: 'Kanit',
                                                  color: purple1,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          Icons.date_range,
                                          color: orange1,
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'วันและเวลา',
                                              style: TextStyle(
                                                fontFamily: 'Kanit',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: purple2,
                                              ),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text(widget.post.data['Date'],
                                                    style: TextStyle(
                                                      fontFamily: 'Kanit',
                                                      color: purple1,
                                                    )),
                                                Text(' - '),
                                                Text(widget.post.data['Time'],
                                                    style: TextStyle(
                                                      fontFamily: 'Kanit',
                                                      color: purple1,
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          Icons.attach_money,
                                          color: orange1,
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'ราคาต่อที่นั่ง',
                                              style: TextStyle(
                                                fontFamily: 'Kanit',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: purple2,
                                              ),
                                            ),
                                            Text(widget.post.data['Price'],
                                                style: TextStyle(
                                                  fontFamily: 'Kanit',
                                                  color: purple1,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.venusMars,
                                          color: orange1,
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'เพศชาย',
                                              style: TextStyle(
                                                fontFamily: 'Kanit',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: purple2,
                                              ),
                                            ),
                                            Text(widget.post.data['Seatyou'],
                                                style: TextStyle(
                                                  fontFamily: 'Kanit',
                                                  color: purple1,
                                                )),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 30),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'เพศหญิง',
                                              style: TextStyle(
                                                fontFamily: 'Kanit',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: purple2,
                                              ),
                                            ),
                                            Text(widget.post.data['Seatyou2'],
                                                style: TextStyle(
                                                  fontFamily: 'Kanit',
                                                  color: purple1,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          Icons.airline_seat_legroom_normal,
                                          color: orange1,
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'ที่นั่งว่าง',
                                              style: TextStyle(
                                                fontFamily: 'Kanit',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: purple2,
                                              ),
                                            ),
                                            Text(widget.post.data['Seat'],
                                                style: TextStyle(
                                                  fontFamily: 'Kanit',
                                                  color: purple1,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.car,
                                          color: orange1,
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'รถ',
                                              style: TextStyle(
                                                fontFamily: 'Kanit',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: purple2,
                                              ),
                                            ),
                                            Text(widget.post.data['Brandcar'],
                                                style: TextStyle(
                                                  fontFamily: 'Kanit',
                                                  color: purple1,
                                                )),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 50),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'สีรถ',
                                                style: TextStyle(
                                                  fontFamily: 'Kanit',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  color: purple2,
                                                ),
                                              ),
                                              Text(widget.post.data['Color'],
                                                  style: TextStyle(
                                                    fontFamily: 'Kanit',
                                                    color: purple1,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.venusMars,
                                          color: orange1,
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'เลขทะเบียน',
                                              style: TextStyle(
                                                fontFamily: 'Kanit',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: purple2,
                                              ),
                                            ),
                                            Text(widget.post.data['licensecar'],
                                                style: TextStyle(
                                                  fontFamily: 'Kanit',
                                                  color: purple1,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.fileAlt,
                                          color: orange1,
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'รายละเอียด',
                                              style: TextStyle(
                                                fontFamily: 'Kanit',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: purple2,
                                              ),
                                            ),
                                            Text(widget.post.data['details'],
                                                style: TextStyle(
                                                  fontFamily: 'Kanit',
                                                  color: purple1,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(child: FireMap()
                                    ),
                                    Divider(),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.male,
                                          color: orange1,
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'จำนวนคนทั้งหมด',
                                                  style: TextStyle(
                                                    fontFamily: 'Kanit',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                    color: purple2,
                                                  ),
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Text('คนแชร์ (คนขับ)',
                                                        style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            color: orage1,
                                                            fontSize: 14)),
                                                            Padding(padding: EdgeInsets.only(left: 5)),
                                                    Text('ชาย',
                                                        style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            color: orage1,
                                                            fontSize: 14)),
                                                            Padding(padding: EdgeInsets.only(left: 3)),
                                                    Text(
                                                        widget.post
                                                            .data['Seatyou'],
                                                        style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            color: orage1,
                                                            fontSize: 14)),
                                                             Padding(padding: EdgeInsets.only(left: 5)),
                                                              Text('หญิง',
                                                        style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            color: orage1,
                                                            fontSize: 14)),
                                                            Padding(padding: EdgeInsets.only(left: 3)),
                                                    Text(
                                                        widget.post
                                                            .data['Seatyou2'],
                                                        style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            color: orage1,
                                                            fontSize: 14)),
                                                  ],
                                                ),
                                                 Row(
                                                  children: <Widget>[
                                                    Text('คนขอร่วมการแชร์ (คนนั่ง)',
                                                        style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            color: orage1,
                                                            fontSize: 14)),
                                                            Padding(padding: EdgeInsets.only(left: 5)),
                                                    Text('ชาย',
                                                        style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            color: orage1,
                                                            fontSize: 14)),
                                                            Padding(padding: EdgeInsets.only(left: 3)),
                                                    Text(
                                                        widget.post
                                                            .data['Seatreqmale'],
                                                        style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            color: orage1,
                                                            fontSize: 14)),
                                                             Padding(padding: EdgeInsets.only(left: 5)),
                                                              Text('หญิง',
                                                        style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            color: orage1,
                                                            fontSize: 14)),
                                                            Padding(padding: EdgeInsets.only(left: 3)),
                                                    Text(
                                                        widget.post
                                                            .data['Seatreqfemale'],
                                                        style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            color: orage1,
                                                            fontSize: 14)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20)),
                                          ],
                                        ),
                                      ],
                                    ),

                                    Divider(),

                                    // Row(
                                    //   crossAxisAlignment: CrossAxisAlignment.start,
                                    //   children: <Widget>[
                                    //     Padding(
                                    //       padding: EdgeInsets.only(left: 30),
                                    //     ),
                                    //     Text(shareNotifier.currentShare.startplace),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // margin: EdgeInsets.only(bottom: 40),
                    constraints: BoxConstraints.expand(height: 55, width: 340),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: purple1),
                      child: FlatButton(
                        onPressed: _submit,
                        //  () {
                        //    print('ยืนยัน');
                        //  },

                        // onPressed: _submit,
                        child: Text('เสร็จสิ้นการแชร์',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Kanit',
                              fontSize: 22,
                            )),
                      ),
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(top: 20, bottom: 20),
                  //   constraints: BoxConstraints.expand(height: 55, width: 340),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(30),
                  //         color: Colors.black38),
                  //     child: FlatButton(
                  //       onPressed: () {
                  //         deleteData();
                  //         print('เรียบร้อย');
                  //       },

                  //       // onPressed: _submit,
                  //       child: Text('ปฏิเสธคำขอ',
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontFamily: 'Kanit',
                  //             fontSize: 22,
                  //           )),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  final databaseReference = Firestore.instance;
  void deleteData() {
    databaseReference
        .collection('Shareconfirm')
        .getDocuments()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
        ds.reference.delete();
      }
    });
    
  }
  void deleteData2() {
    databaseReference
        .collection('chat')
        .getDocuments()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
        ds.reference.delete();
      }
    });
    
  }
 _launchURL() async {
    const url = 'tel:191';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  void _showDialog() {
    // flutter defined function
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
                "ยืนยันการร่วมเดินทาง",
                style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 18,
                    color: purple2,
                    fontWeight: FontWeight.w600),
              ),
              content: Column(
                children: <Widget>[
                  Text(
                    "ตรวจสอบรายละเอียดได้ที่ 'การแชร์ของฉัน'",
                    style: TextStyle(fontFamily: 'Kanit', color: orage1),
                  ),
                  Icon(FontAwesomeIcons.spinner, size: 40, color: orage1)
                ],
              ),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text(
                    "ยืนยัน",
                    style: TextStyle(fontFamily: 'Kanit', color: purple2),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
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
  }
}
//
