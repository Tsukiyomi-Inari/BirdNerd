import 'package:flutter/material.dart';
import 'package:birdnerd/globals.dart' as globals;
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
        backgroundColor: Color(0x44000000),
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
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
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
                color: Colors.cyan,
                padding: const EdgeInsets.all(15.0),
                child: Image.file(File(imagePath)),
              ),
            ),
            const SizedBox(height:30.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.all(10),
                width: double.infinity,
                color: Colors.cyan,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'AI Suggested Image',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blueAccent,
                    ),
                  ),
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