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
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        _setMessage(message);
        //_setMessage(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch-- $message');
        _setMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume-- $message');
        _setMessage(message);
      },
    );
  }

  _setMessage(Map<String, dynamic> message) {
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
      body: ListView.builder(
        itemCount: null == _message ? 0 : _message.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                _message[index].message,
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          );
        },
      ),

      //  child: child,
    );
  }
}

class Message {
  String title;
  String body;
  String message;
  Message(title, body, message) {
    this.title = title;
    this.body = body;
    this.message = message;
  }
}
// import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:mythesis96/Firebasemessaging/locator.dart';
// import 'package:mythesis96/Firebasemessaging/navigation.dart';

// class PushNotificationService {
//   final FirebaseMessaging _fcm = FirebaseMessaging();

//   // final PushNotificationService _pushNotificationService =
//   //     locator<PushNotificationService>();
// final NavigationService _navigationService = locator<NavigationService>();

//   Future initialise() async {
//     // await _pushNotificationService.initialise();
//     if (Platform.isIOS) {
//       _fcm.requestNotificationPermissions(IosNotificationSettings());
//     }

//     _fcm.configure(
//       // เรียกใช้เมื่อ app is n the foregrund and receive push notification
//       onMessage: (Map<String, dynamic> message) async {
//         print("onMessage: $message");
//       },
//       // เรัยกใช้ เมื่อ แอพ ปิดเรียบร้อยและเปิดมาไหม
//       onLaunch: (Map<String, dynamic> message) async {
//         print("onLaunch: $message");
//         _serialiseAndNavigate(message);
//       },
//       //เรียกใช้เมื่อแอพ อยู่ในbackground แล้ว มันเปิดอยู่
//       onResume: (Map<String, dynamic> message) async {
//         print("onResume: $message");
//         _serialiseAndNavigate(message);
//       },
//     );
//   }
//   void _serialiseAndNavigate(Map<String, dynamic> message) {
//     var notificationData = message['data'];
//     var view = notificationData['view'];

//     if (view != null) {
//       // Navigate to the create post view
//       if (view == 'create_post') {

//       }
//       // If there's no view it'll just open the app on the first view
//     }
//   }
// }
