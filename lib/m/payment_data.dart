import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentM {
  final String id;
  final String cardnum;
  final String cardexp;
  final String cardcvv;
  final String cardname;
  //final String id;
  final String authorId;
  final Timestamp timestamp;

  PaymentM({
    this.id,
    this.cardnum,
    this.cardexp,
    this.cardcvv,
    this.cardname,
    this.timestamp,
    this.authorId,
  });
  factory PaymentM.fromDoc(DocumentSnapshot doc) {
    return PaymentM(
      id: doc.documentID,
      cardnum: doc['Cardnumber'],
      cardexp: doc['CardExp'],
      cardcvv: doc['CardCvv'],
      cardname: doc['Cardname'],
      timestamp: doc['timestamp'],
      authorId: doc['authorId'],
    );
  }
}