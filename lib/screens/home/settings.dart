import 'package:birdnerd/screens/home/about.dart';
import 'package:birdnerd/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:birdnerd/services/auth.dart';


/*
author:   Katherine Bellman, Russell Waring
version:  1
since:    2022-02-10
 */
class SettingsScreen extends StatefulWidget {

  @override
  State<SettingsScreen> createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: ()async {
              _auth.signOut();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor:  Colors.teal,
                minimumSize: const Size(60, 60),
                elevation: 10),
            child:const Text('Sign Out',
              style: TextStyle(fontSize: 20),
            ),
          ),
          ElevatedButton(
            onPressed: ()async {
              const About();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor:  Colors.teal,
                minimumSize: const Size(60, 60),
                elevation: 10),
            child:const Text('About',
              style: TextStyle(fontSize: 20),
            ),
          ),
          ElevatedButton(
            onPressed: ()async {
              const HomeScreen();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor:  Colors.teal,
                minimumSize: const Size(60, 60),
                elevation: 10),
            child:const Text('Return',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}


