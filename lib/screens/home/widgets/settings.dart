///*
/// @author:   Katherine Bellman, Russell Waring
/// @version:  1
/// @since:    2022-02-10

import 'package:birdnerd/screens/home/about.dart';
import 'package:birdnerd/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:birdnerd/services/auth.dart';


class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthService _auth =  AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        //backgroundColor: Colors.white,
        backgroundColor: Colors.teal,
        centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
            icon: const Icon(Icons.arrow_back),),
        title: const Text(
        'Settings',
        style: TextStyle(
        fontSize: 18,
        color: Colors.white
    ),
    ),
    /*actions: <Widget>[
    IconButton(
    icon: const Icon(
    Icons.settings,
    color: Colors.white,
    ),
    onPressed: () {
    // do something
    },
    )
    ],*/
    ),
    body: Container(
      alignment: AlignmentDirectional.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>const About()),
              );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor:  Colors.teal,
                minimumSize: const Size(60, 60),
                elevation: 10),
            child:const Text('About',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () async {
              await _auth.signOut();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor:  Colors.teal,
                minimumSize: const Size(60, 60),
                elevation: 10),
            child:const Text('Sign Out',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    ),
    );
  }
}