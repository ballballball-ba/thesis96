import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class Share {
  String id;
  String concertname;
  String nameconshort;
  String startplace;
  String endplace;
  String price;
  String seat;
  String seatyou;
  String seatyou2;
  String date;
  String time;
  String details;
  String brandcar;
  String gencar;
  String color;
  String licensecar;
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
    nameconshort = data['nameconshort'];
    startplace = data['StartPlace'];
    endplace = data['Endplace'];
    price = data['Price'];
    seat = data['Seat'];
    seatyou = data['Seatyou'];
    seatyou2 = data['Seatyou2'];
    date = data['Date'];
    time = data['Time'];
    details = data['details'];
     //******************** */
    brandcar = data['Brandcar'];
    gencar = data['Gencar'];
    color = data['Color'];
    licensecar = data['licensecar'];
    timestamp = data['Timestamp'];
    authorId = data['AuthorId'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Concertname': concertname,
      'nameconshort': nameconshort,
      'StartPlace': startplace,
      'Endplace': endplace,
      'Price': price,
      'Seat': seat,
      'Seatyou': seatyou,
      'Seatyou2': seatyou2,
      'Date': date,
      'Time': time,
      'Seatyou': seatyou,
      'Seatyou2': seatyou2,
       //******************** */
      'Brandcar': brandcar,
      'Gencar': gencar,
      'Color': color,
      'licensecar': licensecar,
      'Timestamp': timestamp,
      'AuthorId': authorId,
    };
  }

  Share({
    this.id,
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
  factory Share.fromDoc(DocumentSnapshot doc) {
    return Share(
      id: doc.documentID,
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
  // Share();

}
