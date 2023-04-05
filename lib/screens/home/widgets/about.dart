/// about.dart
/// @author:    Katherine Bellman, Russell Waring
/// @version:   2
/// @since:     2023-03-16
/// About page pop-up separated for modularity purposes.
/// Provides access to GitHub.

import 'package:birdnerd/screens/home/widgets/settings.dart';
import 'package:birdnerd/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


_launchURL() async {
  var urlGithub =  Uri.parse("http://github.com/Tsukiyomi-Inari/BirdNerd");
  if (await canLaunchUrl(urlGithub)) {
    await launchUrl(urlGithub,
                    mode: LaunchMode.externalApplication
                    );
  } else {
    throw 'Could not launch $urlGithub';
  }
}


about(context, FirebaseAuth _authInstance, AuthService _auth, mounted) {
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
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                      alignment: Alignment.topRight,
                      child:  IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon:  Icon(
                        Icons.close,
                        color: Colors.lightGreen.shade800 ,
                        size: 40.00,
                      ) ),),
                Center(
                        child: Text('About',
                    style: TextStyle(
                      color: Colors.lightGreen.shade800,
                      fontFamily: "Teko",
                      fontWeight: FontWeight.w600,
                      fontSize: 30.00
                    ),)),
                  SizedBox(
                          height: 63,
                          width: 58,
                    child:  Image.network('https://firebasestorage.googleapis.com/v0/b/bird-nerd-15f35.appspot.com/o/BirdNerd_mark.png?alt=media&token=35ef1407-031b-427e-bff5-dbd2e246be95') ,
                    ),

                   Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10.0, top: 5.0, bottom: 2.0 ),
                    child:

                    Column(
                      children: [
                         Text(
                            'Bird Nerd',
                          style: TextStyle(
                              fontSize: 28,
                              fontFamily: "Teko",
                              color: Colors.lightGreen.shade800,
                              fontWeight: FontWeight.w700,

                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Developed By \nRussell Warring & Katherine Bellman',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Teko",
                              fontWeight: FontWeight.w500,
                            color: Colors.lightGreen.shade800
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                        '  Data list and Identification bird images are referenced from community generated data on Ebird. This app is for educational purposes only.  ',

                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Oswald",
                            fontStyle: FontStyle.normal,
                            textBaseline: TextBaseline.alphabetic
                          ),
                          softWrap: true,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.visible,
                      ),
                    ]),
                  ),
                  ElevatedButton(
                    onPressed: _launchURL,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen.shade800,
                      minimumSize: const Size(134, 50),
                      elevation: 10,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text(
                      "Github",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Teko",
                        fontWeight: FontWeight.w800,

                      ) ,
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: IconButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                          settings(context, _authInstance, _auth, mounted);
                        },
                        icon:  Icon(
                          Icons.arrow_back,
                          color: Colors.lightGreen.shade800 ,
                          size: 50.00,
                        )),
                  )
               ],
              ),
            ),
        ));
      });
}
