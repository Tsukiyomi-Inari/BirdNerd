/// settings.dart
/// @author:    Katherine Bellman, Russell Waring
/// @version:   2
/// @since:     2023-03-16
/// Settings page pop-up separated for modularity purposes.
/// Provides access to About page and logout option.

import 'package:birdnerd/screens/home/widgets/about.dart';
import 'package:birdnerd/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:birdnerd/services/auth.dart';
import 'package:birdnerd/shared/globals.dart' as globals;

settings(context, FirebaseAuth authInstance, AuthService auth, mounted) {
  bool _loadedBirds = false;

  if (globals.totalBirds > 0) {
    _loadedBirds = true;
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
                      child: Text(
                    'Settings',
                    style: TextStyle(
                        color: Colors.lightGreen.shade800,
                        fontFamily: "Teko",
                        fontWeight: FontWeight.w600,
                        fontSize: 30.00),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, bottom: 8.0, right: 8.0, left: 8.0),
                    child: Text(
                      authInstance.currentUser?.email ?? 'Anonymous',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Teko",
                          fontWeight: FontWeight.w700,
                          color: Colors.lightGreen.shade800),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 8.0, bottom: 40.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _loadedBirds ? '# of Birds in Life List:   ' : '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Teko",
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.lightGreen.shade800,
                              ),
                            ),
                            Text(
                              _loadedBirds ? globals.totalBirds.toString() : '',
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: "Oswald"),
                            ),
                          ])),
                  Container(
                    // width: double.infinity,
                    // height: 60,
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, top: 8.0, bottom: 20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        /// Launch About page
                        Navigator.of(context).pop();
                        about(context, authInstance, auth, mounted);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen.shade800,
                        minimumSize: const Size(134, 50),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text(
                        "About",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Teko",
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  Container(
                    //width: double.infinity,
                    // height: 60,
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        globals.totalBirds = 0;
                        await auth.signOut();
                        if (mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen.shade800,
                        minimumSize: const Size(134, 50),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text(
                        "Sign out",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Teko",
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
