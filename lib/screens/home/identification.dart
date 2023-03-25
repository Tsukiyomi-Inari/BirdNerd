/// identification.dart
/// @authors:   Katherine Bellman, Russell Waring
/// @version:   1
/// @since:     2023-02-20
/// The identification page is the first step in directing the user to confirm
/// what species of bird has been captured in their photo.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:birdnerd/shared/globals.dart' as globals;
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io';
import 'package:birdnerd/screens/home/home.dart';
import 'package:birdnerd/services/classifier.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/services.dart';

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

  final List<String> imgList = [
    'https://cdn.download.ams.birds.cornell.edu/api/v1/asset/481076421',
    'https://cdn.download.ams.birds.cornell.edu/api/v1/asset/341874291',
    'https://cdn.download.ams.birds.cornell.edu/api/v1/asset/475958481',
  ];

  late List<String> nameList =[
    '',
    '',
    ''
  ];

  //final List<String> birdPredictions = [];

  final CarouselController _carouselController = CarouselController();

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
    //print('Wow, it\s a ${birdPrediction['scientificName']}!');
    // print(decodedData[0].toString());
    _scientificName1 = birdPrediction1['scientificName'];
    _scientificName2 = birdPrediction2['scientificName'];
    _scientificName3 = birdPrediction3['scientificName'];
    print(_scientificName1);

    nameList[0] = _scientificName1;
    nameList[1] = _scientificName2;
    nameList[2] = _scientificName3;

    /// TODO: compare _scientificName with names in database, return common name and image



  }

  @override
  Widget build(BuildContext context) {
    //final birdClassifier = Provider.of<Classifier>(context);
    var currentIndex;
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
                        itemCount: nameList.length,
                        carouselController: _carouselController,
                        itemBuilder: (ctx, index, realIdx) {
                          currentIndex = index.toString();
                          return Center(
                              child:
                              _isLoading ? const CircularProgressIndicator() : Text (nameList[index]),
                          );
                        },
                        options: CarouselOptions(
                          aspectRatio: 1 / 1,
                          enlargeCenterPage: true,
                          //height: 200,
                          // viewportFraction: 0.5,
                          //enlargeFactor: 1.0
                        ))),
              ),
              const SizedBox(height: 15.0),
              TextButton(
                onPressed: () async {
                  // prediction.getPredictions(
                  //     'https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/Eopsaltria_australis_-_Mogo_Campground.jpg/220px-Eopsaltria_australis_-_Mogo_Campground.jpg');
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

class SquareCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    Path path = Path();
    path.lineTo(width, height);
    path.lineTo(height, width);
    path.lineTo(height, width);
    path.lineTo(height, width);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}