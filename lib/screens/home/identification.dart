/// identification.dart
/// @authors:   Katherine Bellman, Russell Waring
/// @version:   1
/// @since:     2023-02-20
/// The identification page is the first step in directing the user to confirm
/// what species of bird has been captured in their photo.

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:birdnerd/shared/globals.dart' as globals;
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io';
import 'package:birdnerd/screens/home/home.dart';
import 'package:birdnerd/services/classifier.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:birdnerd/services/database.dart';
import 'package:flutter/services.dart';
import 'package:birdnerd/model/bird.dart';
import 'package:birdnerd/model/marker.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:birdnerd/screens/home/widgets/confirm.dart' as Confirm;

import '../../services/auth.dart';

class IdentificationScreen extends StatefulWidget {
  const IdentificationScreen({super.key});
  @override
  _IdentificationScreenState createState() => _IdentificationScreenState();
}

class _IdentificationScreenState extends State<IdentificationScreen> {
  //final String imagePath;

  /// Variables
  final String imagePath = globals.filepath;
  //late List<String> _scientificNames = [];
  late String _scientificName1;
  late String _scientificName2;
  late String _scientificName3;
  // Used for loading state before result is identified
  late bool _isLoading = true;

  late List<Bird> birds;

  // Used for sending user id to database for markers
  final AuthService _auth =  AuthService();
  final _authInstance = FirebaseAuth.instance;


  final List<Bird> birdList = [];

  late List<String> nameList =[
    '',
    '',
    ''
  ];

  //final List<String> birdPredictions = [];

  final CarouselController _carouselController = CarouselController();

  // Variable for carousel index
  int _currentIndex = 0;

  //get http => null;

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
      //birds = value;
    });
  }

  /// getScientificName(File imageFile)
  /// imageFile: absolute path of captured image
  /// Method that sends post request of image to RapidAPI Bird-Classifier and
  /// returns JSON result set.
  Future<void> getScientificName(File imageFile) async {
    final url = Uri.parse('https://bird-classifier.p.rapidapi.com/BirdClassifier/prediction?results=3');
    final request = http.MultipartRequest('POST', url)
      ..headers.addAll({
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
    Map<String, dynamic> birdPrediction1 = decodedData[0];
    Map<String, dynamic> birdPrediction2 = decodedData[1];
    Map<String, dynamic> birdPrediction3 = decodedData[2];
    _scientificName1 = birdPrediction1['scientificName'];
    _scientificName2 = birdPrediction2['scientificName'];
    _scientificName3 = birdPrediction3['scientificName'];

    nameList[0] = _scientificName1;
    nameList[1] = _scientificName2;
    nameList[2] = _scientificName3;


    /// TODO: compare _scientificName with names in database, return common name and image

    //List<Bird> matchPredictions;
    // matchPredictions = await DatabaseService.getBirdsByScientificName(nameList);

    try {
      final matchPredictions = await DatabaseService.getBirdsByScientificName(nameList);

      for(var i = 0; i< matchPredictions.length; i++) {
        birdList.add(matchPredictions[i]);
      }

      Bird birdy = Bird(
          commonName: 'Unable to identify',
          id: 0,
          scientificName: 'Unable to identify',
          url: 'https://t3.ftcdn.net/jpg/03/53/78/32/360_F_353783241_kJr5np3yVR0hgzMsgON96DmqRkcMIoRs.jpg'
      );
      birdList.add(birdy);
    } catch (e) {
      print(e.toString()); // print any errors or exceptions
    }
  }

  @override
  Widget build(BuildContext context) {
    //final birdClassifier = Provider.of<Classifier>(context);
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        backgroundColor: Colors.lightGreen.shade800,
        centerTitle: true,
        title: const Text(
          'Confirm if there is a match',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('AlertDialog Title'),
                content: const Text("Reset"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),

      /// The image is stored as a file on the device. Use the `Image.file`
      /// constructor with the given path to display the image.
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "https://firebasestorage.googleapis.com/v0/b/bird-nerd-15f35.appspot.com/o/Splash%20background%20color.png?alt=media&token=d56e2f5a-2d56-47fc-9a28-0de2108eb82d"),
              fit: BoxFit.cover,
            )),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(
                    minHeight: 220,
                  ),
                  margin: const EdgeInsets.only(top: 10),
                  color: const Color.fromRGBO(161, 214, 107, 50.00),
                  padding: const EdgeInsets.all(15.0),
                  child: ClipRect(
                    child: Image.file(File(imagePath)),
                    ),
                  ),
                ),
              const SizedBox(height: 15.0),
              Expanded(
                child: Container(
                    constraints: const BoxConstraints(
                      maxHeight: 220,
                    ),
                    width: double.infinity,
                    height: 220,
                    color: const Color.fromRGBO(161, 214, 107, 50.00),
                    child:
                    CarouselSlider.builder(
                        itemCount: birdList.length,
                        carouselController: _carouselController,
                        itemBuilder: (ctx, index, realIdx) {
                          return Center(
                              child:
                              //_isLoading ? const CircularProgressIndicator() : Text (nameList[index]),
                              //_isLoading ? const CircularProgressIndicator() : Image.network(birdList[index].url),
                              _isLoading
                                  ? const CircularProgressIndicator()
                                  : Stack(
                                children: [
                                  Image.network(birdList[index].url),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child:
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Text(
                                        birdList[index].commonName,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ),
                                ]
                              ),
                          );
                        },
                        options: CarouselOptions(
                          enableInfiniteScroll: birdList.length > 1,
                          aspectRatio: 1 / 1,
                          //initialPage: 0,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          }
                          //height: 200,
                          // viewportFraction: 0.5,
                          //enlargeFactor: 1.0
                        ))),
              ),
              const SizedBox(height: 15.0),
              TextButton(
                onPressed: () async {
                  //await generateMapMarker();
                  Confirm.show(context, birdList[_currentIndex], _authInstance);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen.shade800,
                  minimumSize: const Size(130, 50),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text(
                  'CONFIRM',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Teko",
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
              ),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}