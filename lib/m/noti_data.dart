import 'package:cloud_firestore/cloud_firestore.dart';

class Notirequest {
 final String id;
 final String formUserId;
 final String postId;
 final String concertname;
 final String nameconshort;
 final String startplace;
 final String endplace;
final  String price;
 final String seat;
 final String seatyou;
 final String seatyou2;
 final String date;
 final String time;
 final String details;
 final String brandcar;
final  String gencar;
 final String color;
 final String licensecar;
 final String timestamp;
 final String authorId;

 Notirequest({
    this.id,
    this.formUserId,
    this.postId,
    this.concertname,
    this.nameconshort,
    this.startplace,
    this.endplace,
    this.price,
    this.seat,
    this.seatyou2,
    this.seatyou,
    this.date,
    this.time,
    this.brandcar,
    this.gencar,
    this.color,
    this.licensecar,
    this.details,
    this.timestamp,
    this.authorId,
  });
  factory Notirequest.fromDoc(DocumentSnapshot doc) {
    return Notirequest(
      id: doc.documentID,
      formUserId: doc['FormUserId'],
      postId: doc['PostId'],
      concertname: doc['Concertname'],
      nameconshort: doc['nameconshort'],
      startplace: doc['StartPlace'],
      endplace: doc['Endplace'],
      price: doc['Price'],
      seat: doc['Seat'],
      seatyou: doc['Seatyou'],
      seatyou2: doc['Seatyou2'],
      date: doc['Date'],
      time: doc['Time'],
      //******************** */
      brandcar: doc['Brandcar'],
      gencar: doc['Gencar'],
      color: doc['Color'],
      licensecar: doc['licensecar'],
      details: doc['details'],
      timestamp: doc['Timestamp'],
      authorId: doc['AuthorId'],
    );
  }
}