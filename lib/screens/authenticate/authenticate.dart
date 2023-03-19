/// authenticate.dart
/// author:   Katherine Bellman, Russell Waring
/// date:     2023-02-10
/// version:  1
/// The authenticate widget handles which view is presented to the user between
/// sign-in and register. This strategy was adopted from the following resource:
/// The Net Ninja. (2019, November 20). Flutter &amp; Firebase app build.
/// YouTube. Retrieved March 10, 2023, from
/// https://www.youtube.com/playlist?list=PL4cUxeGkcC9j--TKIdkb3ISfRbJeJYQwC

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