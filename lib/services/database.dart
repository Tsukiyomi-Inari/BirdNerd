import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:birdnerd/model/birds.dart';

class DatabaseService{
  final origBirdList = 'gs://bird-nerd-15f35.appspot.com/Durham_Birds_CA.json';

  final dbRef = FirebaseDatabase.instance.ref();




}