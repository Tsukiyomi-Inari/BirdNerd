/// userbird.dart
/// author    Katherine Bellman, Russell Waring
/// since     2023-04-02
/// version   1
/// A template for outputting the data associated to a user discovered bird

import 'package:flutter/cupertino.dart';

class UserBird with ChangeNotifier{
  final String commonName;
  final int id;
  final String scientificName;
  final String url;
  final String uid;

  UserBird({ required this.commonName, required this.id, required this.scientificName, required this.url, required this.uid});

  factory UserBird.fromJson(Map<String, dynamic> json) {
    return UserBird(
      commonName: json['commonName'] as String,
      id: json['id'] as int,
      scientificName: json['scientificName'] as String,
      url: json['imgUrl'] as String,
      uid: json['uid'] as String,
    );
  }

  Map<String, dynamic> toJson() =>
      {'commonName': commonName, 'id': id, 'scientificName': scientificName, 'imgUrl': url, 'uid': uid};
}