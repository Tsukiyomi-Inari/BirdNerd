/// bird.dart
/// 2023-03-21
/// A template for outputting the data associated to a bird

import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class Bird with ChangeNotifier{
  final String commonName;
  final int id;
  final String scientificName;
  final String url;


  Bird({ required this.commonName, required this.id, required this.scientificName, required this.url});

  factory Bird.fromJson(Map<String, dynamic> json) {
    return Bird(
      commonName: json['Common Name'] as String,
      id: json['Id'] as int,
      scientificName: json['Scientific Name'] as String,
      url: json['Img Url'] as String
    );
  }

  Map<String, dynamic> toJson() =>
      {'Common Name': commonName, 'Id': id, 'Scientific Name': scientificName, 'Url': url, };
}