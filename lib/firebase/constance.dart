
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
//allowed to database
final _firestore = Firestore.instance;
final storageRef = FirebaseStorage.instance.ref();
final userRef = _firestore.collection('Users');
final postsRef = _firestore.collection('Drivers');
//final testpostsRef = _firestore.collection('/Drivers/{userId}/DriverRegis/{userId}');
//final shareRef = _firestore.collection('Shareposts');
final carRef = _firestore.collection('Car');
final reportRef = _firestore.collection('Report');
final paymentRef = _firestore.collection('Payment');
final paymentcheckRef = _firestore.collection('historycheck');
final shareRef =  _firestore.collection('Shareposts');
final notireqRef =  _firestore.collection('Notirequest');
final shareconfirmRef =  _firestore.collection('shareconfirm');
final shareRequestRef =  _firestore.collection('ShareRequest');
final notisharetRef =  _firestore.collection('Notishare');
// final userRef = _firestore.collection('Users').document().collection('Drivers');
// final userRef2 = _firestore.collection('Driver');
//final userRef2 = _firestore.collection('Users').document(uid).collection('Drivers');
