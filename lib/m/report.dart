import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final String id2;
  final String topic;
  final String text;
  final String date;
  final String time;
  //final String id;
  final String authorId;
  final String timestamp;

  Report({
    this.id2,
    this.topic,
    this.text,
    this.date,
    this.time,
    this.timestamp,
    this.authorId,
  });
  factory Report.fromDoc(DocumentSnapshot doc) {
    return Report(
      id2: doc.documentID,
      topic: doc['Topic'],
      text: doc['Text'],
      date: doc['Date'],
      time: doc['Time'],
      timestamp: doc['timestamp'],
      authorId: doc['authorId'],
    );
  }
}
