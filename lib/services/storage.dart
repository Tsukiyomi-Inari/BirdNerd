///*
/// @author:   Katherine Bellman, Russell Waring
/// @version:  1
/// @since:    2023-03-16
import 'dart:io';
import 'package:birdnerd/shared/globals.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../model/bird_model.dart';

class StorageService{
  final String? uid;

  StorageService({ this.uid });

  // Get Storage bucket
  final storageRef = FirebaseStorage.instance.ref();

  // /// Uploads an image to the Firebase storage.
  // /// Takes a file.path as parameter
  static Future<String> uploadImageOnly(String filepath) async {
    final file = File(filepath);
    final bytes = await file.readAsBytes();
    final storageRef = FirebaseStorage.instance.ref().child(filepath);
    final uploadTask = storageRef.putData(bytes);
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

// Upload entry photo to storage in firebase
  Future<TaskSnapshot> uploadImage(Reference storageRef, File birdImgPath, String birdId, String uid, [String ?longitude, String ?lattitude])async {
   late TaskSnapshot snapshot;
    final metaData = SettableMetadata(
      contentType: "image/jpeg",
      customMetadata: {
        "longitude" : "$longitude",
        "lattitude": "$lattitude",
        "userId": uid,
        "birdId": birdId
      },
    );

          final UploadTask uploadTask  =  storageRef.child("${uid}_$birdId").putFile(birdImgPath, metaData);
          snapshot = await uploadTask.whenComplete(() {});
            return snapshot;
  }

  Future<File> downloadBirdImage(Bird birdy) async{
    try{
          final birdImageRef = storageRef.child("${Image.network(birdy.url)}");
          final File downloadFile = File(birdImageRef.fullPath);
         // final downloadTask = storageRef.writeToFile(downloadFile);
      return downloadFile;
  }catch(error){
      rethrow;
    }
  }



}