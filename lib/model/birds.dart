///*
/// @author:   Katherine Bellman, Russell Waring
/// @version:  1
/// @since:    2023-03-10
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:birdnerd/model/bird_model.dart';

class Birds with ChangeNotifier{

 /*final List<Bird> _lifeList = [
    Bird(
        id: "1",
        birdCommon: "Alder/Willow Flycatcher (Traill's Flycatcher)",
        birdScientific: "Empidonax alnorum/traillii",
        imageUrl: "https://cdn.download.ams.birds.cornell.edu/api/v1/asset/481076421"),
    Bird(
        id: "2",
        birdCommon: "American Avocet",
        birdScientific: "Recurvirostra americana",
        imageUrl: "https://cdn.download.ams.birds.cornell.edu/api/v1/asset/341874291"),
    Bird(
        id: "3",
        birdCommon: "American Black Duck",
        birdScientific: "Anas rubripes",
        imageUrl: "https://cdn.download.ams.birds.cornell.edu/api/v1/asset/475958481"),
    Bird(
        id: "4",
        birdCommon: "American Crow",
        birdScientific: "Corvus brachyrhynchos",
        imageUrl: "https://cdn.download.ams.birds.cornell.edu/api/v1/asset/393271701"),
    Bird(
        id: "5",
        birdCommon: "American Goldfinch",
        birdScientific: "Spinus tristis",
        imageUrl: "https://cdn.download.ams.birds.cornell.edu/api/v1/asset/3456401051")

  ];*/

 List<Bird> _userList = [];

  //Create New User List
  Future<void> userLifeList(String uid) async {
    final url2 = Uri.parse(
        'http://bird-nerd-15f35-default-rtdb.firebaseio.com/Durham_Birds_CA.json');
    final url = Uri.https(
        'bird-nerd-15f35-default-rtdb.firebaseio.com/', 'userList/$uid.json');

    try {
      //get the Durham_Birds_CA list
      final response = await http.get(url2);
      final orgDat = json.decode(response.body) as Map<String, dynamic>;

      //copy each list item to new userList document
      orgDat.forEach((id, birdDat) {
        http.patch(url, body: jsonEncode({
          'Id': birdDat.id,
          'Common Name': birdDat.birdCommon,
          'Scientific Name': birdDat.birdScientific,
          'Img Url': birdDat.imageUrl,
          'Taken': birdDat.isTaken
        }),).then((response) {
          final newBird = Bird(
              id: birdDat.id,
              birdCommon: birdDat.birdCommon,
              birdScientific: birdDat.birdScientific,
              imageUrl: birdDat.imageUrl,
              isTaken: birdDat.isTaken
          );
          _userList.add(newBird);
      });
        notifyListeners();
      });

    }
    catch (error) {
      rethrow;
    }
  }


  List<Bird> get entries{
    return _userList;
  }


    //Get user life list
   Future<void> get lifeList async {
      final FirebaseAuth uid = FirebaseAuth.instance;
      final url = Uri.parse('http://bird-nerd-15f35-default-rtdb.firebaseio.com/userList/$uid.json');
      try{
        // Get THIS userList
         final response = await http.get(url);
         // Decode userList from json
         final extractedData = json.decode(response.body) as Map<String, dynamic>;
         // Set to new Bird list
         final List<Bird> userList = [];
        extractedData.forEach((listId, listData) {
          userList.add(Bird(
            id: listId,
            birdCommon: listData['Common Name'],
            birdScientific: listData['Scientific Name'],
            imageUrl: listData['Img Url'],
            isTaken: listData['Taken']
          ));
        });
       _userList = userList;
      notifyListeners();
      }catch(error){
        rethrow;
      }
    }


    //Gets the version of the list where user added a bird entry(aka photo was taken)
  List<Bird> get takenPhotos {
    return _userList.where((birdPhoto) => birdPhoto.isTaken).toList();
  }

 // Updates an entry in the user's life list
  Future<void> addBirdListEntry(Bird birds, User uid) async {
    final url = Uri.https(
        'bird-nerd-15f35-default-rtdb.firebaseio.com/', 'userList/$uid.json');
    return http.patch(url, body: jsonEncode({
      'Id': birds.id,
      'Common Name': birds.birdCommon,
      'Scientific Name': birds.birdScientific,
      'Img Url': birds.imageUrl,
      'Taken': birds.isTaken
    }),).then((response) {
      final newBird = Bird(
          id: birds.id,
          birdCommon: birds.birdCommon,
          birdScientific: birds.birdScientific,
          imageUrl: birds.imageUrl,
          isTaken: birds.isTaken
      );
      _userList.add(newBird);
      notifyListeners();
    });
  }

}




