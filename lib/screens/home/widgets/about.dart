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
          content: Container(
            height: 400,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: Text('About')),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text('Note'),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt'
                          ' ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud'
                          ' exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
                          ' Duis aute irure dolor in reprehenderit in voluptate velit esse cillum '
                          'dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,'
                          ' sunt in culpa qui officia deserunt mollit anim id est laborum.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        /// Launch Settings pop up
                        Navigator.of(context).pop();
                        settings(context, _authInstance, _auth, mounted);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        // fixedSize: Size(250, 50),
                      ),
                      child: const Text(
                        "Back",
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