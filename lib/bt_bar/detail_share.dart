import 'package:flutter/material.dart';
import 'package:mythesis96/bt_bar/notifier_share.dart';
import 'package:mythesis96/bt_bar/payment.dart';
import 'package:mythesis96/m/share_posts.dart';
import 'package:provider/provider.dart';

class DetailShare extends StatefulWidget {
  final Share concertname;
  // DetailShare({Key key}) : super(key: key);
  DetailShare({this.concertname});
  @override
  _DetailShareState createState() => _DetailShareState();
}

class _DetailShareState extends State<DetailShare> {
  final Color purple1 = Color(0xff5A45A5);
  final Color purple2 = Color(0xff2A1D59);
  final Color orange1 = Color(0xffF2551D);

  @override
  Widget build(BuildContext context) {
    ShareNotifier shareNotifier =
        Provider.of<ShareNotifier>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: purple2),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("รายละเอียดการแชร์",
            style: TextStyle(
              fontFamily: 'Kanit',
              fontWeight: FontWeight.w600,
              color: purple2,
            )),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20.0, left: 15, right: 15),

        // width: 500,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(
                2.0, // horizontal, move right 10
                2.0, // vertical, move down 10
              ),
            ),
          ],
        ),
        child: Container(
          height: 500,
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "รายละเอียดการแชร์",
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
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 30),
                                    ),
                                    Text(shareNotifier.currentShare.concertname,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        Text(
                                            shareNotifier
                                                .currentShare.startplace,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        Text(
                                            shareNotifier.currentShare.endplace,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            Text(
                                                shareNotifier.currentShare.date,
                                                style: TextStyle(
                                                  fontFamily: 'Kanit',
                                                  color: purple1,
                                                )),
                                            Text(' - '),
                                            Text(
                                                shareNotifier.currentShare.time,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        Text(shareNotifier.currentShare.price,
                                            style: TextStyle(
                                              fontFamily: 'Kanit',
                                              color: purple1,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider()
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

                          // ListTile(
                          //   leading: Icon(Icons.person),
                          //   title: Text('username'),
                          //  // subtitle: Text(user.email),
                          // ),
                          // ListTile(
                          //   leading: Icon(Icons.music_note),
                          //   title: Text("ชื่อคอนเสิร์ต"),
                          //   subtitle: Text(shareNotifier.currentShare.concertname),
                          // //  subtitle: Text(user.gender),
                          // ),
                          //  ListTile(
                          //   leading: Icon(Icons.map),
                          //   title: Text("จุดเริ่มต้น"),
                          //   subtitle: Text(shareNotifier.currentShare.startplace),
                          // //  subtitle: Text(user.gender),
                          // ),
                          //  ListTile(
                          //   leading: Icon(Icons.map),
                          //   title: Text("ปลายทาง"),
                          //   subtitle: Text(shareNotifier.currentShare.endplace),
                          // //  subtitle: Text(user.gender),
                          // ),
                          //  ListTile(
                          //   leading: Icon(Icons.attach_money),
                          //   title: Text("ราคา"),
                          //   subtitle: Text(shareNotifier.currentShare.price),
                          // //  subtitle: Text(user.gender),
                          // ),
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
                      color: Color(0xff5A45A5)),
                  child: FlatButton(
                    onPressed: () {},

                    // onPressed: _submit,
                    child: Text('ขอร่วมเดินทาง',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Kanit',
                          fontSize: 22,
                        )),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                constraints: BoxConstraints.expand(height: 55, width: 170),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xff5A45A5)),
                  child: FlatButton(
                    onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Payment(),
                                ),
                              ),

                    // onPressed: _submit,
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
    );
  }
}
//
