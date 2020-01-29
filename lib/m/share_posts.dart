import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class Share {
  final String id;
  final String concertname;
  final String startplace;
  final String endplace;
  final String price;
  final String seat;
  final String date;
  final String time;
  final Timestamp timestamp;
  final String authorId;

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
  factory Share.fromDoc(DocumentSnapshot doc){
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
Map<String, dynamic> toJson() =>{
'Concertname':concertname,
'StartPlace': startplace,
'Endplace': endplace,
'Price': price,
'Seat': seat,
'Date': date,
'Time': time,
'AuthorId': authorId,
};
}