import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mythesis96/m/car_data.dart';
import 'package:mythesis96/m/driver_regit.dart';
import 'package:mythesis96/m/share_posts.dart';
import 'package:mythesis96/m/user_m.dart';
import 'package:mythesis96/constance.dart';

class DatabaseSer {
    static final _firestore = Firestore.instance;

  static void updateUser(User user) {
    userRef.document(user.id).updateData({
      'username': user.name,
      'picprofileUrl': user.profileImgUrl,
      'bio': user.bio,
      // 'Driver': user.driver,
    });
  }

  //ชื่อฟังชันที่ใช้งาน
  static Future<QuerySnapshot> searchU(String name) {
    Future<QuerySnapshot> users =

        ///ฟังชัน เสิจทั้งหมด
        userRef.where('username', isGreaterThanOrEqualTo: name).getDocuments();
    return users;
  }

  static void sendpic(Post post) {
    postsRef.document(post.authorId).collection('DriverRegis').add({
      'PiccartaxUrl': post.imageUrl,
      'likes': post.likes,
      'PicDrivelicense': post.imageUrl1,
      'authorId': post.authorId,
      'timestamp': post.timestamp,
    });
    _firestore.collection('DriverRegis_web').add({
      'PiccartaxUrl': post.imageUrl,
      'likes': post.likes,
      'PicDrivelicense': post.imageUrl1,
      'authorId': post.authorId,
      'timestamp': post.timestamp,
    });
  }
 

  static void createShare(Share sharepost) {
    shareRef.document(sharepost.authorId).collection('Shareposts').add({
      'Concertname': sharepost.concertname,
      'StartPlace': sharepost.startplace,
      'Endplace': sharepost.endplace,
      'Price': sharepost.price,
      'Seat': sharepost.seat,
      'DateTime': sharepost.datetime,
      'timestamp': sharepost.timestamp,
      'AuthorId': sharepost.authorId,
    });
    _firestore.collection('Shareposts_web').add({
      'Concertname': sharepost.concertname,
      'StartPlace': sharepost.startplace,
      'Endplace': sharepost.endplace,
      'Price': sharepost.price,
      'Seat': sharepost.seat,
      'DateTime': sharepost.datetime,
      'timestamp': sharepost.timestamp,
      'AuthorId': sharepost.authorId,
    });
  }

  static void createCar(Cardata car) {
    carRef.document(car.authorId).collection('Mycar').add({
      'Brandcar': car.brandcar,
      'Gencar': car.gencar,
      'Color': car.color,
      'licensecar': car.licensecar,
      'Timestamp': car.timestamp,
      'AuthorId': car.authorId,
    });
  }

  static Future<List<Share>> getFeedPosts(String userId) async {
    QuerySnapshot feedshare = await shareRef
        .document(userId)
        .collection('Shareposts')
        .orderBy('timestamp', descending: true)
        .getDocuments();
    List<Share> posts =
        feedshare.documents.map((doc) => Share.fromDoc(doc)).toList();
    return posts;
  }

  //pass authoid and i kenow name and email
  static Future<User> getUserWithId(String userId) async {
    DocumentSnapshot userDocSnapshot = await userRef.document(userId).get();
    if (userDocSnapshot.exists) {
      return User.fromDoc(userDocSnapshot);
    } //inseatance
    return User();
  }
}
