import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mythesis96/bt_bar/notifier_share.dart';
import 'package:mythesis96/bt_bar/payment.dart';
import 'package:mythesis96/m/car_data.dart';
import 'package:mythesis96/m/driver_regit.dart';
import 'package:mythesis96/m/payment_data.dart';
import 'package:mythesis96/m/report.dart';
import 'package:mythesis96/m/share_posts.dart';
import 'package:mythesis96/m/user_m.dart';
import 'package:mythesis96/firebase/constance.dart';

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

  // static void createCar(Cardata car) {
  //   carRef.document(car.authorId).collection('Mycar').add({
  //     'Brandcar': car.brandcar,
  //     'Gencar': car.gencar,
  //     'Color': car.color,
  //     'licensecar': car.licensecar,
  //     'Timestamp': car.timestamp,
  //     'AuthorId': car.authorId,
  //   });
  // }
  static void createCar(Cardata car) {
    userRef.document(car.authorId).collection('Mycar').add({
      'Brandcar': car.brandcar,
      'Gencar': car.gencar,
      'Color': car.color,
      'licensecar': car.licensecar,
      'Timestamp': car.timestamp,
      'AuthorId': car.authorId,
    });
    carRef.document(car.authorId).collection('Mycar').add({
      'Brandcar': car.brandcar,
      'Gencar': car.gencar,
      'Color': car.color,
      'licensecar': car.licensecar,
      'Timestamp': car.timestamp,
      'AuthorId': car.authorId,
    });
  }

  static void createShare(Share sharepost) {
    userRef.document(sharepost.authorId).collection('Shareposts').add({
      'Concertname': sharepost.concertname,
      'StartPlace': sharepost.startplace,
      'Endplace': sharepost.endplace,
      'Price': sharepost.price,
      'Seatyou': sharepost.seatyou,
      'Seat': sharepost.seat,
      'Seatyou2': sharepost.seatyou2,
      'Date': sharepost.date,
      'Time': sharepost.time,
      'details': sharepost.details,
      'timestamp': sharepost.timestamp,
      'AuthorId': sharepost.authorId,
    });
    _firestore.collection('Shareposts').add({
      'Concertname': sharepost.concertname,
      'StartPlace': sharepost.startplace,
      'Endplace': sharepost.endplace,
      'Price': sharepost.price,
      'Seat': sharepost.seat,
      'Seatyou': sharepost.seatyou,
      'Seatyou2': sharepost.seatyou2,
      'Date': sharepost.date,
      'Time': sharepost.time,
      'details': sharepost.details,
      'picpro': sharepost.picpro,
      //******************* */
      'Brandcar': sharepost.brandcar,
      'Gencar': sharepost.gencar,
      'Color': sharepost.color,
      'licensecar': sharepost.licensecar,
      'timestamp': sharepost.timestamp,
      'AuthorId': sharepost.authorId,
    });
  }

  static void createPay(PaymentM payment) {
    userRef.document(payment.authorId).collection('Payment').add({
      'Cardnumber': payment.cardnum,
      'CardExp': payment.cardexp,
      'CardCvv': payment.cardcvv,
      'CardCvv': payment.cardname,
      // 'Seat': payment.seat,
      // 'Date': payment.date,
      // 'Time': payment.time,
      'timestamp': payment.timestamp,
      'AuthorId': payment.authorId,
    });
    // shareRef.document(payment.id).collection('Payment').add({
    //   'Cardnumber': payment.cardnum,
    //   'CardExp': payment.cardexp,
    //   'CardCvv': payment.cardcvv,
    //   'CardCvv': payment.cardname,
    //   // 'Seat': payment.seat,
    //   // 'Date': payment.date,
    //   // 'Time': payment.time,
    //   'timestamp': payment.timestamp,
    //   'AuthorId': payment.authorId,
    // });
    _firestore.collection('Payment').add({
      'Cardnumber': payment.cardnum,
      'CardExp': payment.cardexp,
      'CardCvv': payment.cardcvv,
      'CardCvv': payment.cardname,
      // 'Seat': sharepost.seat,
      // 'Date': sharepost.date,
      // 'Time': sharepost.time,
      'timestamp': payment.timestamp,
      'AuthorId': payment.authorId,
    });
  }

  static void createReport(Report report) {
    _firestore.collection('Report').add({
      'Topic': report.topic,
      'Text': report.text,
      'Date': report.date,
      'Time': report.time,
      'AuthorId': report.authorId,
      //'licensecar': car.licensecar,
      'Timestamp': report.timestamp,
    });
  }

  static void addNotireq({
    String currentUserID,
    Share sharepost,
  }) {
    if (currentUserID != sharepost.authorId) {
      notireqRef
          .document(sharepost.authorId)
          .collection('Notificationrequest')
          .add({
        'Concertname': sharepost.concertname,
        'StartPlace': sharepost.startplace,
        'FormUserId': currentUserID,
        'PostId': sharepost.id,
        'Endplace': sharepost.endplace,
        'Price': sharepost.price,
        'Seatyou': sharepost.seatyou,
        'Seat': sharepost.seat,
        'Seatyou2': sharepost.seatyou2,
        'Date': sharepost.date,
        'Time': sharepost.time,
        'details': sharepost.details,
        'Brandcar': sharepost.brandcar,
        'picpro': sharepost.picpro,
        'Gencar': sharepost.gencar,
        'Color': sharepost.color,
        'licensecar': sharepost.licensecar,
        'timestamp': Timestamp.fromDate(DateTime.now()),
        'AuthorId': sharepost.authorId,
      });
    }
  }

  //********************** ร้องขอ ******************************* */
  static void createSharereq(Sharereq sharereq) {
    userRef.document(sharereq.authorId).collection('ShareRequest').add({
      'Concertname': sharereq.concertname,
      'StartPlace': sharereq.startplace,
      'Endplace': sharereq.endplace,
      'Price': sharereq.price,
      'Seatyou': sharereq.seatyou,
      'Seat': sharereq.seat,
      'Seatyou2': sharereq.seatyou2,
      'Date': sharereq.date,
      'Time': sharereq.time,
      'details': sharereq.details,
      'Seatreqmale': sharereq.reqseat1,
      'Seatreqfemale': sharereq.reqseat2,
      'Brandcar': sharereq.brandcar,
      'Gencar': sharereq.gencar,
      'Color': sharereq.color,
      'picpro': sharereq.picpro,
      'licensecar': sharereq.licensecar,
      'timestamp': sharereq.timestamp,
      'AuthorId': sharereq.authorId,
    });
    _firestore.collection('ShareRequest').add({
      'Concertname': sharereq.concertname,
      'StartPlace': sharereq.startplace,
      'Endplace': sharereq.endplace,
      'Price': sharereq.price,
      'Seat': sharereq.seat,
      'Seatyou': sharereq.seatyou,
      'Seatyou2': sharereq.seatyou2,
      'Date': sharereq.date,
      'Time': sharereq.time,
      'details': sharereq.details,
      'Seatreqmale': sharereq.reqseat1,
      'Seatreqfemale': sharereq.reqseat2,
      'picpro': sharereq.picpro,
      //******************* */
      'Brandcar': sharereq.brandcar,
      'Gencar': sharereq.gencar,
      'Color': sharereq.color,
      'licensecar': sharereq.licensecar,
      'timestamp': sharereq.timestamp,
      'AuthorId': sharereq.authorId,
    });
  }
