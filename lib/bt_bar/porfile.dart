import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mythesis96/bt_bar/edit_profile.dart';
import 'package:mythesis96/bt_bar/driver_regis.dart';
import 'package:mythesis96/bt_bar/form_share.dart';
import 'package:mythesis96/m/driver_regit.dart';
import 'package:mythesis96/m/user_m.dart';
import 'package:mythesis96/constance.dart';

class Profile extends StatefulWidget {
  final String userId;

//construtor
  Profile({this.userId});
  //Profile({this.userId2});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final Color purple1 = Color(0xff5A45A5);
  final Color purple2 = Color(0xff2A1D59);
  final Color orange1 = Color(0xffF2551D);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder(
            future: userRef.document(widget.userId).get(),
            //future: testpostsRef.document(widget.userId).get(),
            //  future: userRef2.document(widget.userId).get(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              User user = User.fromDoc(snapshot.data);
              // Post drive = postsRef.document('k');
//print(user.gender);
//print(user.email);
              //print(drive.id2);
// print(user.id);

//print(drive.id2);
              //print(snapshot.data['username']);
              return ListView(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 330,
                        color: Color(0xFF5A45A5),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 25.0),

                            // child: Row(
                            //   children: <Widget>[
                            //      Align(alignment: Alignment.bottomLeft,),
                            //     IconButton(
                            //             icon: Icon(Icons.settings),
                            //             tooltip: 'ตั้งค่า',
                            //             onPressed: () => Navigator.push(context, MaterialPageRoute(
                            //               builder: (_) => Editprofile(user: user,)
                            //             )),
                            //           ),
                            //   ],
                            // ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 35.0),
                            height: 120,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.grey,
                              backgroundImage: user.profileImgUrl.isEmpty
                                  ? AssetImage(
                                      'assets/images/user_placeholder.jpg')
                                  : CachedNetworkImageProvider(
                                      user.profileImgUrl),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(2),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                user.name,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                                textAlign: TextAlign.center,
                              ),
                              FlatButton(
                                //icon: Icon(Icons.settings),
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                color: orange1,
                                // alignment: Alignment.topRight,
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => Editprofile(user: user),
                                  ),
                                ),
                                //color: Color(0xff5A45A5),
                                child: Text(
                                  'ตั้งค่า',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 7),
                            padding: EdgeInsets.all(10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Column(
                                      children: <Widget>[],
                                    ),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: 18),
                                        child: IconButton(
                                            icon: Icon(Icons.book),
                                            color: Colors.black38,
                                            alignment: Alignment.topRight,
                                            onPressed: () => print('4')),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: 80,
                                          margin: EdgeInsets.only(left: 20),
                                          padding: EdgeInsets.only(top: 25),
                                          child: Text(
                                            user.bio,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "ข้อมูลของคุณ",
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
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
                                              ListTile(
                                                leading: Icon(Icons.email),
                                                title: Text("Email"),
                                                subtitle: Text(user.email),
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.face),
                                                title: Text("เพศ"),
                                                subtitle: Text(user.gender),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 10, right: 10),
                            child: Column(children: <Widget>[
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Container(
                                  alignment: Alignment.topRight,
                                  padding: EdgeInsets.all(15),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            ListTile(
                                              leading: FlatButton(
                                                onPressed: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        Driverregis(),
                                                  ),
                                                ),
                                                color: Color(0xff5A45A5),
                                                child: Text(
                                                  'สมัครคนขับ',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // child: Column(
                                        //       children: <Widget>[
                                        //         ListTile(
                                        //           leading: Icon(Icons.email),
                                        //           title: Text("Email"),
                                        //           subtitle: Text(user.email),
                                        //         ),
                                        //         ListTile(
                                        //           leading: Icon(Icons.face),
                                        //           title: Text("เพศ"),
                                        //           subtitle: Text("5555555555"),
                                        //         ),
                                        //       ],
                                        //     ),
                                      ),
                                      Divider(
                                        color: Colors.black38,
                                      ),
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            ListTile(
                                              leading:
                                                  Icon(Icons.directions_car),
                                              title: Text("ID"),

                                              //subtitle: Text(user.email),

                                              subtitle: Text(user.id),
                                            ),
                                            FlatButton(
                                              onPressed: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => Shareform(),
                                                ),
                                              ),
                                              color: Colors.black,
                                              child: Text(
                                                'สร้างการแชร์',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          )
                        ],
                      ),
                      //
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }
}

// class UserInfo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(10),

//       child: Column(
//         children: <Widget>[
//           Card(
//             child: Container(
//               alignment: Alignment.topLeft,
//               padding: EdgeInsets.all(15),
//               child: Column(
//                 children: <Widget>[
//                   Container(
//                     alignment: Alignment.topLeft,
//                     child: Text(
//                       "User Information",
//                       style: TextStyle(
//                         color: Colors.black87,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 16,
//                       ),
//                       textAlign: TextAlign.left,
//                     ),
//                   ),
//                   Divider(
//                     color: Colors.black38,
//                   ),
//                   Container(

//                       child: Column(
//                     children: <Widget>[
//                       ListTile(
//                         leading: Icon(Icons.email),
//                         title: Text("Email"),
//                         subtitle: Text("test@gmail.com"),
//                       ),
//                       ListTile(
//                         leading: Icon(Icons.phone),
//                         title: Text("เพศ"),
//                         subtitle: Text("ชาย"),
//                       ),
//                     ],
//                   ))
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
