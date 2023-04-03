/// database.dart
/// author    Katherine Bellman, Russell Waring
/// version 3
/// 2023.03.25

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:birdnerd/model/bird.dart';
import 'package:birdnerd/model/marker.dart';
import 'package:birdnerd/shared/globals.dart' as globals;
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../model/userbird.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<List<Bird>> getBirds() async {
    QuerySnapshot snapshot =
        await _db.collection('Durham_Birds_CA').orderBy('Id').get();
    List<Bird> birds = snapshot.docs
        .map((doc) => Bird.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    return birds;
  }

  static Future<List<Bird>> getBirdsByScientificName(
      List<String> scientificNames) async {
    QuerySnapshot snapshot = await _db
        .collection('Durham_Birds_CA')
        .where('Scientific Name', whereIn: scientificNames)
        .get();
    List<Bird> birds = snapshot.docs
        .map((doc) => Bird.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    return birds;
  }

  /// Map Marker database logic
  static final CollectionReference markersCollection =
      FirebaseFirestore.instance.collection('markers');

  static Future<void> updateUserMarkers(String uid, String commonName,
      String date, double latitude, double longitude, String image) async {
    // Add a new document to the markers collection with the given marker data
    await markersCollection.add({
      'uid': uid,
      'commonName': commonName,
      'date': date,
      'latitude': latitude,
      'longitude': longitude,
      'image': image,
    });
  }

  static Future<List<MyMarker>> getUserMarkers(String uid) async {
    QuerySnapshot snapshot =
        await _db.collection('markers').where('uid', isEqualTo: uid).get();
    List<MyMarker> markers = snapshot.docs
        .map((doc) => MyMarker.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    return markers;
  }

  /// Uploads an image to the Firebase storage.
  /// Takes a file.path as parameter
  static Future<String> uploadImage(String filepath) async {
    final file = File(filepath);
    final bytes = await file.readAsBytes();
    final storageRef = FirebaseStorage.instance.ref().child(filepath);
    final uploadTask = storageRef.putData(bytes);
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  /// Logic for user list
  static final CollectionReference userListCollection =
      FirebaseFirestore.instance.collection('user-list');

  static Future<void> updateUserList(
      String uid, Bird bird, String imagePath) async {
    String imgUrl = await uploadImage(imagePath);
    // Add a new document to the markers collection with the given marker data
    await userListCollection.add({
      'id': bird.id,
      'uid': uid,
      'commonName': bird.commonName,
      'scientificName': bird.scientificName,
      'imgUrl': imgUrl,
    });
  }

  static Future<List<UserBird>> getUserList(String uid) async {
    QuerySnapshot snapshot =
        await _db.collection('user-list').where('uid', isEqualTo: uid).get();
    List<UserBird> userList = snapshot.docs
        .map((doc) => UserBird.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    return userList;
  }
}
