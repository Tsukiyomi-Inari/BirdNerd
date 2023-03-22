/// about.dart
/// @author:    Katherine Bellman, Russell Waring
/// @version:   2
/// @since:     2023-03-16
/// About page pop-up separated for modularity purposes.
/// Provides access to GitHub.

import 'package:birdnerd/screens/home/widgets/settings.dart';
import 'package:birdnerd/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


about(context, FirebaseAuth _authInstance, AuthService _auth, mounted) {
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
            height: 400,
            width: 250,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text('About',
                    style: TextStyle(
                      color: Colors.lightGreen.shade800,
                      fontFamily: "Tenko",
                      fontWeight: FontWeight.bold,
                      fontSize: 20.00
                    ),)),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                          height: 120,
                          width: 110,
                    child:  Image.network('https://firebasestorage.googleapis.com/v0/b/bird-nerd-15f35.appspot.com/o/BirdNerd_mark.png?alt=media&token=35ef1407-031b-427e-bff5-dbd2e246be95') ,
                    ),

                  const Padding(
                    padding: EdgeInsets.only(left: 10.0,right: 10.0, top: 8.0, bottom: 10.0 ),
                    child: Text(
                      '   Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ',

                        style: TextStyle(
                          fontSize: 14,
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
                    padding: const EdgeInsets.only(top: 15.0, left: 8.0, right: 8.0, bottom: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        /// Launch Settings pop up
                        Navigator.of(context).pop();
                        settings(context, _authInstance, _auth, mounted);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen.shade800,
                        fixedSize: const Size(250, 50),
                      ),
                      child: const Text(
                        "Back",
                      ),
                    ),
                  ),
               ],
              ),
            ),
        ));
      });
}
