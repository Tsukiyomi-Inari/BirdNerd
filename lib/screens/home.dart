import 'package:flutter/material.dart';
import 'package:camera/camera.dart';


/*
author:   Katherine Bellman, Russell Waring
version:  1
since:    2022-02-10
 */
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  _HomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

}