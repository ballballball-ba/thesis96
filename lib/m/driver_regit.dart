import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id2;
  final String imageUrl;
  final String imageUrl1;
  //final String id;
  final dynamic likes;
  final String authorId;
  final Timestamp timestamp;
  final String testId;


  Post({
    this.id2,      
    this.imageUrl,
    this.imageUrl1,
    this.likes,
    this.authorId,
    this.timestamp,
    this.testId

  });
  factory Post.fromDoc(DocumentSnapshot doc){
    return Post(
      id2: doc.documentID,
      imageUrl: doc['PiccartaxUrl'],
      imageUrl1: doc['PicDrivelicense'],
      likes: doc['likes'],
      authorId: doc['authorId'],
      timestamp: doc['timestamp'],
      testId: doc['testid'],
    );
    
  }
}
