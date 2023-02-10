import 'package:flutter/material.dart';
import 'package:birdnerd/pages/welcome.dart';
import 'package:birdnerd/pages/settings.dart';
import 'package:birdnerd/pages/home.dart';

/*
author:   Katherine Bellman, Russell Waring
version:  1
since:    2023-02-10
 */
void main() => runApp(MaterialApp(
  initialRoute: '/welcome',
  routes: {
    '/': (context) => WelcomeScreen(),
    '/welcome': (context) => WelcomeScreen(),
    '/home': (context) => HomeScreen(),
    '/settings': (context) => SettingsScreen(),
  },
));