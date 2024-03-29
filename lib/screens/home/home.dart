/// home.dart
/// @authors:   Katherine Bellman, Russell Waring
/// @version:   1
/// @since:     2023-02-10
/// The home screen widget wraps around the core structure of the application,
/// encapsulating the camera, LifeList, and map pages. Allows a consistent
/// AppBar and navigation bar throughout the user experience.


import 'package:birdnerd/services/database.dart';
import 'package:flutter/material.dart';
import 'package:birdnerd/screens/home/camera.dart';
import 'package:birdnerd/screens/home/lifelist.dart';
import 'package:birdnerd/screens/home/map.dart';
import 'package:birdnerd/screens/home/widgets/settings.dart' as Settings;
import 'package:birdnerd/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:birdnerd/shared/globals.dart' as globals;

import '../../model/bird_model.dart';
import '../../model/userbird.dart';
import '../../shared/loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 1);

  final AuthService _auth =  AuthService();
  final _authInstance = FirebaseAuth.instance;
  late String?  user =  _authInstance.currentUser?.uid;



  final _bottomNavigationBarItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.map, color: Colors.lightGreen.shade800 , size: 40.00,),
        label: 'Map'
    ),
     BottomNavigationBarItem(
        icon: Icon(Icons.camera_alt_outlined, color: Colors.lightGreen.shade800, size: 40.00),
        label: 'Camera')
    ,
    BottomNavigationBarItem(
    icon: Icon(Icons.list, color: Colors.lightGreen.shade800, size: 40.00),
    label: 'List'
    ),
  ];

  @override
  void initState(){
    super.initState();
  }

  bool _isLoading = true;

  Future<void> numberOfBirds() async {
    String? uid = _authInstance.currentUser?.uid.toString();
    List<UserBird> userBirds = await DatabaseService.getUserList(uid!);

    globals.totalBirds = userBirds.length;
    setState(() {
      _isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    /// Count total number of birds
    numberOfBirds();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen.shade800,
        centerTitle: false,
        /// Checks for user to display id in app bar
        title: Text(_authInstance.currentUser?.email ?? 'Anonymous' , style: const TextStyle(fontSize: 19, fontFamily: "Oswald",fontWeight: FontWeight.w500 ),),
        // actions: [
        //   TextButton.icon(
        //     icon: const Icon(Icons.person),
        //     label: const Text('Logout'),
        //     onPressed: () async {
        //       await _auth.signOut();
        //     },
        //   )
        // ],
        actions: <Widget>[
          IconButton(
              onPressed: () {
                setState(() {
                  Settings.settings(context, _authInstance, _auth, mounted);
                });
              },
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white
              ),
              icon: const Icon(Icons.settings))
        ],
      ),
      body: PageView(
        controller: _pageController,
        //physics: const FixedExtentScrollPhysics(),
        onPageChanged: (newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        children:  [
          const MapScreen(),
          const CameraScreen(),
          LifeList(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _bottomNavigationBarItems,
        onTap: (index) {
          _pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.ease);
        },
        //type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

