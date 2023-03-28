/// database.dart
/// author    Katherine Bellman, Russell Waring
/// version 3
/// 2023.03.25

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:birdnerd/model/bird_model.dart';

import '../model/bird_model.dart';

class DatabaseService {

  final String? uid;

  DatabaseService({ this.uid });

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<List<Bird>> getBirds() async {
    QuerySnapshot snapshot = await _db.collection('Durham_Birds_CA').orderBy(
        'Id').get();
    List<Bird> birds = snapshot.docs.map((doc) =>
        Bird.fromJson(doc.data() as Map<String, dynamic>)).toList();
    return birds;
  }

  static Future<List<Bird>> getBirdsByScientificName( List<String> scientificNames ) async {


    QuerySnapshot snapshot = await _db.collection('Durham_Birds_CA').where(
        'Scientific Name', whereIn: scientificNames).get();

    // print('**********\n** TEST **\n**********');
    // print(scientificNames);
    // print('**********\n** TEST **\n**********');

    List<Bird> birds = snapshot.docs.map((doc) =>
        Bird.fromJson(doc.data() as Map<String, dynamic>)).toList();
    return birds;
  }





}