/// auth.dart
/// author:   Katherine Bellman, Russell Waring
/// date:     2023-02-18
/// version:  1
/// Contains the logic for signing in, registering, or signing out of the
/// application. Technique learned from this tutorial series:
/// The Net Ninja. (2019, November 20). Flutter &amp; Firebase app build.
/// YouTube. Retrieved March 10, 2023, from
/// https://www.youtube.com/playlist?list=PL4cUxeGkcC9j--TKIdkb3ISfRbJeJYQwC

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import 'package:birdnerd/model/birds.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  late final Birds birdData;

  //create userModel obj on Firebase User
  UserModel? _userModelFromFirebase(User? user){
    if (user != null){
      return UserModel(uid: user.uid);
    }else{
      return null;
    }
  }



  // auth change user stream
  Stream<UserModel?> get onAuthStateChanged{
    return _auth.authStateChanges()
        .map(_userModelFromFirebase);
  }

  // Sign in  as anon
  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userModelFromFirebase(user);
    }on FirebaseAuthException catch(error){
      switch (error.code) {
        case "operation-not-allowed":
          print(error.toString());
          break;
        default:
          print('Unknown error');
      }

    }
  }


  //sign in  with email + pass
  Future signIn(String email, String password) async {
    try{
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    }catch(error){
      print(error.toString());
      return null;
    }
  }


  //register with email + pass
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user!;
      birdData.userLifeList(user.uid.toString());
      return _userModelFromFirebase(user);
    }catch(error) {
      print(error.toString());
      return null;
    }
  }
  //sign out

  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(error){
      print(error.toString());
      return null;
    }
  }
}