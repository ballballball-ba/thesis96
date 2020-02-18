import 'package:flutter/material.dart';
import 'package:mythesis96/bt_bar/notifier_con.dart';
import 'package:provider/provider.dart';

class Detailcon extends StatefulWidget {
  Detailcon({Key key}) : super(key: key);

  @override
  _DetailconState createState() => _DetailconState();
}

class _DetailconState extends State<Detailcon> {
  final Color purple1 = Color(0xff5A45A5);
  final Color purple2 = Color(0xff2A1D59);
  final Color purple3 = Color(0xffBDAEF2);
  final Color orage1 = Color(0xffF2551D);
  final Color purple4 = Color(0xffA99CD9);

  @override
  Widget build(BuildContext context) {
    ConNotifier conNotifier = Provider.of<ConNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: purple2),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("รายละเอียดคอนเสิร์ต",
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
            bottomLeft: const Radius.circular(20.0),
            bottomRight: const Radius.circular(20.0),
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
            height: 650,
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
                          "รายละเอียดคอนเสิร์ต",
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
                        child: Container(
                          width: 350,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    conNotifier.currentShare.picurl,
                                  ))),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'ชื่อคอนเสิร์ต',
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  color: orage1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  conNotifier.currentShare.namecon,
                                  style: TextStyle(
                                    fontFamily: 'Kanit',
                                    color: purple2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'สถานที่',
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  color: orage1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                conNotifier.currentShare.place,
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  color: purple2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'วันที่แสดง',
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  color: orage1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                conNotifier.currentShare.day,
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  color: purple2,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(left: 20)),
                              Text(
                                conNotifier.currentShare.time,
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  color: purple2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'รายละเอียด',
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  color: orage1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  conNotifier.currentShare.details,
                                  style: TextStyle(
                                    fontFamily: 'Kanit',
                                    color: purple2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
