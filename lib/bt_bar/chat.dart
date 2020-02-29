import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mythesis96/firebase/constance.dart';
import 'package:mythesis96/m/user_data.dart';
import 'package:mythesis96/m/user_m.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  static const String id = "CHAT";
  final FirebaseUser user;
  final String userId;
  const Chat({Key key, this.user, this.userId}) : super(key: key);
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  
  var now = new DateTime.now();

  Future<void> callback() async {
    FutureBuilder<void> callback2() {
      future:
      userRef.document(widget.userId).get();
      builder:
      (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          User user = User.fromDoc(snapshot.data);
        }
      };
    }
    // getpicpro() {
    //   return StreamBuilder(
    //     stream: Firestore.instance
    //         .collection('Users')
    //         .document(Provider.of<Userdata>(context).currentUserID)
    //         // .collection('picprofileUrl')
    //         .snapshots(),
    //     builder: (context, snapshot) {
    //       if (!snapshot.hasData) {
    //         return Text('wait');
    //       }
    //       var userDocument = snapshot.data['picprofileUrl'].toString();
    //   },
    //   );
    // }

    if (messageController.text.length > 0) {
      await _firestore.collection('messages').add({
        'text': messageController.text,
        'from': Provider.of<Userdata>(context).currentUserID,
        'date': DateTime.now().toIso8601String().toString(),
        'time': DateFormat("hh:mm").format(now),
      });

      messageController.clear();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  final Color purple1 = Color(0xff5A45A5);
  final Color purple2 = Color(0xff2A1D59);
  final Color orange1 = Color(0xffF2551D);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: purple2),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("แชท",
            style: TextStyle(
              fontFamily: 'Kanit',
              fontWeight: FontWeight.w600,
              color: purple2,
            )),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('messages')
                    .orderBy('date')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  List<DocumentSnapshot> docs = snapshot.data.documents;

                  List<Widget> messages = docs
                      .map((doc) => Message(
                            from: doc.data['from'],
                            text: doc.data['text'],
                            time: doc.data['time'],
                            me: Provider.of<Userdata>(context).currentUserID ==
                                doc.data['from'],
                          ))
                      .toList();

                  return ListView(
                    controller: scrollController,
                    children: <Widget>[
                      ...messages,
                    ],
                  );
                },
              ),
            ),
            Container(
              height: 45,
              margin: EdgeInsets.all(5),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) => callback(),
                      decoration: InputDecoration(
                        hintText: "พิมพ์ข้อความ...",
                        border: const OutlineInputBorder(),
                      ),
                      style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 14,
                        color: purple2,
                      ),
                      controller: messageController,
                    ),
                  ),
                  SendButton(
                    text: "ส่ง",
                    callback: callback,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SendButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;

  const SendButton({Key key, this.text, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(1),
      child: ButtonTheme(
        height: 50.0,
        child: FlatButton(
          color: Color(0xff5A45A5),
          onPressed: callback,
          child: Text(
            text,
            style: TextStyle(
                fontFamily: 'Kanit', fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class Message extends StatelessWidget {
  final String from;
  final String text;
  final String time;
  final bool me;

  const Message({Key key, this.from, this.text, this.me, this.time}) : super(key: key);
  // final Color purple1 = Color(0xff5A45A5);
  // final Color purple2 = Color(0xff2A1D59);
  // final Color orange1 = Color(0xffF2551D);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            from,
            style: TextStyle(
                fontFamily: 'Kanit', fontSize: 11, color: Colors.black45),
          ),
          Material(
            color: me ? Color(0xff5A45A5) : Color(0xffF2551D),
            borderRadius: BorderRadius.circular(10.0),
            elevation: 6.0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Text(
                text,
                style: TextStyle(
                    fontFamily: 'Kanit', fontSize: 14, color: Colors.white),
              ),
            ),
          ),
          Text(
            time,
            style: TextStyle(
                fontFamily: 'Kanit', fontSize: 11, color: Colors.black45),
          ),
        ],
      ),
    );
  }
}

license() {
  BuildContext context;
  if (Provider.of<Userdata>(context).currentUserID != null) {
    return Row(
      children: <Widget>[
        Text('xxxxx',
            style: TextStyle(
              fontFamily: 'Kanit',
              color: Colors.blue,
            )),
        Padding(padding: EdgeInsets.only(left: 10)),
        // Text('*เลขทะเบียนจะแสดงหลังจากการตอบรับ',
        //     style: TextStyle(
        //         fontFamily: 'Kanit', color: Colors.black38, fontSize: 12)),
      ],
    );
  } else {
    Text('-');
  }
}
