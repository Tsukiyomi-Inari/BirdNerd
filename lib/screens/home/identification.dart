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
import 'package:flutter/rendering.dart';
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
        backgroundColor: Colors.lightGreen.shade800,
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
      body: Container(
        decoration:  const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/bird-nerd-15f35.appspot.com/o/Splash%20background%20color.png?alt=media&token=d56e2f5a-2d56-47fc-9a28-0de2108eb82d"),
              fit: BoxFit.cover,
            )
        ),
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
                  margin: const EdgeInsets.only(top:10),
                  //height: double.infinity,
                  color: const Color.fromRGBO(161, 214, 107, 50.00),
                  padding: const EdgeInsets.all(15.0),
                  //child: Image.file(File(imagePath)),
                  child: ClipRect(
                    child: Image.network(
                        'https://cdn.download.ams.birds.cornell.edu/api/v1/asset/481076421',
                    scale: 2.0,
                    ),
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
                    CarouselSlider.builder(
                        itemCount: imgList.length,
                        carouselController: _carouselController,
                        itemBuilder: (ctx, index, realIdx) {
                          currentIndex = index.toString();
                          return Center(
                              child: Image.network(imgList[index],
                                  //scale: 2.0,
                              ));
                        }, options: CarouselOptions(
                      aspectRatio: 1/1,
                      enlargeCenterPage: true,
                      height: 200,
                      viewportFraction: 0.5
                    ))
                ),
              ),
              const SizedBox(height: 15.0),
              TextButton(
                onPressed: () async {
                  prediction.getPredictions(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/Eopsaltria_australis_-_Mogo_Campground.jpg/220px-Eopsaltria_australis_-_Mogo_Campground.jpg');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen.shade800,
                  minimumSize: const Size(130, 50),
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text('CONFIRM',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Teko",
                    fontWeight: FontWeight.w800,
                    color: Colors.white

                  ) ,
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
class SquareCustomClipper extends CustomClipper<Path>{

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

