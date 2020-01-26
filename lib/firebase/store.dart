import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:mythesis96/firebase/constance.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class StoreSer {
  static Future<String> uploadUserProfileImage(
      String url, File imageFile) async {
    String photoId = Uuid().v4();
    File image = await compressImage(photoId, imageFile);
    //ในกรณีเปลี่ยนรูป จะไปแทนรูปเก่า
    if (url.isNotEmpty) {
      RegExp exp = RegExp(r'userProfile_(.*).jpg');
      photoId = exp.firstMatch(url)[1];
      print(photoId);
    }

    ///????????????????????????????????????
    StorageUploadTask uploadTask = storageRef
        .child('images/users/userProfile_$photoId.jpg')
        .putFile(image);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String dowloadUrl = await storageSnap.ref.getDownloadURL();
    return dowloadUrl;
  }

  static Future<File> compressImage(String photoId, File image) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    File compressedImageFile = await FlutterImageCompress.compressAndGetFile(
      image.absolute.path,
      '$path/img_$photoId.jpg',
      quality: 70,
    );
    return compressedImageFile;
  }

  static Future<String> uploadpost(File imageFile) async {
    String photoId = Uuid().v4();
    File image = await compressImage(photoId, imageFile);
    // File image1 = await compressImage(photoId, imageFile1);

    //ในกรณีเปลี่ยนรูป จะไปแทนรูปเก่า
    // if (url.isNotEmpty){
    //   RegExp exp = RegExp(r'userProfile_(.*).jpg');
    //   photoId = exp.firstMatch(url)[1];
    //   print(photoId);
    // }
    ///????????????????????????????????????
    StorageUploadTask uploadTask =
        storageRef.child('images/driver/cartax_$photoId.jpg').putFile(image);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String dowloadUrl = await storageSnap.ref.getDownloadURL();
    return dowloadUrl;
  }

  static Future<String> uploadpost1(
    File imageFile1,
  ) async {
    String photoId1 = Uuid().v4();
    //File image = await compressImage(photoId, imageFile);
    File image1 = await compressImage(photoId1, imageFile1);

    StorageUploadTask uploadTask = storageRef
        .child('images/driver/drivelicense_$photoId1.jpg')
        .putFile(image1);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String dowloadUrl = await storageSnap.ref.getDownloadURL();
    return dowloadUrl;
  }
}
