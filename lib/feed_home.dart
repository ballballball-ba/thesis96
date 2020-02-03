import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mythesis96/bt_bar/driver_regis.dart';
import 'package:mythesis96/bt_bar/edit_profile.dart';
import 'package:mythesis96/bt_bar/sharefeeds.dart';
import 'package:mythesis96/firebase/auth_service.dart';
import 'package:mythesis96/firebase/constance.dart';
import 'package:mythesis96/m/driver_regit.dart';
import 'package:mythesis96/firebase/database_up.dart';
import 'package:mythesis96/m/user_data.dart';
import 'package:mythesis96/m/user_m.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'https://i2.wp.com/www.korseries.com/wp-content/uploads/2019/10/2019-iu-tour-concert-love-poem.jpg?fit=1000%2C596&ssl=1',
  'https://www.beartai.com/wp-content/uploads/2019/12/Rockland.jpg',
  'https://promotions.co.th/wp-content/uploads/2019/11/kjoy-3-horz.jpg',
  'https://m.thaiticketmajor.com/img_poster/prefix_1/2006/5006/atom-house-of-hearts-concert-2020-5dfb2eac4bfcb-l.jpg'
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
  Widget build(BuildContext context) {
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
                                          ),Text(
                                      'สร้างการแชร์',
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
                                            'ค้นหาการแชร์',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: orange1,
                                              fontFamily: 'Kanit',
                                            ),
                                          ),
                                        ],
                                      ),
                                      padding: EdgeInsets.only(top:5),
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
              //ขนาดกล่อง
              constraints: BoxConstraints.expand(width: 411, height: 500),
              margin: EdgeInsets.only(bottom: 30, left: 30, right: 30),
              padding: EdgeInsets.symmetric(vertical: 5),
              child: StreamBuilder(
                  stream: Firestore.instance
                      .collection('Concert')
                      // .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Text('is somthing worg about database.....');
                    }
                    int length = snapshot.data.documents.length;
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1, //column
                        mainAxisSpacing: 1, // space
                        childAspectRatio: 1.8,
                      ),
                      itemCount: length,
                      // padding: EdgeInsets.all(10),
                      itemBuilder: (_, int index) {
                        final DocumentSnapshot doc =
                            snapshot.data.documents[index];
                        return new Container(
                          child: Container(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
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
                                        borderRadius: BorderRadius.circular(10),
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
                                          fontSize: 12,
                                        ),
                                      ),
                                      subtitle: Text(
                                        doc.data['Place'],
                                        style: TextStyle(
                                            color: Colors.deepPurple,
                                            fontSize: 10),
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
                                      Container(
                                        margin: EdgeInsets.only(right: 5),
                                        child: Text(
                                          doc.data['Day'],
                                          style: TextStyle(
                                              color: Colors.deepPurple,
                                              fontSize: 10),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );

    // appBar: AppBar(
    //   backgroundColor: Colors.transparent,
    //   elevation: 0,
    // ),
    //       body: new SingleChildScrollView(
    //         padding: EdgeInsets.symmetric(vertical: 15.0),
    //         child: Column(
    //           children: <Widget>[
    //             Padding(padding: EdgeInsets.only(top: 50)),
    //             Stack(
    //                 alignment: Alignment.center,
    //                 overflow: Overflow.visible,
    //                 children: <Widget>[
    //                   Container(
    //                     width: MediaQuery.of(context).size.width,
    //                     height: 300,
    //                     decoration: BoxDecoration(
    //                         gradient: new LinearGradient(
    //                             begin: Alignment.topCenter,
    //                             end: Alignment.bottomCenter,
    //                             colors: [Colors.yellow[700], Color(0xffFbEFEE)])),
    //                   ),
    //                   Positioned(
    //                     top: 50,
    //                     right: 20,
    //                     left: 20,
    //                     child: Row(
    //                       children: <Widget>[
    //                         Padding(
    //                             padding: EdgeInsets.only(
    //                           left: 35,
    //                         )),
    //                         Text(
    //                           'Welcome',
    //                           style: TextStyle(fontSize: 26),
    //                         ),
    //                       ],
    //                     ),
    //                   )
    //                 ]),
    //             Padding(padding: EdgeInsets.only(bottom: 35)),
    //             autoPlayDemo,
    //             Container(
    //               margin: EdgeInsets.only(top: 20),
    //               child: Container(
    //                 margin: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                   children: <Widget>[
    //                     Container(
    //                       child: Column(
    //                         children: <Widget>[
    //                           Container(
    //                             width: 120,
    //                             height: 80,
    //                             decoration: BoxDecoration(
    //                               color: Colors.white,
    //                               borderRadius:
    //                                   BorderRadius.all(Radius.circular(20)),
    //                               boxShadow: [
    //                                 BoxShadow(
    //                                   color: Colors.black26,
    //                                   blurRadius: 4,
    //                                   offset: Offset(
    //                                     2.0, // horizontal, move right 10
    //                                     2.0, // vertical, move down 10
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                             child: IconButton(
    //                               icon: Icon(
    //                                 Icons.directions_car,
    //                                 color: purple1,
    //                                 size: 50,
    //                               ),
    //                               onPressed: () => Navigator.push(
    //                                 context,
    //                                 MaterialPageRoute(
    //                                   builder: (_) => Driverregis(),
    //                                 ),
    //                               ),
    //                             ),
    //                             padding: EdgeInsets.all(10),
    //                           ),
    //                           SizedBox(
    //                             height: 4,
    //                           ),
    //                           Text(
    //                             'สร้างการแชร์',
    //                             style: TextStyle(fontSize: 12, color: orange1),
    //                           )
    //                         ],
    //                       ),
    //                     ),
    //                     Container(
    //                       child: Column(
    //                         children: <Widget>[
    //                           Container(
    //                             width: 120,
    //                             height: 80,
    //                             decoration: BoxDecoration(
    //                               color: Colors.white,
    //                               borderRadius:
    //                                   BorderRadius.all(Radius.circular(20)),
    //                               boxShadow: [
    //                                 BoxShadow(
    //                                   color: Colors.black26,
    //                                   blurRadius: 4,
    //                                   offset: Offset(
    //                                     2.0, // horizontal, move right 10
    //                                     2.0, // vertical, move down 10
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                             child: IconButton(
    //                               icon: Icon(
    //                                 Icons.search,
    //                                 color: purple1,
    //                                 size: 50,
    //                               ),
    //                               onPressed: () => Navigator.push(
    //                                 context,
    //                                 MaterialPageRoute(
    //                                   builder: (_) => Sharefeeds(),
    //                                 ),
    //                               ),
    //                             ),
    //                             padding: EdgeInsets.all(10),
    //                           ),
    //                           SizedBox(
    //                             height: 4,
    //                           ),
    //                           Text(
    //                             'ค้นหาการแชร์',
    //                             style: TextStyle(fontSize: 12, color: orange1),
    //                           )
    //                         ],
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             Divider(
    //               color: Colors.black,
    //             ),
    //             Container(
    //               //ขนาดกล่อง
    //               constraints: BoxConstraints.expand(width: 411, height: 500),
    //               margin:
    //                   EdgeInsets.only(top: 10, bottom: 30, left: 30, right: 30),
    //               padding: EdgeInsets.symmetric(vertical: 15),
    //               child: StreamBuilder(
    //                   stream: Firestore.instance
    //                       .collection('Concert')
    //                       // .orderBy('timestamp', descending: true)
    //                       .snapshots(),
    //                   builder: (BuildContext context,
    //                       AsyncSnapshot<QuerySnapshot> snapshot) {
    //                     if (!snapshot.hasData) {
    //                       return Text('is somthing worg about database.....');
    //                     }
    //                     int length = snapshot.data.documents.length;
    //                     return GridView.builder(
    //                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //                         crossAxisCount: 1, //column
    //                         mainAxisSpacing: 1, // space
    //                         childAspectRatio: 1.8,
    //                       ),
    //                       itemCount: length,
    //                       // padding: EdgeInsets.all(10),
    //                       itemBuilder: (_, int index) {
    //                         final DocumentSnapshot doc =
    //                             snapshot.data.documents[index];
    //                         return new Container(
    //                           child: Container(
    //                             child: Card(
    //                               shape: RoundedRectangleBorder(
    //                                 borderRadius: BorderRadius.circular(10.0),
    //                               ),
    //                               margin: EdgeInsets.all(8),
    //                               //เงาเหมือนกด
    //                               // elevation: 10,
    //                               child: Column(
    //                                 children: <Widget>[
    //                                   InkWell(
    //                                     child: Container(
    //                                       width: 393,
    //                                       height: 120,
    //                                       decoration: BoxDecoration(
    //                                         borderRadius:
    //                                             BorderRadius.circular(10),
    //                                         image: DecorationImage(
    //                                             fit: BoxFit.cover,
    //                                             image: NetworkImage(
    //                                                 '${doc.data['PicURL']}' +
    //                                                     '?alt-media')),
    //                                       ),
    //                                       // child:  Image.network('${doc.data['PicURL']}'+ '?alt-media'),
    //                                       //child: Image.network('https://korea.tlcthai.com/wp-content/uploads/%E0%B9%84%E0%B8%AD%E0%B8%A2%E0%B8%B9IU.jpg'),
    //                                     ),
    //                                   ),
    //                                   Expanded(
    //                                     child: ListTile(
    //                                       title: Text(
    //                                         doc.data['NameCon'],
    //                                         style: TextStyle(
    //                                           color: Colors.purple,
    //                                           fontSize: 12,
    //                                         ),
    //                                       ),
    //                                       subtitle: Text(
    //                                         doc.data['Place'],
    //                                         style: TextStyle(
    //                                             color: Colors.deepPurple,
    //                                             fontSize: 10),
    //                                       ),

    //                                       //  subtitle: Text(
    //                                       //   doc.data['Day'],
    //                                       //   style: TextStyle(
    //                                       //       color: Colors.deepPurple, fontSize: 12),
    //                                       // ),
    //                                       onTap: () {
    //                                         print('concert');
    //                                       },
    //                                     ),
    //                                   ),
    //                                   Row(
    //                                     mainAxisAlignment: MainAxisAlignment.end,
    //                                     children: <Widget>[
    //                                       Container(
    //                                         margin: EdgeInsets.only(right: 5),
    //                                         child: Text(
    //                                           doc.data['Day'],
    //                                           style: TextStyle(
    //                                               color: Colors.deepPurple,
    //                                               fontSize: 10),
    //                                         ),
    //                                       )
    //                                     ],
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                           ),
    //                         );
    //                       },
    //                     );
    //                   }),
    //             ),
    //           ],
    //         ),
    //       ),

    //   );
    // }
//////////////////////////////asdasdasdasdasd4654646566*********************
//   Widget build1(BuildContext context) {
//     CommonThings.size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),

//       // backgroundColor: Colors.blueGrey,
//       body: Container(
//         //ครอบทั้งหมด
//         constraints: BoxConstraints.expand(height: 1500, width: 450),
//         child: Container(
//           padding: EdgeInsets.symmetric(vertical: 15),
//           child: StreamBuilder(
//               stream: Firestore.instance.collection('Concert').snapshots(),
//               builder: (BuildContext context,
//                   AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (!snapshot.hasData) {
//                   return Text('is somthing worg about database.....');
//                 }
//                 int length = snapshot.data.documents.length;
//                 return GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 1, //column
//                     mainAxisSpacing: 0.2, // space
//                     childAspectRatio: 1.8,
//                   ),
//                   itemCount: length,
//                   padding: EdgeInsets.all(10),
//                   itemBuilder: (_, int index) {
//                     final DocumentSnapshot doc = snapshot.data.documents[index];
//                     return new Container(
//                       child: Container(
//                         child: Card(
//                           margin: EdgeInsets.all(8),
//                           //เงาเหมือนกด
//                           // elevation: 10,
//                           child: Column(
//                             children: <Widget>[
//                               InkWell(
//                                 child: Container(
//                                   width: 393,
//                                   height: 120,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(5),
//                                     image: DecorationImage(
//                                         fit: BoxFit.cover,
//                                         image: NetworkImage(
//                                             '${doc.data['PicURL']}' +
//                                                 '?alt-media')),
//                                   ),
//                                   // child:  Image.network('${doc.data['PicURL']}'+ '?alt-media'),
//                                   //child: Image.network('https://korea.tlcthai.com/wp-content/uploads/%E0%B9%84%E0%B8%AD%E0%B8%A2%E0%B8%B9IU.jpg'),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: ListTile(
//                                   title: Text(
//                                     doc.data['NameCon'],
//                                     style: TextStyle(
//                                       color: Colors.purple,
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                   subtitle: Text(
//                                     doc.data['Place'],
//                                     style: TextStyle(
//                                         color: Colors.deepPurple, fontSize: 12),
//                                   ),

//                                   //  subtitle: Text(
//                                   //   doc.data['Day'],
//                                   //   style: TextStyle(
//                                   //       color: Colors.deepPurple, fontSize: 12),
//                                   // ),
//                                   onTap: () {
//                                     print('concert');
//                                   },
//                                 ),
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: <Widget>[
//                                   Text(
//                                     doc.data['Day'],
//                                     style: TextStyle(
//                                         color: Colors.deepPurple, fontSize: 12),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }),
//         ),
//       ),
//       //  Center(
//       //   child: FlatButton( //logout funtion
//       //     onPressed: () => AuthService.logout(),
//       //     child: Text('LOGOUT'),
//       //   ),
//       // )
//     );
//   }
// }

//}

// class CurvedBottomClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     // I've taken approximate height of curved part of view
//     // Change it if you have exact spec for it
//     final roundingHeight = size.height * 3 / 5;

//     // this is top part of path, rectangle without any rounding
//     final filledRectangle =
//         Rect.fromLTRB(0, 0, size.width, size.height - roundingHeight);

//     // this is rectangle that will be used to draw arc
//     // arc is drawn from center of this rectangle, so it's height has to be twice roundingHeight
//     // also I made it to go 5 units out of screen on left and right, so curve will have some incline there
//     final roundingRectangle = Rect.fromLTRB(
//         -5, size.height - roundingHeight * 2, size.width + 5, size.height);

//     final path = Path();
//     path.addRect(filledRectangle);

//     // so as I wrote before: arc is drawn from center of roundingRectangle
//     // 2nd and 3rd arguments are angles from center to arc start and end points
//     // 4th argument is set to true to move path to rectangle center, so we don't have to move it manually
//     path.arcTo(roundingRectangle, pi, -pi, true);
//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     // returning fixed 'true' value here for simplicity, it's not the part of actual question, please read docs if you want to dig into it
//     // basically that means that clipping will be redrawn on any changes
//     return true;
//   }
// }
  }
}
