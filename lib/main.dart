import 'package:flutter/material.dart';
import 'package:birdnerd/screens/settings.dart';
import 'package:birdnerd/screens/home.dart';
import 'package:birdnerd/screens/identification.dart';

/*
author:   Katherine Bellman, Russell Waring
version:  1
since:    2023-02-10
 */
void main() => runApp(MaterialApp(
  initialRoute: '/home',
  routes: {
    '/home': (context) => HomeScreen(),
    '/identification': (context) => IdentificationScreen(),
    //'/welcome': (context) => WelcomeScreen(),
    //'/home': (context) => HomeScreen(),
    '/settings': (context) => SettingsScreen(),
  },
));