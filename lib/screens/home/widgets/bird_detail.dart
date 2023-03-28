/// settings.dart
/// @author:    Katherine Bellman, Russell Waring
/// @version:   2
/// @since:     2023-03-16
/// Bird detail dialog box

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:birdnerd/services/auth.dart';

import '../../../model/bird_model.dart';

settings(context, FirebaseAuth authInstance, AuthService auth, mounted, Bird birdy) {
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
            height: 420,
            width: 320,
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
                      ) )),  Center(
                      child:
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 40.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                                              SizedBox(
                          height: 63,
                          width: 58,
                    child:  Image.network(birdy.url) ,
                    ),
                    Text(
                      birdy.commonName.toString() ,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontFamily: "Oswald"
                      ),
                    ),
                  Text(
                    birdy.scientificName.toString() ,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Oswald"
                    ),
                  ),
                  Row(
                    children:[ Container(
                      // width: double.infinity,
                      // height: 60,
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 20.0),
                      child: IconButton(
                        onPressed: () {
                          /// Launch map page where marker is

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen.shade800,
                          minimumSize: const Size(134, 50),
                          elevation: 10,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        icon: Icon(Icons.location_on_sharp, color: Colors.lightGreen.shade800,),
                      ),
                    ),

                  Container(
                    //width: double.infinity,
                    // height: 60,
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () async {
                       /// download photo
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen.shade800,
                        minimumSize: const Size(134, 50),
                        elevation: 10,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      icon: Icon(Icons.download,
                        color: Colors.lightGreen.shade800,
                        size: 20,
                      ) ,
                    ),
                  ),
                ]),
                ]) )
          )],
              ),
            ),
          ),
        );
      });
}