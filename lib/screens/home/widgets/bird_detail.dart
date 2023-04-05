/// bird_detail.dart
/// @author: Katherine Bellman, Russell Waring
/// @version: 2
/// @since: 2023-03-16
/// Bird detail dialog box

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:birdnerd/services/auth.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../model/bird_model.dart';
import '../../../model/userbird.dart';
import 'package:http/http.dart' as http;
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart' as permission;
import 'dart:io' as io;
import 'dart:core';


birdDetail(context, FirebaseAuth authInstance, AuthService auth, mounted, [UserBird? birdy, Bird? birdy2]) {

  /// Condition: Is it a user captured image?
  bool condition;
  if (birdy == null) {
    // No, it isn't
    condition = false;
  } else {
    // Yes, it is
    condition = true;
  }

  /// Permission_handler
  Future<bool> requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.request();
    return status == PermissionStatus.granted;
  }

  /// Function for saving a network image to the local device.
  Future<void> saveImage(BuildContext context, String imgUrl) async {
    String? message;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      // Request storage permission
      bool permissionGranted = await requestStoragePermission();
      if (!permissionGranted) {
        message = 'Storage permission denied';
        scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
        return;
      }
      /// Else
      // Download image
      final http.Response response = await http.get(Uri.parse(imgUrl));
      // Get temp directory
      final dir = await getTemporaryDirectory();
      // Create an image name
      DateTime date = DateTime.now();
      var fileName = '${dir.path}/${date.microsecondsSinceEpoch}.png';
      // Save the image to the temp directory
      await io.File(fileName).writeAsBytes(response.bodyBytes);
      // Save the image to the camera roll
      await GallerySaver.saveImage(fileName, albumName: 'BirdNerd');
      // Delete temp directory
      dir.deleteSync(recursive: true);
      message = 'Image saved to camera roll';

    } catch (e) {
      message = 'An error occurred while saving the image';
    }
    scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
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
          content: SizedBox(
            height: 420,
            width: 320,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                  left: 8.0, bottom: 8.0, top: 1.0, right: 1.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.lightGreen.shade800,
                            size: 30.00,
                          ))),
                  Center(
                      child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  clipBehavior: Clip.antiAlias,
                                  child: SizedBox(
                                    height: 200,
                                    width: 200,
                                    child: FittedBox(
                                      child: Image.network(
                                        condition ? birdy!.url : birdy2!.url,
                                        // scale: 0.5,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  condition
                                      ? birdy!.commonName.toString()
                                      : birdy2!.commonName.toString(),
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.lightGreen.shade800,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: "Oswald"),
                                ),
                                Text(
                                  condition
                                      ? birdy!.scientificName.toString()
                                      : birdy2!.scientificName.toString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Oswald"),
                                ),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                          // width: double.infinity,
                                          // height: 60,
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: // IconButton(
                                              // onPressed: () {
                                              // /// Launch map page where marker is
                                              //
                                              // },
                                              // icon: Icon(Icons.location_on_sharp,
                                              // color: Colors.lightGreen.shade800,
                                              // size: 50,),
                                              // ),
                                              condition
                                                  ? IconButton(
                                                onPressed: () async {
                                                    saveImage(context, birdy!.url);
                                                    Navigator.pop(context);
                                                },
                                                icon: Icon(
                                                  Icons.file_download,
                                                  color: Colors.lightGreen.shade800,
                                                  size: 50,
                                                ),
                                              )
                                                  : const Text('')),
                                    ]),
                              ])))
                ],
              ),
            ),
          ),
        );
      });
}
