/// bird_model.dart
/// author:   Katherine Bellman, Russell Waring
/// date:     2023-03-01
/// version:  1
/// Class for handling information related to birds.

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