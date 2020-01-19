// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:mythesis96/firebase/searchservice.dart';

// class Sharefeeds extends StatefulWidget {
//   @override
//   _SharefeedsState createState() => _SharefeedsState();
// }

// class _SharefeedsState extends State<Sharefeeds> {
//   var queryResultSet = [];
//   var tempSearchStore = [];

//   initiateSearch(value) {
//     if (value.length == 0) {
//       setState(() {
//         queryResultSet = [];
//         tempSearchStore = [];
//       });
//     }
//    var capitalizedValue  =
//         value.substring(0, 1).toUpperCase() + value.substring(1);

//     if (queryResultSet.length == 0 && value.length == 1){
//       SearchService().searchByName(value).then((QuerySnapshot docs){
//        for (int i = 0; i < docs.documents.length; ++i) {
//          queryResultSet.add(docs.documents[i].data);
//        }
//       });
//     } else {
//       tempSearchStore = [];
//       queryResultSet.forEach((element){
//         if (element['Concertname'].startsWith(capitalizedValue)){
//           setState(() {
//             tempSearchStore.add(element);
//           });
//         }

//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: new AppBar(
//         title: Text('ค้นหาการแชร์'),
//       ),
//       body: ListView(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: TextField(
//               onChanged: (val) {
//                 initiateSearch(val);
//               },
//               decoration: InputDecoration(
//                 prefixIcon: IconButton(
//                   color: Colors.black,
//                   icon: Icon(Icons.arrow_back),
//                   iconSize: 20,
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 contentPadding: EdgeInsets.only(left: 25),
//                 hintText: 'ค้นหาด้วยชื่อคอนเสิรต์',
//                 border:
//                     OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
//               ),
//             ),
//           ),
//           SizedBox(height: 10),
//           GridView.count(
//             padding: EdgeInsets.only(left: 10, right: 10),
//             crossAxisCount: 2,
//             crossAxisSpacing: 4,
//             mainAxisSpacing: 4,
//             primary: false,
//             shrinkWrap: true,
//             children: tempSearchStore.map((element){
//               return buildResultCard(element);
//             }).toList()
//           )
//         ],
//       ),
//     );
//   }
// }

// Widget buildResultCard(data){
//   return Card(
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//     elevation: 2,
//     child: Container(
//       child: Center(
//       child: Text(data['Concertname'],
//       textAlign: TextAlign.center,
//       style: TextStyle(
//         color: Colors.black,
//         fontSize: 20,
//       ),
//       ),
//     ),
//     )
//   );
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:travel_budget/widgets/provider_widget.dart';

