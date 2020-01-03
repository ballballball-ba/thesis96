import 'package:cloud_firestore/cloud_firestore.dart';

class Share {
  final String id;
  final String concertname;
  final String startplace;
  final String endplace;
  final String price;
  final String seat;
  final String datetime;
  final Timestamp timestamp;
  final String authorId;

  Share({
   this.id,
   this.concertname,
   this.startplace,
   this.endplace,
   this.price,
   this.seat,
   this.datetime,
   this.timestamp,
   this.authorId,
  });
  factory Share.fromDoc(DocumentSnapshot doc){
    return Share(
      id: doc.documentID,
      concertname: doc['Concertname'],
      startplace: doc['StartPlace'],
      endplace: doc['Endplace'],
      price: doc['Price'],
      seat: doc['Seat'],
      datetime: doc['DateTime'],
      timestamp: doc['Timestamp'],
      authorId: doc['AuthorId'],

    );
    
  }

}