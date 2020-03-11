import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mythesis96/bt_bar/alert_report.dart';
import 'package:mythesis96/bt_bar/edit_profile.dart';
import 'package:mythesis96/bt_bar/driver_regis.dart';
import 'package:mythesis96/bt_bar/form_share.dart';
import 'package:mythesis96/firebase/auth_service.dart';
import 'package:mythesis96/m/driver_regit.dart';
import 'package:mythesis96/m/srervices.dart';
import 'package:mythesis96/m/testlo.dart';
import 'package:mythesis96/m/user_m.dart';
import 'package:mythesis96/firebase/constance.dart';
import 'package:mythesis96/m/userlocation.dart';
import 'package:mythesis96/phone_auth.dart';
import 'package:provider/provider.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>(
         builder: (context) => Locationservices().locationStream,
          child: MaterialApp(
        theme: new ThemeData(
          fontFamily: 'Kanit',
          // primarySwatch: Colors.black
        ),
        home: Scaffold(
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
                  return Scaffold(
                    key: _scaffoldKey,
                  
                    drawer: Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Colors.transparent,
                        primaryColor:
                            Color(0xff5A45A5), //***PRIMARY COLOR overide works */

                        //** */DOES NOT OVERRIDE THEMEDATA IN MATERIALAPP***
                        primaryColorBrightness: Brightness.light,
                      ),
                      child: Drawer(
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                child: UserAccountsDrawerHeader(
                                  //arrowColor: orange1,
                                  accountName: Text(user.name),
                                  accountEmail: Text(user.email),
                                  currentAccountPicture: CircleAvatar(
                                    backgroundImage: user.profileImgUrl.isEmpty
                                        ? AssetImage(
                                            'assets/images/user_placeholder.jpg')
                                        : CachedNetworkImageProvider(
                                            user.profileImgUrl),
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.settings),
                                title: Text('ตั้งค่า'),
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => Editprofile(user: user),
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.report_problem),
                                title: Text('แจ้งปัญหา/แจ้งเหตุ'),
                                
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => Alertreport(),
                                  ),
                                ),
                               
                              ),
                              ListTile(
                                  leading: Icon(Icons.info),
                                  title: Text('About Us'),
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Shareform()))),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: ListTile(
                                    leading: Icon(Icons.exit_to_app),
                                    title: Text('ออกจากระบบ'),
                                    onTap: () => AuthService.logout(),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    // drawer: new Drawer(
                    //   child: new ListView(
                    //     children: <Widget>[
                    //       new Container(
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //       mainAxisSize: MainAxisSize.max,
                    //           children: <Widget>[
                    //             new DrawerHeader(child: new CircleAvatar(
                    //                 backgroundImage: user.profileImgUrl.isEmpty
                    //                     ? AssetImage(
                    //                         'assets/images/user_placeholder.jpg')
                    //                     : CachedNetworkImageProvider(
                    //                         user.profileImgUrl),
                    //               ),),
                    //           ],

                    //         ),
                    //         color: purple1,
                    //       ),
                    //       new Container(
                    //         color: Colors.white,
                    //         child: new Column(
                    //           children: new List.generate(4, (int index) {
                    //             return new ListTile(
                    //               leading: new Icon(Icons.info),
                    //             );
                    //           }),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    body: ListView(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Stack(
                                    alignment: Alignment.center,
                                    overflow: Overflow.visible,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 670.0,
                                        decoration: BoxDecoration(
                                            gradient: new LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                              Color(0xff5A45A5),
                                              Colors.white30,

                                              /// Colors.white30,
                                            ])),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Padding(
                                              padding: EdgeInsets.only(top: 25)),
                                          Row(
                                            children: <Widget>[
                                              IconButton(
                                                icon: new Icon(
                                                  Icons.menu,
                                                  color: Colors.white,
                                                  size: 40,
                                                ),
                                                onPressed: () => _scaffoldKey
                                                    .currentState
                                                    .openDrawer(),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 40.0),
                                            height: 120,
                                            child: CircleAvatar(
                                              radius: 60,
                                              backgroundColor: Colors.grey,
                                              backgroundImage: user
                                                      .profileImgUrl.isEmpty
                                                  ? AssetImage(
                                                      'assets/images/user_placeholder.jpg')
                                                  : CachedNetworkImageProvider(
                                                      user.profileImgUrl),
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                user.name,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 22),
                                                textAlign: TextAlign.center,
                                              ),
                                              // )
                                            ],
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 40.0),
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 10,
                                                    spreadRadius: 3,
                                                    offset: Offset(10, 0))
                                              ],
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft:
                                                    const Radius.circular(40.0),
                                                topRight:
                                                    const Radius.circular(40.0),
                                                bottomLeft:
                                                    const Radius.circular(10.0),
                                                bottomRight:
                                                    const Radius.circular(10.0),
                                              ),
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  // shape: RoundedRectangleBorder(
                                                  //   borderRadius:
                                                  //       BorderRadius.only(
                                                  //     topLeft:
                                                  //         const Radius.circular(
                                                  //             40.0),
                                                  //     topRight:
                                                  //         const Radius.circular(
                                                  //             40.0),
                                                  //     bottomLeft:
                                                  //         const Radius.circular(
                                                  //             10.0),
                                                  //     bottomRight:
                                                  //         const Radius.circular(
                                                  //             10.0),
                                                  //   ),
                                                  // ),
                                                  child: Container(
                                                    alignment: Alignment.topLeft,
                                                    padding: EdgeInsets.all(15),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Container(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            "ข้อมูลของคุณ",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black87,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                              fontSize: 16,
                                                            ),
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                        ),
                                                        Divider(
                                                          color: Colors.black38,
                                                        ),
                                                        Container(
                                                          child: Column(
                                                            children: <Widget>[
                                                              ListTile(
                                                                leading: Icon(
                                                                    Icons.email),
                                                                title:
                                                                    Text("Email"),
                                                                subtitle: Text(
                                                                    user.email),
                                                              ),
                                                              ListTile(
                                                                leading: Icon(
                                                                    Icons.face),
                                                                title:
                                                                    Text("เพศ"),
                                                                subtitle: Text(
                                                                    user.gender),
                                                              ),
                                                              ListTile(
                                                                leading: Icon(
                                                                    Icons.phone),
                                                                title: Text(
                                                                    "เบอร์โทรศัพท์"),
                                                                subtitle: Text(
                                                                    user.phone),
                                                              ),
                                                              ListTile(
                                                                leading: Icon(Icons
                                                                    .directions_car),
                                                                title: Text("ID"),

                                                                //subtitle: Text(user.email),

                                                                subtitle:
                                                                    Text(user.id),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        // Container(
                                                        //   child: Column(
                                                        //     children: <Widget>[
                                                        //       ListTile(
                                                        //         leading: Icon(Icons
                                                        //             .directions_car),
                                                        //         title: Text("ID"),

                                                        //         //subtitle: Text(user.email),

                                                        //         subtitle:
                                                        //             Text(user.id),
                                                        //       ),
                                                        //       FlatButton(
                                                        //         onPressed: () =>
                                                        //             Navigator
                                                        //                 .push(
                                                        //           context,
                                                        //           MaterialPageRoute(
                                                        //             builder: (_) =>
                                                        //                 Shareform(),
                                                        //           ),
                                                        //         ),
                                                        //         color:
                                                        //             Colors.black,
                                                        //         child: Text(
                                                        //           'สร้างการแชร์',
                                                        //           style: TextStyle(
                                                        //               color: Colors
                                                        //                   .white),
                                                        //         ),
                                                        //       ),
                                                        //     ],
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          // Container(
                                          //   padding: EdgeInsets.only(
                                          //       bottom: 10, right: 10, left: 10),
                                          //   child: Column(children: <Widget>[
                                          //     Card(
                                          //       shape: RoundedRectangleBorder(
                                          //         borderRadius:
                                          //             BorderRadius.circular(10.0),
                                          //       ),
                                          //       child: Container(
                                          //         alignment: Alignment.topRight,
                                          //         padding: EdgeInsets.all(15),
                                          //         child: Column(
                                          //           children: <Widget>[
                                          //             Container(
                                          //               child: Column(
                                          //                 children: <Widget>[
                                          //                   ListTile(
                                          //                     leading: FlatButton(
                                          //                       onPressed: () =>
                                          //                           Navigator
                                          //                               .push(
                                          //                         context,
                                          //                         MaterialPageRoute(
                                          //                           builder: (_) =>
                                          //                               Driverregis(),
                                          //                         ),
                                          //                       ),
                                          //                       color: Color(
                                          //                           0xff5A45A5),
                                          //                       child: Text(
                                          //                         'สมัครคนขับ',
                                          //                         style: TextStyle(
                                          //                             color: Colors
                                          //                                 .white),
                                          //                       ),
                                          //                     ),
                                          //                   ),
                                          //                 ],
                                          //               ),
                                          //               // child: Column(
                                          //               //       children: <Widget>[
                                          //               //         ListTile(
                                          //               //           leading: Icon(Icons.email),
                                          //               //           title: Text("Email"),
                                          //               //           subtitle: Text(user.email),
                                          //               //         ),
                                          //               //         ListTile(
                                          //               //           leading: Icon(Icons.face),
                                          //               //           title: Text("เพศ"),
                                          //               //           subtitle: Text("5555555555"),
                                          //               //         ),
                                          //               //       ],
                                          //               //     ),
                                          //             ),
                                          //             Divider(
                                          //               color: Colors.black38,
                                          //             ),
                                          //             Container(
                                          //               child: Column(
                                          //                 children: <Widget>[
                                          //                   ListTile(
                                          //                     leading: Icon(Icons
                                          //                         .directions_car),
                                          //                     title: Text("ID"),

                                          //                     //subtitle: Text(user.email),

                                          //                     subtitle:
                                          //                         Text(user.id),
                                          //                   ),
                                          //                   FlatButton(
                                          //                     onPressed: () =>
                                          //                         Navigator.push(
                                          //                       context,
                                          //                       MaterialPageRoute(
                                          //                         builder: (_) =>
                                          //                             Shareform(),
                                          //                       ),
                                          //                     ),
                                          //                     color: Colors.black,
                                          //                     child: Text(
                                          //                       'สร้างการแชร์',
                                          //                       style: TextStyle(
                                          //                           color: Colors
                                          //                               .white),
                                          //                     ),
                                          //                   ),
                                          //                 ],
                                          //               ),
                                          //             ),
                                          //           ],
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ]),
                                          // )
                                        ],
                                      ),
                                    ]),
                                Padding(
                                  padding: EdgeInsets.all(2),
                                ),
                              ],
                            ),
                            //
                          ],
                        )
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

regisdrive() {
  if (1 + 2 == 5) {}
}
