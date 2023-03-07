import 'package:flutter/material.dart';
import 'package:birdnerd/screens/camera.dart';
import 'package:birdnerd/screens/lifelist.dart';
import 'package:birdnerd/screens/map.dart';


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
  int _currentIndex = 0;

  final PageController _pageController = PageController(initialPage: 1);

  final _bottomNavigationBarItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.flutter_dash, color: Colors.blue),
        label: 'List'
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.camera_alt_outlined, color: Colors.green),
        label: 'Camera')
    ,
    const BottomNavigationBarItem(
        icon: Icon(Icons.place, color: Colors.pink),
        label: 'Map'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
// #region AppBar()
      appBar: AppBar(
        //backgroundColor: Colors.white,
        backgroundColor: Color(0x44000000),
        centerTitle: true,
        title: const Text(
          'BirdNerd',
          style: TextStyle(
              fontSize: 18,
              color: Colors.black54
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
// #endregion
      body: PageView(
        controller: _pageController,
        onPageChanged: (newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        children: [
          LifeListScreen(),
          const CameraScreen(),
          MapScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _bottomNavigationBarItems,
        onTap: (index) {
          _pageController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.ease);
        },
        //type: BottomNavigationBarType.fixed,
      ),
    );
  }
}