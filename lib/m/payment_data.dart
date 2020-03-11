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

class Paymentcheck {
  final String id;
  final String cardnum;

  final String cardname;
  final String allmoney;
  final String shareid;

  final String concert;
  final String from;
  final String to;
  final String licensecar;
  final String allpeople;

  final String status;
  final String authorId;
  final String timestamp;

  Paymentcheck({
    this.id,
    this.cardnum,
    this.cardname,
    this.allmoney,
    this.shareid,
    this.concert,
    this.from,
    this.to,
    this.licensecar,
    this.allpeople,
    this.status,
    this.timestamp,
    this.authorId,
  });
  factory Paymentcheck.fromDoc(DocumentSnapshot doc) {
    return Paymentcheck(
      id: doc.documentID,
      cardnum: doc['Cardnumber'],
      cardname: doc['Cardname'],
      status: doc['status'],
      allmoney: doc['Allmoney'],
      shareid: doc['ShareID'],
      concert: doc['concert'],
      from: doc['from'],
      to: doc['to'],
      licensecar: doc['licensecar'],
      allpeople: doc['allpeople'],
      timestamp: doc['timestamp'],
      authorId: doc['authorId'],
    );
  }
}
