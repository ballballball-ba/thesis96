import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class Share {
  String id;
  String concertname;
  String startplace;
  String endplace;
  String price;
  String seat;
  String date;
  String time;
  Timestamp timestamp;
  String authorId;

  Share.fromMap(Map<String, dynamic> data) {
    // id = data['id'];
    // concertname = data['name'];
    // startplace = data['category'];
    // endplace = data['image'];
    // price = data['subIngredients'];
    // seat = data['createdAt'];
    // date = data['updatedAt'];
    id = data['id'];
    concertname = data['Concertname'];
    startplace = data['StartPlace'];
    endplace = data['Endplace'];
    price = data['Price'];
    seat = data['Seat'];
    date = data['Date'];
    time = data['Time'];
    timestamp = data['Timestamp'];
    authorId = data['AuthorId'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Concertname': concertname,
      'StartPlace': startplace,
      'Endplace': endplace,
      'Price': price,
      'Seat': seat,
      'Date': date,
      'Time': time,
      'Timestamp': timestamp,
      'AuthorId': authorId,
    };
  }

  Share({
    this.id,
    this.concertname,
    this.startplace,
    this.endplace,
    this.price,
    this.seat,
    this.date,
    this.time,
    this.timestamp,
    this.authorId,
  });
  factory Share.fromDoc(DocumentSnapshot doc) {
    return Share(
      id: doc.documentID,
      concertname: doc['Concertname'],
      startplace: doc['StartPlace'],
      endplace: doc['Endplace'],
      price: doc['Price'],
      seat: doc['Seat'],
      date: doc['Date'],
      time: doc['Time'],
      timestamp: doc['Timestamp'],
      authorId: doc['AuthorId'],
    );
  }
  // Share();

}
