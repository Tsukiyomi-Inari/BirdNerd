/// identification.dart
/// @authors:   Katherine Bellman, Russell Waring
/// @version:   1
/// @since:     2023-02-20
/// The identification page is the first step in directing the user to confirm
/// what species of bird has been captured in their photo.

import 'package:flutter/material.dart';
import 'package:birdnerd/shared/globals.dart' as globals;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class IdentificationScreen extends StatefulWidget {
  const IdentificationScreen({Key? key}) : super(key: key);

  @override
  State<IdentificationScreen> createState() => _IdentificationScreenState();
}

class _IdentificationScreenState extends State<IdentificationScreen> {

  // Import the imagePath of the captured image from the globals library
  final String imagePath = globals.filepath;
  // Identified bird name is passed to this variable
  late String _scientificName;
  // Used for loading state before result is identified
  late bool _isLoading = true;

  /// Override initialize state method to immediately call for image recognition
  @override
  void initState() {
    super.initState();
    _getScientificName();
  }

  Future<void> _getScientificName() async {
    final imageFile = File(imagePath);
    await getScientificName(imageFile);
    setState(() {
      _isLoading = false;
    });
  }

  /// getScientificName(File imageFile)
  /// imageFile: absolute path of captured image
  /// Method that sends post request of image to RapidAPI Bird-Classifier and
  /// returns JSON result set.
  Future<void> getScientificName(File imageFile) async {
    final url = Uri.parse('https://bird-classifier.p.rapidapi.com/BirdClassifier/prediction?results=1');
    final request = http.MultipartRequest('POST', url)
      ..headers.addAll({
        'Content-Type': 'multipart/form-data; boundary=---011000010111000001101001',
        'X-Rapidapi-Key': 'cbe9ca80d5msh13ad95efa239d2bp1a09fejsna8ba16c0268d',
        'X-Rapidapi-Host': 'bird-classifier.p.rapidapi.com',
      });
    final fileStream = http.ByteStream(imageFile.openRead());
    final fileLength = await imageFile.length();
    final multipartFile = http.MultipartFile('image', fileStream, fileLength, filename: imageFile.path);

    request.files.add(multipartFile);

    final response = await request.send();
    final responseData = await response.stream.bytesToString();
    final decodedData = jsonDecode(responseData);
    Map<String, dynamic> birdPrediction = decodedData[0];
    print('Wow, it\s a ${birdPrediction['scientificName']}!');
    // print(decodedData[0].toString());
    _scientificName = birdPrediction['scientificName'];

    /// TODO: compare _scientificName with names in database, return common name and image



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: const Text(
          'Confirm if there is a match',
          style: TextStyle(
              fontSize: 18,
              color: Colors.black54
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      /// The image is stored as a file on the device. Use the `Image.file`
      /// constructor with the given path to display the image.
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                //height: double.infinity,
                color: Colors.teal,
                padding: const EdgeInsets.all(15.0),
                /// Using hardcoded image for testing purposes
                child: Image.file(File(imagePath)),
              ),
            ),
            const SizedBox(height:30.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.all(10),
                width: double.infinity,
                color: Colors.teal,
                child: Center(
                  child: _isLoading ? CircularProgressIndicator() : Text(_scientificName),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),foregroundColor: MaterialStateProperty.all<Color>(Colors.black)),
              child: const Text('CONFIRM'),
            ),
          ],
        ),
      ),
    );
  }
}