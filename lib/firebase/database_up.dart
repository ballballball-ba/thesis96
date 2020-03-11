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
      'PicDrivelicense': post.imageUrl1,
      'authorId': post.authorId,
      'timestamp': post.timestamp,
    });
    _firestore.collection('DriverRegis_web').add({
      'PiccartaxUrl': post.imageUrl,
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

  static void createPay(PaymentM payment, Sharereq sharereq) {
    userRef.document(payment.authorId).collection('Payment').add({
      'Cardnumber': payment.cardnum,
      'CardExp': payment.cardexp,
      'CardCvv': payment.cardcvv,
      'Cardname': payment.cardname,
      'Allmoney': payment.allmoney,
      'ShareID': payment.shareid,
      'status': payment.status,
      'timestamp': payment.timestamp,
      'AuthorId': payment.authorId,
    });

    _firestore.collection('Payment').add({
      'ShareID': payment.shareid,
      'Cardnumber': payment.cardnum,
      'CardExp': payment.cardexp,
      'CardCvv': payment.cardcvv,
      'Cardname': payment.cardname,
      'status': payment.status,
      'Allmoney': payment.allmoney,
      'timestamp': payment.timestamp,
      'AuthorId': payment.authorId,
    });
  }

  static void createPaycheck(
    Paymentcheck paymentcheck,
  ) {
    userRef.document(paymentcheck.authorId).collection('historycheck').add({
      'Cardnumber': paymentcheck.cardnum,
      'Cardname': paymentcheck.cardname,
      'Allmoney': paymentcheck.allmoney,
      'ShareID': paymentcheck.shareid,
      'concert': paymentcheck.concert,
      'from': paymentcheck.from,
      'to': paymentcheck.to,
      'licensecar': paymentcheck.licensecar,
      'allpeople': paymentcheck.allpeople,
      'status': paymentcheck.status,
      'timestamp': paymentcheck.timestamp,
      'AuthorId': paymentcheck.authorId,
    });

    _firestore.collection('historycheck').add({
      'Cardnumber': paymentcheck.cardnum,
      'Cardname': paymentcheck.cardname,
      'Allmoney': paymentcheck.allmoney,
      'ShareID': paymentcheck.shareid,
      'concert': paymentcheck.concert,
      'from': paymentcheck.from,
      'to': paymentcheck.to,
      'licensecar': paymentcheck.licensecar,
      'allpeople': paymentcheck.allpeople,
      'status': paymentcheck.status,
      'timestamp': paymentcheck.timestamp,
      'AuthorId': paymentcheck.authorId,
    });
  }

  static void createReport(Report report) {
    _firestore.collection('Report').add({
      'Topic': report.topic,
      'Text': report.text,
      'Date': report.date,
      'Time': report.time,
      'Latitude': report.location1,
      'Longtitude': report.location2,
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
      'authorshare': sharereq.authorshare,
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
      'authorshare': sharereq.authorshare,
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
      'authorshare': shareconfirm.authorshare,
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
      'authorshare': shareconfirm.authorshare,
    });
  }

  static void createNotisharem(Notishare notishare) {
    userRef.document(notishare.authorId).collection('Notishare').add({
      'Concertname': notishare.concertname,
      'StartPlace': notishare.startplace,
      'Endplace': notishare.endplace,
      'Price': notishare.price,
      'Seatyou': notishare.seatyou,
      'Seat': notishare.seat,
      'Seatyou2': notishare.seatyou2,
      'Date': notishare.date,
      'Time': notishare.time,
      'details': notishare.details,
      'Seatreqmale': notishare.reqseat1,
      'Seatreqfemale': notishare.reqseat2,
      'Brandcar': notishare.brandcar,
      'Gencar': notishare.gencar,
      'Color': notishare.color,
      'picpro': notishare.picpro,
      'licensecar': notishare.licensecar,
      'timestamp': notishare.timestamp,
      'AuthorId': notishare.authorId,
      'authorshare': notishare.authorshare,
    });
    _firestore.collection('Notishare').add({
      'Concertname': notishare.concertname,
      'StartPlace': notishare.startplace,
      'Endplace': notishare.endplace,
      'Price': notishare.price,
      'Seat': notishare.seat,
      'Seatyou': notishare.seatyou,
      'Seatyou2': notishare.seatyou2,
      'Date': notishare.date,
      'Time': notishare.time,
      'details': notishare.details,
      'Seatreqmale': notishare.reqseat1,
      'Seatreqfemale': notishare.reqseat2,
      'picpro': notishare.picpro,
      //******************* */
      'Brandcar': notishare.brandcar,
      'Gencar': notishare.gencar,
      'Color': notishare.color,
      'licensecar': notishare.licensecar,
      'timestamp': notishare.timestamp,
      'AuthorId': notishare.authorId,
      'authorshare': notishare.authorshare,
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

  static Future<QuerySnapshot> searchCon(String name) {
    Future<QuerySnapshot> shares = shareRef
        .where('Concertname', isGreaterThanOrEqualTo: name)
        .getDocuments();
    return shares;
  }
}
