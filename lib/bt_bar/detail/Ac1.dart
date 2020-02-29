import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Ac1 extends StatefulWidget {
  Ac1({Key key}) : super(key: key);
  static final String id = 'feed_home';
  @override
  _Ac1State createState() => _Ac1State();
}

class _Ac1State extends State<Ac1> {
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
      body: ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future _data;

  Future getPosts() async {
    var firestore = Firestore.instance;

    QuerySnapshot qn =
        await firestore.collection('ShareRequest').getDocuments();
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

  @override
  final Color purple1 = Color(0xff5A45A5);
  final Color purple2 = Color(0xff2A1D59);
  final Color orange1 = Color(0xffF2551D);
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
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
                      onTap: () => navigatorToDetail(snapshot.data[index]),
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
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black),
                                      borderRadius: BorderRadius.circular(60)),
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Colors.grey,
                                    backgroundImage: snapshot
                                                .data[index].data['picpro'] ==
                                            null
                                        ? AssetImage(
                                            'assets/images/user_placeholder.jpg')
                                        : NetworkImage(snapshot
                                            .data[index].data['picpro']),
                                  ),
                                ),
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
                                      snapshot.data[index].data['Seatyou2'],
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
                                      snapshot.data[index].data['Seatyou'],
                                      style: TextStyle(
                                        fontFamily: 'Kanit',
                                        color: purple2,
                                      ),
                                    )
                                  ],
                                ),
                                Padding(padding: EdgeInsets.only(left: 5)),
                              ],
                            ),
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
                                        snapshot
                                            .data[index].data['Concertname'],
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
                                      snapshot.data[index].data['StartPlace'],
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
                                      snapshot.data[index].data['Endplace'],
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
                                          snapshot.data[index].data['Seat'],
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
                                          snapshot.data[index].data['Price'],
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
                                      snapshot.data[index].data['Date'],
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
                                              padding: EdgeInsets.only(left: 5),
                                            ),
                                            Text(
                                              snapshot.data[index].data['Time'],
                                              style: TextStyle(
                                                fontFamily: 'Kanit',
                                                color: purple2,
                                              ),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(left: 120)),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  'รอการตอบรับ',
                                                  style: TextStyle(
                                                    fontFamily: 'Kanit',
                                                    color: purple1,
                                                  ),
                                                ),
                                              ],
                                            ),
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
          }),
    );
  }
}

class DetailPage extends StatefulWidget {
  final DocumentSnapshot post;
  DetailPage({this.post});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final Color purple1 = Color(0xff5A45A5);
  final Color purple2 = Color(0xff2A1D59);
  final Color purple3 = Color(0xffBDAEF2);
  final Color orage1 = Color(0xffF2551D);
  final Color purple4 = Color(0xffA99CD9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Color(0xff5A45A5)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.post.data['Topic'],
            style: TextStyle(
                fontFamily: 'Kanit',
                fontWeight: FontWeight.w600,
                color: Color(0xff5A45A5))),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        width: 400,
        height: 400,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: <Widget>[
                Text(widget.post.data['Topic'],
                    style: TextStyle(
                        fontFamily: 'Kanit',
                        fontWeight: FontWeight.w600,
                        color: Color(0xff5A45A5))),
                Divider(),
                Padding(padding: EdgeInsets.only(top: 5, bottom: 5)),
                Flexible(
                  child: Text(widget.post.data['Text'],
                      style: TextStyle(fontFamily: 'Kanit', color: orage1)),
                ),
                Padding(padding: EdgeInsets.only(top: 5, bottom: 5)),
                Text('วันเวลา ที่แจ้งเหตุ/ปัญหา',
                    style: TextStyle(fontFamily: 'Kanit', color: purple1)),
                Text(widget.post.data['Timestamp'],
                    style: TextStyle(fontFamily: 'Kanit', color: orage1)),
                Padding(padding: EdgeInsets.only(top: 5, bottom: 5)),
                Text('ID ผู้แจ้งเหตุ/ปัญหา',
                    style: TextStyle(fontFamily: 'Kanit', color: purple1)),
                Text(widget.post.data['AuthorId'],
                    style: TextStyle(fontFamily: 'Kanit', color: orage1)),
              ],
              //  (widget.post.data['Timestamp'].toDate()),
            ),
          ),
        ),
      ),
    );
  }
}
