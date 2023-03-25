import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:birdnerd/model/bird.dart';
import 'package:flutter/services.dart';


class DatabaseService {

  final String? uid;
  DatabaseService({ this.uid });

  // Collection reference. If it doesn't exist, will be created
  //final databaseReference = FirebaseDatabase.instance.ref();


  // final DatabaseReference ref = FirebaseDatabase.instance.ref("Durham_Birds_CA");
  //
  // /// Real-time Database function for retrieving list of birds.
  // static showBirds() async {
  //   //DatabaseReference ref = FirebaseDatabase.instance.ref("Durham_Birds_CA");
  //   DatabaseReference ref = FirebaseDatabase.instance.ref("Durham_Birds_CA/0");
  //   // Get the data once
  //   DatabaseEvent event = await ref.once();
  //   // Print the data of the snapshot
  //   print('********** Test whether the showBirds method triggers **********');
  //   print(event.snapshot.value);
  // }

  // /// Firestore logic
  // final CollectionReference birdCollection = FirebaseFirestore.instance.collection('Durham_Birds_CA');
  // //print(birdCollection);
  //
  // // Bird list from a snapshot (bird list from a snapshot)
  // List<Bird> _birdListFromSnapshot(QuerySnapshot snapshot)  {
  //   return snapshot.docs.map((doc){
  //     return Bird(
  //         commonName: doc.get('Common Name') ?? 'Not available',
  //         id: doc.get('Id') ?? 0,
  //         imgUrl: doc.get('Img Url') ?? 'Not available',
  //         scientificName: doc.get('Scientific Name') ?? 'Not available'
  //     );
  //   }).toList();
  // }
  //
  // Stream<List<Bird>> get birds {
  //   print('*H*E*L*L*O* *M*O*T*T*O*');
  //   return birdCollection.snapshots().map(_birdListFromSnapshot);
  // }

  // Future <Stream<List<Bird>>> getBirdList() async {
  //
  //   Stream<QuerySnapshot> stream =
  //   FirebaseFirestore.instance.collection('Durham_Birds_CA').snapshots();
  //
  //   return stream.map(
  //           (qShot) => qShot.docs.map(
  //               (doc) => Bird(
  //               commonName: doc.get('Common Name') ?? 'Not available',
  //               id: doc.get('Id') ?? 0,
  //               imgUrl: doc.get('Img Url') ?? 'Not available',
  //               scientificName: doc.get('Scientific Name') ?? 'Not available')
  //       ).toList()
  //   );
  // }

  // static Future<List<Bird>> getBirds() async {
  //   QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Durham_Birds_CA').get();
  //
  //   List<Bird> birds = snapshot.docs.map((doc) => Bird.fromJson(doc.data())).toList();
  //
  //   return birds;
  // }

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // static Future<List<Bird>> getBirds() async {
  //   QuerySnapshot snapshot = await _db.collection('Durham_Birds_CA').get();
  //
  //   List<Bird> birds = snapshot.docs.map((doc) => Bird.fromJson(doc.data())).toList();
  //
  //   return birds;
  // }

  static Future<List<Bird>> getBirds() async {
    QuerySnapshot snapshot = await _db.collection('Durham_Birds_CA').orderBy('Id').get();
    List<Bird> birds = snapshot.docs.map((doc) => Bird.fromJson(doc.data() as Map<String, dynamic>)).toList();
    return birds;
  }
}
