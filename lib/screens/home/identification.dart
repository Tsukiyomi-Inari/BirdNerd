/// identification.dart
/// @authors:   Katherine Bellman, Russell Waring
/// @version:   1
/// @since:     2023-02-20
/// The identification page is the first step in directing the user to confirm
/// what species of bird has been captured in their photo.

import 'dart:convert';
import 'package:birdnerd/services/storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:birdnerd/shared/globals.dart' as globals;
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io';
import 'package:birdnerd/screens/home/home.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:birdnerd/services/database.dart';
import '../../model/bird_model.dart';
import 'package:birdnerd/.env';
import '../../shared/loading.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';


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

final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService _db = DatabaseService();

  final List<Bird> birdList = [];

  late List<String> nameList =[
    '',
    '',
    ''
  ];

  //final List<String> birdPredictions = [];

  final CarouselController _carouselController = CarouselController();
  late int _currentIndex = 0;

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
        'X-Rapidapi-Key': XRAPIDAPIKEY,
        'X-Rapidapi-Host': XRAPIDAPIHOST,
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
    //print('Wow, it\s a ${birdPrediction['scientificName']}!');
    // print(decodedData[0].toString());
    _scientificName1 = birdPrediction1['scientificName'];
    _scientificName2 = birdPrediction2['scientificName'];
    _scientificName3 = birdPrediction3['scientificName'];
    //print(_scientificName1);

    nameList[0] = _scientificName1;
    nameList[1] = _scientificName2;
    nameList[2] = _scientificName3;

    //print(nameList);

    //List<Bird> matchPredictions;
    // matchPredictions = await DatabaseService.getBirdsByScientificName(nameList);

    try {
      final matchPredictions = await DatabaseService.getBirdsByScientificName(nameList);

      //print(matchPredictions[0].url); // check if the list is empty or contains data

      for(var i = 0; i< matchPredictions.length; i++) {
        birdList.add(matchPredictions[i]);
        // print('**********\n** TEST **\n**********');
        // print(birdList[i].commonName);
        // print('**********\n** TEST **\n**********');
      }
      Bird birdy = Bird(
          commonName: 'Unable to identify',
          id: 209,
          scientificName: 'Unable to identify',
          url: 'https://firebasestorage.googleapis.com/v0/b/bird-nerd-15f35.appspot.com/o/NotFound-Graphic.png?alt=media&token=4dc6b7c2-4dbd-4f3b-a42c-b6af08a5c10b'
      );

      birdList.add(birdy);
      // print('**********\n** TEST **\n**********');
      // print(birdList.length);
      //
      // print('**********\n** TEST **\n**********');


    } catch (e) {
      print(e.toString()); // print any errors or exceptions
    }


    // print('**********\n** TEST **\n**********');
    //print(matchPredictions);
    // print(matchPredictions[1]);
    // print(matchPredictions[2]);
    // print('**********\n** TEST **\n**********');

  }


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
    String cropImageUrl = await StorageService.uploadImageOnly(tempFile.path.toString());
    // 7) Delete the temporary file
    tempFile.deleteSync();
    return cropImageUrl;
  }

  Future<void> generateMapMarker() async {
    /// Get user id
    String? uid = _auth.currentUser?.uid.toString();
    /// Get circle crop image for marker
    String markerIcon = await cropCircle();
    /// Capture Date for timestamp on marker
    DateTime date = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    /// Retrieve bird name
    DatabaseService.updateUserMarkers(uid!, birdList[_currentIndex].commonName, formattedDate, globals.latitude!, globals.longitude!, markerIcon!);
  }


  @override
  Widget build(BuildContext context) {
    //final birdClassifier = Provider.of<Classifier>(context);
    return _isLoading ? const Loading() : Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        backgroundColor: Colors.lightGreen.shade800,
        centerTitle: true,
        title: const Text(
          'Confirm bird',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
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
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(
                    minHeight: 220,
                  ),
                  margin: const EdgeInsets.only(top: 10),
                  //height: double.infinity,
                  color: const Color.fromRGBO(161, 214, 107, 50.00),
                  padding: const EdgeInsets.all(15.0),
                  //child: Image.file(File(imagePath)),
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
                    //padding: const EdgeInsets.all(15.0),
                    //margin: const EdgeInsets.all(10),
                    width: double.infinity,
                    height: 220,
                    color: const Color.fromRGBO(161, 214, 107, 50.00),
                    child: /*TextButton(
                    onPressed: () {},
                    child: const Text(
                      'AI Suggested Image',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),*/
                    //TODO: Switch back to imgList once logic is working for returning images
                    CarouselSlider.builder(
                        itemCount: birdList.length,
                        carouselController: _carouselController,
                        itemBuilder: (ctx, index, rtx) {
                          print(_currentIndex);
                          print(birdList[_currentIndex].commonName);
                          return Center(
                            child:
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
                                      // Text(
                                      //   birdList[index].commonName,
                                      //   textAlign: TextAlign.center,
                                      //   style: TextStyle(
                                      //     color: Colors.white,
                                      //     fontWeight: FontWeight.bold,
                                      //     fontSize: 22,
                                      //     backgroundColor: Colors.black.withOpacity(0.5),
                                      //   ),
                                      // ),
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
                          onPageChanged: (index, reason){
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          enableInfiniteScroll: birdList.length > 1,
                          aspectRatio: 1 / 1,
                          enlargeCenterPage: true,
                          initialPage: 0,
                          //height: 200,
                          // viewportFraction: 0.5,
                          //enlargeFactor: 1.0
                        ))),
              ),
              const SizedBox(height: 15.0),
              TextButton(
                onPressed: () async {
                  final user = _auth.currentUser?.uid;
                  final Reference storageRef = FirebaseStorage.instance.ref().child("userImages");
                  final file = File(imagePath);
                  late final String birdAddURL;


                  final TaskSnapshot snapshot = await StorageService().uploadImage(storageRef, file, birdList[_currentIndex].id.toString(), user.toString(), globals.longitude.toString() , globals.latitude.toString());

                      birdAddURL = await snapshot.ref.getDownloadURL();

                generateMapMarker();
                _db.addBirdToLifeList(
                     Bird(     commonName: birdList[_currentIndex].commonName,
                               id: birdList[_currentIndex].id,
                               scientificName: birdList[_currentIndex].scientificName,
                               url: birdAddURL
                     ),
                             user.toString()
                         ).then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Bird added Successfully')),
                          );

                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const HomeScreen()),
                            );
                          });
                        });
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