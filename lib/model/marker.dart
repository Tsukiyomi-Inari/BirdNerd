/// marker.dart
/// author    Katherine Bellman, Russell Waring
/// since     2023-03-29
/// version   1
/// A template for organizing the data associated to a map marker

import 'package:flutter/cupertino.dart';

class MyMarker {

  //TODO: decide whether uid should be a property of a marker?
  //TODO: decide whether markerId should be a property of a marker?
  late String uid;
  late String commonName;
  late String date;
  late double latitude;
  late double longitude;
  late String imgUrl;

  MyMarker({ required this.uid, required this.commonName, required this.date, required this.latitude, required this.longitude, required this.imgUrl });

  factory MyMarker.fromJson(Map<String, dynamic> json) {
    return MyMarker(
      uid: json['uid'] as String,
      commonName: json['commonName'] as String,
      date: json['date'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      imgUrl: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() =>
      {'uid': uid, 'commonName': commonName, 'date': date, 'latitude': latitude, 'longitude': longitude, 'image': imgUrl};
}