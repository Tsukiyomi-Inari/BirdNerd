///*
/// @author:   Katherine Bellman, Russell Waring
/// @version:  1
/// @since:    2023-03-16
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class StorageService{

  // Get Storage bucket
  final storageRef = FirebaseStorage.instance.ref();

// Upload entry photo to storage in firebase
  Future<void> uploadImage(String birdImg, String birdId)async {
    storageRef.child("$Image.network(birdImg)")
        .putFile(File(birdImg), SettableMetadata(
      contentType: birdId
    ) );
  }


}