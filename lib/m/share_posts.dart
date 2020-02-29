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
  String picpro;
  String brandcar;
  String gencar;
  String color;
  String licensecar;
  String timestamp;
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
    picpro = data['picpro'];
     //******************** */
    brandcar = data['Brandcar'];
    gencar = data['Gencar'];
    color = data['Color'];
    licensecar = data['licensecar'];
    timestamp = data['Timestamp'];
    authorId = data['AuthorId'];
  }

  get length => null;
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
      'picpro': picpro,
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
    this.picpro,
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
      picpro: doc['picpro'],
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
////********************************************** */
class Sharereq {
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
  String picpro;
  String licensecar;
  String reqseat1;
  String reqseat2;
  String timestamp;
  String authorId;
  String authorshare;
  Sharereq.fromMap(Map<String, dynamic> data) {
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
    picpro = data['picpro'];
    reqseat1 = data['Seatreqmale'];
    reqseat2 = data['Seatreqfemale'];
     //******************** */
    brandcar = data['Brandcar'];
    gencar = data['Gencar'];
    color = data['Color'];
    licensecar = data['licensecar'];
    timestamp = data['Timestamp'];
    authorId = data['AuthorId'];
    authorshare = data ['authorshare'];
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
      'Seatreqmale':reqseat1,
      'Seatreqfemale':reqseat2,
      'picpro':picpro,
       //******************** */
      'Brandcar': brandcar,
      'Gencar': gencar,
      'Color': color,
      'licensecar': licensecar,
      'Timestamp': timestamp,
      'AuthorId': authorId,
      'authorshare': authorshare,
    };
  }

  Sharereq({
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
    this.picpro,
    this.licensecar,
    this.details,
    this.reqseat1,
    this.reqseat2,
    
    this.timestamp,
    this.authorId,
    this.authorshare,
  });
  factory Sharereq.fromDoc(DocumentSnapshot doc) {
    return Sharereq(
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
      reqseat1: doc['Seatreqmale'],
      reqseat2: doc['Seatreqfemale'],
      picpro: doc['picpro'],
      //******************** */
      brandcar: doc['Brandcar'],
      gencar: doc['Gencar'],
      color: doc['Color'],
      licensecar: doc['licensecar'],
      details: doc['details'],
      timestamp: doc['Timestamp'],
      authorId: doc['AuthorId'],
      authorshare: doc['authorshare'],
    );
  }
  // Share();

}
class Shareconfirm {
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
  String picpro;
  String licensecar;
  String reqseat1;
  String reqseat2;
  String authorshare;
  String timestamp;
  String authorId;

  Shareconfirm.fromMap(Map<String, dynamic> data) {
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
    picpro = data['picpro'];
    reqseat1 = data['Seatreqmale'];
    reqseat2 = data['Seatreqfemale'];
     //******************** */
    brandcar = data['Brandcar'];
    gencar = data['Gencar'];
    color = data['Color'];
    licensecar = data['licensecar'];
    timestamp = data['Timestamp'];
    authorId = data['AuthorId'];
    authorshare = data['authorshare'];
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
      'Seatreqmale':reqseat1,
      'Seatreqfemale':reqseat2,
      'picpro':picpro,
       //******************** */
      'Brandcar': brandcar,
      'Gencar': gencar,
      'Color': color,
      'licensecar': licensecar,
      'Timestamp': timestamp,
      'AuthorId': authorId,
      'authorshare': authorshare,
    };
  }

  Shareconfirm({
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
    this.picpro,
    this.licensecar,
    this.details,
    this.reqseat1,
    this.reqseat2,
    this.authorshare,
    this.timestamp,
    this.authorId,
  });
  factory Shareconfirm.fromDoc(DocumentSnapshot doc) {
    return Shareconfirm(
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
      reqseat1: doc['Seatreqmale'],
      reqseat2: doc['Seatreqfemale'],
      picpro: doc['picpro'],
      //******************** */
      brandcar: doc['Brandcar'],
      gencar: doc['Gencar'],
      color: doc['Color'],
      licensecar: doc['licensecar'],
      details: doc['details'],
      timestamp: doc['Timestamp'],
      authorId: doc['AuthorId'],
      authorshare: doc['authorshare'],
    );
  }
  // Share();

}