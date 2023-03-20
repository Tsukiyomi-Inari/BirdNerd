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

settings(context, FirebaseAuth authInstance, AuthService auth, mounted) {
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(authInstance.currentUser?.email ?? 'Anonymous' , style: const TextStyle(fontSize: 18),),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text('# birds sighted'),
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        /// Launch About page
                        Navigator.of(context).pop();
                        about(context, authInstance, auth, mounted);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        // fixedSize: Size(250, 50),
                      ),
                      child: const Text(
                        "About",
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        await auth.signOut();
                        if(mounted){
                          Navigator.of(context).pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        // fixedSize: Size(250, 50),
                      ),
                      child: const Text(
                        "Sign out",
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