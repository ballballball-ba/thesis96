import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mythesis96/bt_bar/activity_sc.dart';
import 'package:mythesis96/bt_bar/notiac_sc.dart';
import 'package:mythesis96/bt_bar/porfile.dart';
import 'package:mythesis96/bt_bar/search_sc.dart';
import 'package:mythesis96/bt_bar/driver_regis.dart';
import 'package:mythesis96/bt_bar/sharefeeds.dart';
import 'package:mythesis96/feed_home.dart';
import 'package:mythesis96/m/user_data.dart';
import 'package:mythesis96/phone_auth.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
// old v.
// final String userId;

// Home({this.userId});

  static final String id = 'home_screen';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentab = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    //ไว้เช็ค id user
        final String currentUserID = Provider.of<Userdata>(context).currentUserID;

   // print(Provider.of<Userdata>(context).currentUserID);
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
                   //เรียกใช้ฟังชันจากหน้า feed 
        //  PhoneAuth(),        
          Feedhome(currentUserID: currentUserID),
          Sharefeeds(),
          Activity(),
          Notiac(),
          //Driverregis(),
          //old
         // Profile(userId: widget.userId),
         Profile(userId: Provider.of<Userdata>(context).currentUserID,)
        
        ],
        onPageChanged: (int index) {
          //ทำให้เปลี่ยนหน้าตาม icon
          setState(() {
            _currentab = index;
          });
          },
          
        
      ),
      bottomNavigationBar: CupertinoTabBar(
        //กำหนดให้คลิกแล้วเปลี่ยนหน้าตามที่คลิก
        currentIndex: _currentab,
        onTap: (int index) {
          setState(() {
            _currentab = index;
          });
            _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
        },
        
        activeColor: Color(0xFFF2551D),
        backgroundColor: Color(0xFFFBFCFC),
        items: [
          // BottomNavigationBarItem(
            
          //   icon: Icon(
          //     Icons.home,
          //     size: 35,
          //   ),
          //   title: Text("เบอ"),
          // ),
          BottomNavigationBarItem(
            
            icon: Icon(
              Icons.home,
              size: 35,
            ),
            title: Text("หน้าแรก"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 35,
            ),
            title: Text("ค้นหาการแชร์"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.directions_car,
              size: 35,
            ),
            title: Text("การแชร์ของฉัน"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              size: 35,
            ),
            title: Text("แจ้งเตือน"),
          
         
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.notifications,
          //     size: 35,
          //   ),
          //   title: Text("สร้างแชร์"),
          // ),
           BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              size: 35,
            ),
            title: Text("โพรไฟล์"),
            ),
        ],
      ),
    );
  }
}
