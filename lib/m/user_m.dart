import 'package:cloud_firestore/cloud_firestore.dart';

class User{

  final String id;//uid on firebase
  final String name;
  final String profileImgUrl;
  final String email;
  final String gender;
  final String bio;
  //final String driver;
  User({
    this.id,
    this.name,
    this.profileImgUrl,
    this.email,
    this.gender,
    this.bio,
    //this.driver,
  });

 factory User.fromDoc(DocumentSnapshot doc) {
   return User(
     id: doc.documentID,
     name: doc['username'],
     profileImgUrl: doc['picprofileUrl'],
     email: doc['email'],
     gender: doc['gender'],
     bio: doc['bio'] ?? '',
     //cartax: doc['email'],
     //driver: doc['pic'],
    // driver: doc.documentID.['Drivers'],
   );
 }

  

}



