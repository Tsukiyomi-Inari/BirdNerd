/// classifier.dart
/// @authors:   Katherine Bellman, Russell Waring
/// @version:   1
/// @since:     2023-03-16

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:birdnerd/.env' as classifier;

class Classifier{

  //File path of to be identified image
  late final File birdImg ;
  //List of image urls of matching birds from prediction
  List<String> imgUrlsReturned = [];
//List for returned predictions
  List<String> birdPredictions = [];



  //Get prediction of bird match
Future<http.Response> getPredictions(String imgPath) async{

  final birdAPIurl = Uri.https("BirdClassifier","prediction\/?results=12");
  //birdAPI
try {
    final response = await http.post(birdAPIurl,
      headers: {
        "X-RapidAPI-Key": classifier.XRAPIDAPIKEY,
        "X-RapidAPI-HOST": classifier.XRAPIDAPIHOST
      },
      body: {
      "image": imgPath
    }
  );
    final extrated = json.decode(response.body) as Map<String, dynamic>;
  print(extrated.values);
  return response;
}catch(error){
  print("Error with getPreditctions function: $error ");
  rethrow;
}
  }



//find returned matches in Durham_Birds_CA list


//return matches image urls as list


}
