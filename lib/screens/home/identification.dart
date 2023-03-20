/// identification.dart
/// @authors:   Katherine Bellman, Russell Waring
/// @version:   1
/// @since:     2023-02-20
/// The identification page is the first step in directing the user to confirm
/// what species of bird has been captured in their photo.

import 'package:flutter/material.dart';
import 'package:birdnerd/shared/globals.dart' as globals;
import 'dart:io';

class IdentificationScreen extends StatelessWidget {
  //final String imagePath;

  final String imagePath = globals.filepath;

  //const IdentificationScreen({super.key, required this.imagePath});
  IdentificationScreen({Key? key}) : super(key: key);

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
                /// Using hardcoded image for testing purposes
                child: Image.file(File(imagePath)),
              ),
            ),
            const SizedBox(height: 30.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.all(10),
                width: double.infinity,
                color: Colors.teal,
                child: Center(
                  //child: _isLoading ? CircularProgressIndicator() : Text(_scientificName),
                  child: CarouselSlider.builder(
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




              // onPressed: () {},
              // style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),foregroundColor: MaterialStateProperty.all<Color>(Colors.black)),
              // child: const Text('CONFIRM'),
            ),
          ],
        ),
      ),
    );
  }
}