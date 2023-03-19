/// identification.dart
/// @authors:   Katherine Bellman, Russell Waring
/// @version:   1
/// @since:     2023-02-20
/// The identification page is the first step in directing the user to confirm
/// what species of bird has been captured in their photo.

import 'package:flutter/material.dart';
import 'package:birdnerd/shared/globals.dart' as globals;
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io';
import 'package:birdnerd/screens/home/home.dart';
import 'package:birdnerd/services/classifier.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';


class IdentificationScreen extends StatefulWidget {

  const IdentificationScreen({super.key})
  ;
  @override
  _IdentificationScreenState createState() => _IdentificationScreenState();
}
 class _IdentificationScreenState extends State<IdentificationScreen>{
  //final String imagePath;

  final String imagePath = globals.filepath;


  final List<String> imgList = [
    'https://cdn.download.ams.birds.cornell.edu/api/v1/asset/481076421',
    'https://cdn.download.ams.birds.cornell.edu/api/v1/asset/341874291',
    'https://cdn.download.ams.birds.cornell.edu/api/v1/asset/475958481',
    'https://cdn.download.ams.birds.cornell.edu/api/v1/asset/393271701'
  ];
  final List<String> birdPredictions = [];

  final CarouselController _carouselController = CarouselController();




  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    //final birdClassifier = Provider.of<Classifier>(context);
    Classifier prediction = Classifier();
    var currentIndex;
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: const Text(
          'Confirm if there is a match',
          style: TextStyle(
              fontSize: 18,
              color: Colors.white
          ),
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
                content: const Text( "Teset" ),
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
                //child: Image.file(File(imagePath)),
                child: Image.network(
                    'https://cdn.download.ams.birds.cornell.edu/api/v1/asset/481076421'),
              ),
            ),
            const SizedBox(height: 30.0),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.all(15.0),
                  margin: const EdgeInsets.all(10),
                  width: double.infinity,
                  color: Colors.teal,
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
                  CarouselSlider.builder(
                      itemCount: imgList.length,
                      carouselController: _carouselController,
                      itemBuilder: (ctx, index, realIdx) {
                        currentIndex = index.toString();
                        return Center(
                            child: Image.network(imgList[index],
                                fit: BoxFit.cover,
                                width: 1000));
                      }, options: CarouselOptions(
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                  ))
              ),
            ),
            TextButton(
              onPressed: () async {
                prediction.getPredictions(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/Eopsaltria_australis_-_Mogo_Campground.jpg/220px-Eopsaltria_australis_-_Mogo_Campground.jpg');
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.teal),
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white),

              ),
              child: const Text('CONFIRM'),
            ),
          ],
        ),
      ),
    );
  }

}