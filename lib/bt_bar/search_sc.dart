// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:mythesis96/bt_bar/porfile.dart';
// import 'package:mythesis96/firebase/database_up.dart';
// import 'package:mythesis96/m/driver_regit.dart';
// import 'package:mythesis96/m/share_posts.dart';
// import 'package:mythesis96/m/user_data.dart';
// import 'package:mythesis96/m/user_m.dart';
// import 'package:provider/provider.dart';

// class Search extends StatefulWidget {
//   static final String id = 'feeds_screen';

//   final String currentUserID;
//   Search({this.currentUserID});

//   @override
//   _SearchState createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   List<Share> _posts = [];
//    @override
//    void initState() { 
//      super.initState();
//      _setupFeed();
//    }
//    _setupFeed() async{
//     // final String userId =  Provider.of<Userdata>(context).currentUserID;
//                                                     //allow with feedsc in homemain
//      List<Share> posts = await DatabaseSer.getFeedPosts(widget.currentUserID);
//      setState(() {
//        _posts = posts;
//      });
//    }

//    _buildPost(Share post, User author){
//      return Container(
//        height: 200, margin: EdgeInsets.all(10),
//        color: Colors.red,
//      );
//    }

//     TextEditingController _searchcontrol = TextEditingController();
//   //เรียก user จาก firestor
//   Future<QuerySnapshot> _users;
//   _buildUserTile(User user) {
//     return ListTile(
//       leading: CircleAvatar(
//         radius: 20,
//         backgroundImage: user.profileImgUrl.isEmpty
//             ? AssetImage('assets/images/user_placeholder.jpg')
//             : CachedNetworkImageProvider(user.profileImgUrl),
//       ),
//       title: Text(user.name),
//       //กำหนดให้หลังกด ไปหน้าprofile ของคนนั้น
//       onTap: () => Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (_) => Profile(
//                     userId: user.id,
//                   ))),
//     );
//   }

//   //clear fution
//   _clearsearch() {
//     //กันeror
//     WidgetsBinding.instance.addPostFrameCallback((_) => _searchcontrol.clear());
//     setState(() {
//       _users = null; //สำคัญ
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: TextField(
//           controller: _searchcontrol,
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(vertical: 15),
//             border: InputBorder.none,
//             hintText: 'ค้นหา จากชื่อคอนเสิร์ต',
//             prefixIcon: Icon(
//               Icons.search,
//               size: 30,
//             ),
//             suffixIcon: IconButton(
//               icon: Icon(Icons.clear),
//               //onPressed: () => print('ลบ'),
//               onPressed: _clearsearch,
//             ),
//             filled: true,
//           ),
//           onSubmitted: (input) {
//             // print(input);
//             if (input.isNotEmpty){
//             setState(() {
//               //กำฟังชัน ไปสร้างใน ดาต้า ให้ทำงาน
//               _users = DatabaseSer.searchU(input);
//             });
//             }
//           },
//         ),
//       ),
//       //clear รายชื่อทั้งหมดี่แสดง
//       body: ListView.builder(
//               itemCount: _posts.length,
//               itemBuilder: (BuildContext context, int index) {
//                 Share post = _posts[index];
//               return FutureBuilder(
//                 future: DatabaseSer.getUserWithId(post.authorId),
//                 builder: (BuildContext context, AsyncSnapshot snapshot) {
//                   User author = snapshot.data;
//                   return _buildPost(post, author);
//                 },
//               );
//              },
//             ),
//       // _users == null
//       //     ? Center(
              
//       //       )
//       //     : FutureBuilder(
//       //         future: _users,
//       //         builder: (context, snapshot) {
//       //           if (!snapshot.hasData) {
//       //             return Center(
//       //               child: CircularProgressIndicator(),
//       //             );
//       //           }
//       //           if (snapshot.data.documents.length == 0) {
//       //             return Center(
//       //               child: Text('กรุณา ลองใหม่อีกครั้ง'),
//       //             );
//       //           }
//       //           return ListView.builder(
//       //             itemCount: snapshot.data.documents.length,
//       //             itemBuilder: (BuildContext context, int index) {
//       //               User user = User.fromDoc(snapshot.data.documents[index]);
//       //               return _buildUserTile(user);
//       //             },
//       //           );
//       //         },
//       //       ),
           
//     );
//   }
// }
