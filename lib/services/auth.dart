///*
/// @author:   Katherine Bellman, Russell Waring
/// @version:  1
/// @since:    2022-02-10
import 'package:firebase_auth/firebase_auth.dart';


import '../model/user_model.dart';
import 'package:birdnerd/model/birds.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //late final Birds birdData;

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

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    catch(error){
      print(error.toString());
      return null;
    }
  }


  //register with email + pass
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return _userModelFromFirebase(user);
    }
      on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (error.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
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