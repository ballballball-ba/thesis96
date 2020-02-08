import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingdemo extends StatefulWidget {
  //FirebaseMessaging({Key key}) : super(key: key);
  FirebaseMessagingdemo() : super();

  final String title = 'FirebaseMessaging';

  @override
  State<StatefulWidget> createState() => FirebaseMessagingdemoState();
}

class FirebaseMessagingdemoState extends State<FirebaseMessagingdemo> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
   
   List<Message> _message;
  _getToken() {
    _firebaseMessaging.getToken().then((deviceToken) {
      print('มาย55555device token: $deviceToken');
    });
  }

  _configureFirebaseListeners() {
    _firebaseMessaging.configure(
      onMessage:(Map<String, dynamic> message) async {
        print('onMessage: $message');
        _setMessage(message);
        //_setMessage(message);
      },
      onLaunch:(Map<String, dynamic> message) async {
        print('onLaunch-- $message');
        _setMessage(message);
      },
      onResume:(Map<String, dynamic> message) async {
        print('onResume-- $message');
        _setMessage(message);
      },
    );
  }

  _setMessage(Map<String, dynamic> message){
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    final String mMessage = data['message'];
    setState(() {
      Message m = Message(title, body, mMessage);
    _message.add(m);
    });
    
  }

  @override
  void initState() {
    super.initState();
    _message = List<Message>();
    _getToken();
    _configureFirebaseListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(itemCount: null == _message ? 0 : _message.length,
      itemBuilder: (context, index){
        return Card(
          child: Padding(padding: EdgeInsets.all(15),
          child: Text(_message[index].message,
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 16,
            color: Colors.black,
          ),),),
        );
      },),
      //  child: child,
    );
  }
}

class Message{
  String title;
  String body;
  String message;
  Message(title, body, message){
    this.title = title;
    this.body= body;
    this.message = message;
  }
}
