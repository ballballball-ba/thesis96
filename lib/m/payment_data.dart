import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentM {
  final String id;
  final String cardnum;
  final String cardexp;
  final String cardcvv;
  final String cardname;
  final String allmoney;
  final String shareid;
  final String status;
  final String authorId;
  final String timestamp;

  PaymentM({
    this.id,
    this.cardnum,
    this.cardexp,
    this.cardcvv,
    this.cardname,
    this.allmoney,
    this.shareid,
    this.status,
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
      status: doc['status'],
      allmoney: doc['Allmoney'],
      shareid: doc['ShareID'],
      timestamp: doc['timestamp'],
      authorId: doc['authorId'],
    );
  }
}