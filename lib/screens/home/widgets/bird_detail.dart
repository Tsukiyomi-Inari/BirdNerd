/// bird_detail.dart
/// @author: Katherine Bellman, Russell Waring
/// @version: 2
/// @since: 2023-03-16
/// Bird detail dialog box


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:birdnerd/services/auth.dart';
import 'package:path/path.dart';
import '../../../model/bird_model.dart';
import '../../../model/userbird.dart';

birdDetail( context, FirebaseAuth authInstance, AuthService auth, mounted, IconButton? buttonCode, [UserBird? birdy , Bird? birdy2 ]) {
  bool condition;
  if(birdy == null){
    condition = false;
  } else {
    condition = true;
  }
  bool condition2 = true;
  if(buttonCode == null){
    condition2 = false;
  } else{
    condition2 = true;
  }
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
                      }, icon: Icon(
                        Icons.close,
                        color: Colors.lightGreen.shade800 ,
                        size: 30.00,
                      ) )), Center(
                      child:
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  clipBehavior: Clip.antiAlias,
                                  child: SizedBox(
                                    height: 200,
                                    width: 200,
                                    child: FittedBox(
                                      child: Image.network( condition ? birdy!.url : birdy2!.url ,
// scale: 0.5,
                                      ) ,
                                    ),
                                  ),
                                ),

                                Text(
                                  condition ? birdy!.commonName.toString() : birdy2!.commonName.toString(),
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.lightGreen.shade800,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: "Oswald"
                                  ),
                                ),
                                Text(
                                  condition ? birdy!.scientificName.toString() : birdy2!.scientificName.toString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Oswald"
                                  ),
                                ),
                                Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children:[ Container(
// width: double.infinity,
// height: 60,
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child:// IconButton(
// onPressed: () {
// /// Launch map page where marker is
//
// },
// icon: Icon(Icons.location_on_sharp,
// color: Colors.lightGreen.shade800,
// size: 50,),
// ),
                                        condition2 ? buttonCode : const Text('')
                                    ),
// Container(
// //width: double.infinity,
// // height: 60,
// padding: const EdgeInsets.all(8.0),
// child: condition? IconButton(
// onPressed: () async {
// StorageService().downloadBirdImage(birdy!);
// /// download photo
//
// },
// icon: Icon(Icons.download,
// color: Colors.lightGreen.shade800,
// size: 50,
// ) ,
// ) :
// IconButton(
// onPressed: () {},
// disabledColor: Colors.white12,
// icon: const Icon(Icons.download,
// size: 50,
// ) ,
// )
// ,
// ),
                                    ]),
                              ]) )
                  )],
              ),
            ),
          ),
        );
      });
}