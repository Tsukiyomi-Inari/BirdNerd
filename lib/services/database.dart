/// database.dart
/// author    Katherine Bellman, Russell Waring
/// version 3
/// 2023.03.25

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:birdnerd/model/bird_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/bird_model.dart';
import '../model/marker.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Identification Related Functions
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

    // print('**********\n** TEST **\n**********');
    // print(scientificNames);
    // print('**********\n** TEST **\n**********');

    List<Bird> birds = snapshot.docs
        .map((doc) => Bird.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    return birds;
  }

  /// User List  Related functions

  Future<void> addBirdToLifeList(Bird birdy, String uid) async {
    final userLifeListCollection = FirebaseFirestore.instance
        .collection('lifeLists')
        .doc("users")
        .collection(uid)
        .doc(birdy.id.toString());

    await userLifeListCollection.set(birdy.toJson()).then((value) {
      print(" $uid - new bird added to collection");
    }).onError((error, stackTrace) {
      error = "Error: Bird was not added to life list, please try again.";
      print(error.toString());
    });
  }

  static Future<List<Bird>> getUserLifeList() async {
    //final  userLifeListCollection = FirebaseFirestore.instance.collection('lifeLists').doc("users").collection(uid!);
    final userId = FirebaseAuth.instance.currentUser?.uid.toString();
    print( "This is the UID from the getUserLifeLIst function : $userId");
    QuerySnapshot serverList = await _db.collection("lifeList").doc("users").collection(userId!).get( );
    print("This is the DocumentSnapshot from the getUserLifeLIst function : ${serverList.size} ");

    //QuerySnapshot  snapshot   = await  serverList.reference.collection(userId!).get();
    print("This is the querySnapshot from the getUserLifeLIst function : ${serverList.docs.length }  ");
    List<Bird> userList =   serverList.docs.map((doc) =>
    Bird.fromJson(doc.data() as Map<String, dynamic>)).toList();


    return userList;
  }



  /// Map Marker database logic
  // If collection doesn't exist, Fire-store will create it, and use it.
  // static CollectionReference markersCollection = FirebaseFirestore.instance.collection('markers');
  //
  // static Future<void> addMarker(Marker marker) async {
  //   await markersCollection.add({
  //     'latitude': marker.latitude,
  //     'longitude': marker.longitude,
  //     'image': marker.image,
  //   });
  // }

  /// Function inside database
  /// Future because it's async
  /// Once when they sign up, second when their data updates
  // static Future updateUserMarkers(Marker marker) async {
  //
  //   return await markersCollection.doc(uid).set({
  //     'latitude': marker.latitude,
  //     'longitude': marker.longitude,
  //     'image': marker.image,
  //   });
  // }

  static final CollectionReference markersCollection = FirebaseFirestore.instance.collection('markers');

  static Future<void> updateUserMarkers(String uid, String commonName, String date, double latitude, double longitude, String image) async {
    // Add a new document to the markers collection with the given marker data
    await markersCollection.add({
      'uid' : uid,
      'commonName' : commonName,
      'date' : date,
      'latitude': latitude,
      'longitude': longitude,
      'image': image,
    });
  }

  static Future<List<MyMarker>> getUserMarkers(String uid) async{
    QuerySnapshot snapshot = await _db.collection('markers')
        .where('uid', isEqualTo: uid)
        .get();
    List<MyMarker> markers = snapshot.docs.map((doc) =>
        MyMarker.fromJson(doc.data() as Map<String, dynamic>)).toList();
    return markers;
  }


}



