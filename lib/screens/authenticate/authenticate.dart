///*
/// @author:   Katherine Bellman, Russell Waring
/// @version:  1
/// @since:    2023-03-10
import 'package:birdnerd/screens/authenticate/register.dart';
import 'package:birdnerd/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn){
      return SignIn(toggleView:toggleView);
    }else{
      return Register(toggleView: toggleView);
    }
  }

}