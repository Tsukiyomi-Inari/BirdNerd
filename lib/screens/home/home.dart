import 'package:flutter/material.dart';
import 'package:birdnerd/screens/home/camera.dart';
import 'package:birdnerd/screens/home/lifelist.dart';
import 'package:birdnerd/screens/home/map.dart';
import 'package:birdnerd/screens/home/settings.dart';
import 'package:birdnerd/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  PageController pageController = PageController();
   late int _currentIndex = 0;
   final AuthService _auth =  AuthService();

    final _authInstance = FirebaseAuth.instance;



   final _bottomNavBarItems = [
     const BottomNavigationBarItem(
         icon: Icon(Icons.map, color: Colors.teal),
          label: 'Map'),
     const BottomNavigationBarItem(
         icon: Icon(Icons.camera, color: Colors.teal),
         label: 'Camera'),
     const BottomNavigationBarItem(
         icon: Icon(Icons.list, color: Colors.teal),
         label: 'Life List')
   ];

   @override
   void initState(){
     super.initState();
     pageController.addListener(() {
       setState(() {
         pageController.jumpToPage(_currentIndex) ;
         print(_currentIndex);
       });
     });
   }

   @override
   void dispose(){
     pageController.dispose();
     super.dispose();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        //leading: const Icon(Icons.person),
        centerTitle: false,
                    // Gets user e-mail if exists else anon
        title: Text(_authInstance.currentUser?.email ?? 'Anonymous' , style: const TextStyle(fontSize: 18),),
        actions: <Widget>[
          IconButton(
            onPressed: () {
                SettingsScreen();
              },
            style: TextButton.styleFrom(
                foregroundColor: Colors.white
            ),
            icon: const Icon(Icons.settings))],
      ),
      body: PageView(
        controller: pageController,
        children: const [
          Map(),
          Camera(),
          LifeList()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: _bottomNavBarItems,
        onTap: (index){
            setState(() {
              _currentIndex =  index;
              pageController.animateToPage(_currentIndex,
                            duration: const Duration(microseconds: 400),
                            curve: Curves.easeInOut);
            });
        },
      ),
    );}
}

