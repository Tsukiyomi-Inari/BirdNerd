import 'package:flutter/material.dart';

class Bird with ChangeNotifier{

  final String id;
  final String birdCommon;
  final String birdScientific;
  final String imageUrl;

  bool isTaken;


  Bird({
   required this.id,
   required this.birdCommon,
   required this.birdScientific,
   required this.imageUrl,
   this.isTaken = false
});

  void toggleIsTakenStatus(){
    isTaken = !isTaken;
    notifyListeners();
  }



}