static void createShareconfirm(Shareconfirm shareconfirm) {
    userRef.document(shareconfirm.authorId).collection('Shareconfirm').add({
      'Concertname': shareconfirm.concertname,
      'StartPlace': shareconfirm.startplace,
      'Endplace': shareconfirm.endplace,
      'Price': shareconfirm.price,
      'Seatyou': shareconfirm.seatyou,
      'Seat': shareconfirm.seat,
      'Seatyou2': shareconfirm.seatyou2,
      'Date': shareconfirm.date,
      'Time': shareconfirm.time,
      'details': shareconfirm.details,
      'Seatreqmale': shareconfirm.reqseat1,
      'Seatreqfemale': shareconfirm.reqseat2,
      'Brandcar': shareconfirm.brandcar,
      'Gencar': shareconfirm.gencar,
      'Color': shareconfirm.color,
      'picpro': shareconfirm.picpro,
      'licensecar': shareconfirm.licensecar,
      'timestamp': shareconfirm.timestamp,
      'AuthorId': shareconfirm.authorId,
    });
    _firestore.collection('Shareconfirm').add({
      'Concertname': shareconfirm.concertname,
      'StartPlace': shareconfirm.startplace,
      'Endplace': shareconfirm.endplace,
      'Price': shareconfirm.price,
      'Seat': shareconfirm.seat,
      'Seatyou': shareconfirm.seatyou,
      'Seatyou2': shareconfirm.seatyou2,
      'Date': shareconfirm.date,
      'Time': shareconfirm.time,
      'details': shareconfirm.details,
      'Seatreqmale': shareconfirm.reqseat1,
      'Seatreqfemale': shareconfirm.reqseat2,
      'picpro': shareconfirm.picpro,
      //******************* */
      'Brandcar': shareconfirm.brandcar,
      'Gencar': shareconfirm.gencar,
      'Color': shareconfirm.color,
      'licensecar': shareconfirm.licensecar,
      'timestamp': shareconfirm.timestamp,
      'AuthorId': shareconfirm.authorId,
    });
  }
  static Future<List<Share>> getFeedPosts(String userId) async {
    QuerySnapshot feedshare = await userRef
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

  static Future<QuerySnapshot> searchCon(String name){
    Future<QuerySnapshot> shares = shareRef.where('Concertname', isGreaterThanOrEqualTo: name).getDocuments();
    return shares;

  }
}
