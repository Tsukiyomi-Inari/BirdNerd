import 'package:flutter/material.dart';
import 'package:birdnerd/screens/home/camera.dart';
import 'package:birdnerd/screens/home/lifelist.dart';
import 'package:birdnerd/screens/home/map.dart';
import 'package:birdnerd/screens/home/widgets/settings.dart';
import 'package:birdnerd/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:birdnerd/model/birds.dart';
import 'package:provider/provider.dart';

import 'lifelist.dart';

/*
author:   Katherine Bellman, Russell Waring
version:  1
since:    2023-02-10
 */
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState(){
    super.initState();
  }

  var _isInit = true;
  @override
  void didChangeDependencies(){
    if(_isInit){
      Provider.of<Birds>(context).lifeList;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 1);

  final AuthService _auth =  AuthService();
  final _authInstance = FirebaseAuth.instance;

  final _bottomNavigationBarItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.list, color: Colors.teal),
        label: 'List'
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.camera_alt_outlined, color: Colors.teal),
        label: 'Camera')
    ,
    const BottomNavigationBarItem(
        icon: Icon(Icons.map, color: Colors.teal),
        label: 'Map'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: false,
        title: Text(_authInstance.currentUser?.email ?? 'Anonymous' , style: const TextStyle(fontSize: 18),),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Settings()),
                );
              },
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white
              ),
              icon: const Icon(Icons.settings))
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        children: const [
          LifeList(),
          CameraScreen(),
          Map(),
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