class Sharefeeds extends StatelessWidget {
  final Color purple1 = Color(0xff5A45A5);
  final Color purple2 = Color(0xff2A1D59);
  final Color orange1 = Color(0xffF2551D);
  // final Color secondaryColor = Color(0xff324558);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
        initialIndex: 0,
        length: 3,
        child: Theme(
            data: ThemeData(
              primaryColor: purple2,
              appBarTheme: AppBarTheme(
                color: Colors.white,
                textTheme: TextTheme(
                  title: TextStyle(
                    color: purple2,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                iconTheme: IconThemeData(color: purple2),
                actionsIconTheme: IconThemeData(
                  color: purple2,
                ),
              ),
            ),
            child: Scaffold(
              backgroundColor: Theme.of(context).buttonColor,
              appBar: AppBar(
                //center text
                centerTitle: true,
                title: Text('การแชร์'),

                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  )
                ],
                bottom: TabBar(
                  // fic width
                  //  isScrollable: true,
                  labelColor: orange1,
                  indicatorColor: orange1,
                  unselectedLabelColor: orange1,
                  tabs: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("ทั้งหมด"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("ชาย"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("หญิง"),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  // ListView.separated(
                  //   padding: const EdgeInsets.all(16.0),
                  //   itemCount: articles.length,
                  //   itemBuilder: (context, index) {
                  //     return _buildArticleItem(index);
                  //   },
                  //   separatorBuilder: (context, index) =>
                  //       const SizedBox(height: 16.0),
                  // ),
                  StreamBuilder<Object>(builder: (context, snapshot) {
                    return Container(
                      child: StreamBuilder(
                          stream: getUsersTripsStreamSnapshots(context),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData)
                              return const Text("Loading...");
                            return new ListView.builder(
                                itemCount: snapshot.data.documents.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        buildTripCard(context,
                                            snapshot.data.documents[index]));
                          }),
                    );
                  }),
                  Container(
                    //ตัวเลือกกำหนดเพศ
                    child: Text("Tab 2"),
                  ),
                  Container(
                    child: Text("Tab 3"),
                  ),
                  // Container(
                  //   child: Text("Tab 4"),
                  // ),
                  // Container(
                  //   child: Text("Tab 5"),
                  // ),
                ],
              ),
            )));
  }

  //@override
  Widget build2(
    BuildContext context,
  ) {
    return Container(
      child: StreamBuilder(
          stream: getUsersTripsStreamSnapshots(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text("Loading...");
            return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildTripCard(context, snapshot.data.documents[index]));
          }),
    );
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
      BuildContext context) async* {
    // final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('Shareposts_web').snapshots();
  }

  Widget buildTripCard(BuildContext context, DocumentSnapshot trip) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 15.0, // has the effect of softening the shadow
            spreadRadius: 5.0, // has the effect of extending the shadow
            offset: Offset(
              5.0, // horizontal, move right 10
              5.0, // vertical, move down 10
            ),
          )
        ],
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      width: double.infinity,
      height: 150,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 90,
            height: 90,
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),

              //กอบ
              border: Border.all(width: 1, color: purple1),
              image: DecorationImage(
                  image: NetworkImage('https://via.placeholder.com/150'),
                  fit: BoxFit.fill),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    //        Text(
                    //        'ชื่อคอนเสิร์ต',
                    //         style: TextStyle(
                    //             color: primaryColor,
                    //             fontWeight: FontWeight.w100,
                    //             fontSize: 14),
                    //   ),
                    //  Padding(
                    //     padding: EdgeInsets.only(left: 10),
                    //   ),

                    Row(
                      children: <Widget>[
                        Text(
                          trip['Concertname'],
                          style: TextStyle(
                              color: purple1,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        // Align(
                        //   alignment: Alignment.centerRight,
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: orange1,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(trip['StartPlace'],
                        style: TextStyle(
                            color: purple1, fontSize: 13, letterSpacing: .3)),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: orange1,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(trip['Endplace'],
                        style: TextStyle(
                            color: purple1, fontSize: 13, letterSpacing: .3)),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.date_range,
                      color: orange1,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(trip['DateTime'],
                        style: TextStyle(
                            color: purple1, fontSize: 13, letterSpacing: .3)),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.event_seat,
                      color: orange1,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(trip['Seat'],
                        style: TextStyle(
                            color: purple1, fontSize: 13, letterSpacing: .3)),
                    Padding(
                      padding: EdgeInsets.only(left: 80),
                    ),
                    Icon(
                      Icons.attach_money,
                      color: orange1,
                      size: 20,
                    ),
                    Text(trip['Price'],
                        style: TextStyle(
                            color: purple1, fontSize: 13, letterSpacing: .3)),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Expanded(
                
                child: Row(
                  children: <Widget>[
                    Align(alignment: Alignment.centerLeft,),
                    Icon(
                      Icons.arrow_forward_ios,
                      // Icons.keyboard_arrow_right,
                      color: orange1,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
    // return Container(
    //   margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 15),
    //   height: 200,
    //   //width: double.infinity,

    //   decoration: BoxDecoration(
    //       boxShadow: [
    //         BoxShadow(
    //           color: Colors.black26,
    //           blurRadius: 20.0, // has the effect of softening the shadow
    //           spreadRadius: 5.0, // has the effect of extending the shadow
    //           offset: Offset(
    //             10.0, // horizontal, move right 10
    //             10.0, // vertical, move down 10
    //           ),
    //         )
    //       ],
    //       color: Colors.white,
    //       borderRadius: BorderRadius.all(Radius.circular(30))),

    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 20),
    //     child: Column(

    //       children: <Widget>[
    //           Padding(
    //               padding: EdgeInsets.only(top: 20),
    //             ),
    //         Row(

    //           children: <Widget>[

    //             CircleAvatar(
    //             radius: 40.0,
    //             backgroundImage:
    //                 NetworkImage('https://via.placeholder.com/150'),
    //             backgroundColor: Colors.transparent,
    //           ),
    //             // IconButton(
    //             //   onPressed: () {},
    //             //   icon: Icon(
    //             //     Icons.library_music,
    //             //     color: Colors.black,
    //             //   ),
    //             // ),
    //             Padding(
    //               padding: EdgeInsets.only(left: 10),
    //             ),
    //             Text(
    //               'ชื่อคอนเสิร์ต',
    //               style: new TextStyle(fontSize: 14.0),
    //             ),
    //             Padding(
    //               padding: EdgeInsets.only(left: 10),
    //             ),
    //             Text(
    //               trip['Concertname'],
    //               style: new TextStyle(fontSize: 18.0),
    //             ),
    //           ],
    //         ),
    //         Row(
    //           children: <Widget>[
    //             Text(
    //               'จุดเริ่มต้น',
    //               style: new TextStyle(fontSize: 14.0),
    //             ),
    //             Padding(
    //               padding: EdgeInsets.only(left: 10),
    //             ),
    //             Text(
    //               trip['StartPlace'],
    //               style: new TextStyle(fontSize: 18.0),
    //             ),
    //           ],
    //         ),
    //         Row(
    //           children: <Widget>[
    //             Text(
    //               'ปลายทาง',
    //               style: new TextStyle(fontSize: 14.0),
    //             ),
    //             Padding(
    //               padding: EdgeInsets.only(left: 10),
    //             ),
    //             Text(
    //               trip['Endplace'],
    //               style: new TextStyle(fontSize: 18.0),
    //             ),
    //           ],
    //         ),
    //         Row(
    //           children: <Widget>[
    //             Text(
    //               'ที่นั่งว่าง',
    //               style: new TextStyle(fontSize: 14.0),
    //             ),
    //             Padding(
    //               padding: EdgeInsets.only(left: 10),
    //             ),
    //             Text(
    //               trip['Seat'],
    //               style: new TextStyle(fontSize: 18.0),
    //             ),
    //             Padding(
    //               padding: EdgeInsets.only(left: 50),
    //             ),
    //             Text(
    //               'ราคา',
    //               style: new TextStyle(fontSize: 14.0),
    //             ),
    //             Padding(
    //               padding: EdgeInsets.only(left: 10),
    //             ),
    //             Text(
    //               trip['Price'],
    //               style: new TextStyle(fontSize: 18.0),
    //             ),
    //           ],
    //         ),
    //         // IconButton(
    //         //   onPressed: () {},
    //         //   icon: Icon(
    //         //     Icons.filter_list,
    //         //     color: Colors.black,
    //         //   ),
    //         // ),
    //       ],
    //     ),
    //   ),

    //   // return  Container(
    //   //   child: Container(
    //   //   color: Colors.black,
    //   //    margin: EdgeInsets.only(top: 40),
    //   //     child: Card(

    //   //       color: Colors.blue,

    //   //       child: Padding(
    //   //         padding: const EdgeInsets.all(20.0),
    //   //         child: Column(
    //   //           children: <Widget>[
    //   //             Padding(
    //   //               padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
    //   //               child: Row(children: <Widget>[
    //   //                 Text(trip['Concertname'], style: new TextStyle(fontSize: 18.0),),

    //   //                 Spacer(),

    //   //               ]),
    //   //             ),
    //   //             Padding(
    //   //               padding: const EdgeInsets.only(top: 4.0, ),
    //   //               child: Row(children: <Widget>[
    //   //                 Text(trip['StartPlace'], style: new TextStyle(fontSize: 18.0),),
    //   //                 Spacer(),
    //   //               ]),
    //   //             ),
    //   //             Padding(
    //   //               padding: const EdgeInsets.only(top: 4.0,),
    //   //               child: Row(children: <Widget>[
    //   //                 Text(trip['Endplace'], style: new TextStyle(fontSize: 18.0),),
    //   //                 Spacer(),
    //   //               ]),
    //   //             ),
    //   //              Padding(
    //   //               padding: const EdgeInsets.only(top: 4.0,),
    //   //               child: Row(children: <Widget>[
    //   //                 Text(trip['Seat'], style: new TextStyle(fontSize: 18.0),),
    //   //                 Spacer(),
    //   //               ]),
    //   //             ),
    //   //           ],
    //   //         ),
    //   //       ),
    //   //     ),

    //   //   ),
    // );
  }
}
