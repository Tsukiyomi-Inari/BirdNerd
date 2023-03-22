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
          content: SizedBox(
            height: 400,
            width: 250,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 8.0,bottom: 8.0, top: 1.0, right: 1.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    alignment: Alignment.topRight,
                  child: IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon:  Icon(
                      Icons.close,
                    color: Colors.lightGreen.shade800 ,
                    size: 30.00,
                    opticalSize: 20.00,
                  ) )),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 8.0, right: 8.0, left: 8.0),
                    child: Text(authInstance.currentUser?.email ?? 'Anonymous' ,
                      style: TextStyle(fontSize: 18,
                          fontFamily: "Tenko",
                          fontWeight: FontWeight.w800,
                          fontStyle: FontStyle.normal ,
                          color: Colors.lightGreen.shade800
                      ) ,
                      textAlign: TextAlign.center,),
                  ),

                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 60.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[Text('# birds sighted:  ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Tenko",
                          fontWeight: FontWeight.bold,
                          color: Colors.lightGreen.shade800,
                      ) ,
                    ),

                  const Text(
                    " 0 ",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontFamily: "Oswald"
                    ),
                  ),]) ),
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
                        backgroundColor: Colors.lightGreen.shade800,
                        //fixedSize: const Size(200, 50),
                      ),
                      child: const Text(
                        "About",
                        style: TextStyle(
                            fontFamily: "Tenko",
                            fontWeight: FontWeight.bold
                        ) ,
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
                        backgroundColor: Colors.lightGreen.shade800,
                        // fixedSize: Size(250, 50),
                      ),
                      child: const Text(
                        "Sign out",
                        style: TextStyle(
                          fontFamily: "Tenko",
                          fontWeight: FontWeight.bold
                        ) ,
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