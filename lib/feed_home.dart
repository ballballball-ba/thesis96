import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mythesis96/firebase/auth_service.dart';
import 'package:mythesis96/m/driver_regit.dart';
import 'package:mythesis96/firebase/database_up.dart';
import 'package:mythesis96/m/user_data.dart';
import 'package:mythesis96/m/user_m.dart';
import 'package:provider/provider.dart';

class Feedhome extends StatefulWidget {
  static final String id = 'feed_home';
  final String currentUserID;
  Feedhome({this.currentUserID});

  @override
  _FeedhomeState createState() => _FeedhomeState();
}

class _FeedhomeState extends State<Feedhome> {
  @override
  Widget build(BuildContext context) {
    CommonThings.size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      // backgroundColor: Colors.blueGrey,
      body: Container(
        //ครอบทั้งหมด
        constraints: BoxConstraints.expand(height: 800, width: 450),
        child: StreamBuilder(
            stream: Firestore.instance.collection('Concert').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text('is somthing worg about database.....');
              }
              int length = snapshot.data.documents.length;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, //column
                  mainAxisSpacing: 0.2, // space
                  childAspectRatio: 1.8,
                ),
                itemCount: length,
                padding: EdgeInsets.all(10),
                itemBuilder: (_, int index) {
                  final DocumentSnapshot doc = snapshot.data.documents[index];
                  return new Container(
                    child: Card(
                      margin: EdgeInsets.all(8),
                      //เงาเหมือนกด
                      // elevation: 10,
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            child: Container(
                              width: 393,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        '${doc.data['PicURL']}' +
                                            '?alt-media')),
                              ),
                              // child:  Image.network('${doc.data['PicURL']}'+ '?alt-media'),
                              //child: Image.network('https://korea.tlcthai.com/wp-content/uploads/%E0%B9%84%E0%B8%AD%E0%B8%A2%E0%B8%B9IU.jpg'),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                doc.data['NameCon'],
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 14,
                                ),
                              ),
                              subtitle: Text(
                                doc.data['Place'],
                                style: TextStyle(
                                    color: Colors.deepPurple, fontSize: 12),
                              ),

                              //  subtitle: Text(
                              //   doc.data['Day'],
                              //   style: TextStyle(
                              //       color: Colors.deepPurple, fontSize: 12),
                              // ),
                              onTap: () {
                                print('concert');
                              },
                            ),
                          ),
                          Row(
                            
                            mainAxisAlignment: MainAxisAlignment.end,                          
                            children: <Widget>[                           
                              Text(
                                doc.data['Day'],
                                style: TextStyle(
                                    color: Colors.deepPurple, fontSize: 12),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
      ),
      //  Center(
      //   child: FlatButton( //logout funtion
      //     onPressed: () => AuthService.logout(),
      //     child: Text('LOGOUT'),
      //   ),
      // )
    );
  }
}

class CommonThings {
  static Size size;
}
