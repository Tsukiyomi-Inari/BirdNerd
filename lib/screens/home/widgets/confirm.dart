/// confirm.dart
/// @author:    Katherine Bellman, Russell Waring
/// @version:   1
/// @since:     2023-04-02
/// Confirmation after confirming bird from id screen.

import 'package:flutter/material.dart';
import 'package:birdnerd/shared/globals.dart' as globals;
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'package:birdnerd/services/database.dart';
import 'package:birdnerd/model/bird_model.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

import '../../../services/storage.dart';

show(context, Bird bird, FirebaseAuth authInstance) {

  /// Get user id
  String? uid = authInstance.currentUser?.uid.toString();

  final currentContext = context;

  Future<String> cropCircle() async {
    /// Capture image for map marker and crop as a circle
    // 1) Load the image file into memory
    img.Image cropImage = img.decodeImage(File(globals.filepath).readAsBytesSync())!;
    // 2) Calculate the diameter of the circle as a percentage of the smaller dimension
    int diameter = (cropImage.width < cropImage.height ? cropImage.width : cropImage.height);
    // 3) Calculate the coordinates of the top-left corner of the crop region to center the circle in the image
    int x = (cropImage.width - diameter) ~/ 2;
    int y = (cropImage.height - diameter) ~/ 2;
    // 4) Crop the circular region from the input image
    img.Image croppedImage = img.copyCrop(cropImage, x: x, y: y, width: diameter, height: diameter, radius: diameter/2);
    var rgba = croppedImage.convert(numChannels: 4); // make sure the image has an alpha channel
    croppedImage = img.copyCropCircle(rgba);
    // 5) Create temporary file path
    final tempDir = await getTemporaryDirectory(); // get temporary directory
    final tempFile = File('${tempDir.path}/circular_image.png'); // create temporary file
    tempFile.writeAsBytesSync(img.encodePng(croppedImage)); // write image bytes to file
    // 6) Upload the image to storage as bytes and get the url
    String cropImageUrl = await StorageService.uploadImageOnly(tempFile.path);
    // 7) Delete the temporary file
    tempFile.deleteSync();
    return cropImageUrl;
  }

  Future<void> generateMapMarker(Bird bird, uid) async {
    /// Get circle crop image for marker
    String markerIcon = await cropCircle();
    /// Capture Date for timestamp on marker
    DateTime date = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    /// Retrieve bird name
    DatabaseService.updateUserMarkers(uid, bird.commonName, formattedDate, globals.latitude!, globals.longitude!, markerIcon);
  }

  /// Variable for unidentified bird
  bool _recognized = false;

  if(bird.commonName == 'Unable to identify'){
    // Cannot store, give a button that says 'post to forum'
    _recognized = false;
  } else{
    _recognized = true;
  }

  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                20.0,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.only(
            top: 10.0,
          ),
          //title: Text(_authInstance.currentUser?.email ?? 'Anonymous' , style: const TextStyle(fontSize: ),)
          //style: TextStyle(fontSize: 24.0),
          //),
          content: Container(
            height: 400,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
              Container(
              alignment: Alignment.topRight,
                  child: IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon:  Icon(
                    Icons.close,
                    color: Colors.lightGreen.shade800 ,
                    size: 30.00,
                    opticalSize: 20.00,
                  ) )),
               Padding(
                padding: const EdgeInsets.all(8.0),
                /// Dialog window title
                child: Center(child: Text(
                    _recognized ? 'Confirm' : 'Unidentified'
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                /// Dialog window body
                child: Text(
                  _recognized ? 'Confirm the match and view your discovery on the life list page!'
                      : 'Unable to identify. Post to our website for assistance.',
                  style: const TextStyle(fontSize: 12,
                      fontFamily: "Oswald",
                      fontStyle: FontStyle.normal,
                      textBaseline: TextBaseline.alphabetic
                  ),
                  softWrap: true,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.visible,
                ),
              ),

            Container(
              width: double.infinity,
              height: 60,
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  if(_recognized){
                    await DatabaseService.updateUserList(uid!, bird, globals.filepath);
                    await generateMapMarker(bird, uid);
                  }else{
                    // do nothing
                  }
                  Navigator.of(currentContext).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen.shade800,
                  minimumSize: const Size(134, 50),
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                /// Dialog window button
                child: Text(
                  _recognized ? "Confirm" : "Post to forum",
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: "Teko",
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
                  ],

          ),
        ),
        ));
      });
}