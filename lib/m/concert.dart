import 'package:cloud_firestore/cloud_firestore.dart';

class Concertview {
  String id;
  String namecon;
  String nameconshort;
  String day;
  String time;
  String picurl;
  String place;
  String name;

  String details;

  Timestamp timestamp;
  String authorId;
  Concertview.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    namecon = data['NameCon'];
    name = data['NameCon'];
    nameconshort = data['nameconshort'];
    day = data['Day'];

    time = data['Time'];
    details = data['Details'];
    picurl = data['PicURL'];
    place = data['Place'];
    //******************** */

    timestamp = data['Timestamp'];
    authorId = data['AuthorId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'NameCon': namecon,
      'NameCon' : name,
      'nameconshort': nameconshort,
      'Day': day,
      'Time': time,
      'PicURL': picurl,
      'Place': place,
      'Details': details,
      //******************** */

      'Timestamp': timestamp,
      'AuthorId': authorId,
    };
  }

  Concertview({
    this.id,
    this.namecon,
    this.name,
    this.nameconshort,
    this.day,
    this.picurl,
    this.place,
    this.time,
    this.details,
    this.timestamp,
    this.authorId,
  });
  factory Concertview.fromDoc(DocumentSnapshot doc) {
    return Concertview(
      id: doc.documentID,
      namecon: doc['NameCon'],
      nameconshort: doc['nameconshort'],
      name:doc['NameCon'],
      day: doc['Day'],
      time: doc['Time'],
      place: doc['Place'],
      picurl: doc['PicURL'],
      //******************** */

      details: doc['Details'],
      timestamp: doc['Timestamp'],
      authorId: doc['AuthorId'],
    );
  }
  // Share();

}
