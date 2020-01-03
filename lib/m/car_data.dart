import 'package:cloud_firestore/cloud_firestore.dart';

class Cardata {
  final String id;
  final String brandcar;
  final String gencar;
  final String color;
  final String licensecar;
  final Timestamp timestamp;
  final String authorId;

  Cardata({
   this.id,
   this.brandcar,
   this.gencar,
   this.color,
   this.licensecar,
   this.timestamp,
   this.authorId,
  });
  factory Cardata.fromDoc(DocumentSnapshot doc){
    return Cardata(
      id: doc.documentID,
      brandcar: doc['Brandcar'],
      gencar: doc['Gencar'],
      color: doc['Color'],
      licensecar: doc['licensecar'],
      timestamp: doc['Timestamp'],
      authorId: doc['AuthorId'],

    );
    
  }

}