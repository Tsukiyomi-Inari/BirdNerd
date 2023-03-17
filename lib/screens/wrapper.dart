/// wrapper.dart
/// author:   Katherine Bellman, Russell Waring
/// date:     2023-02-18
/// version:  1
/// The wrapper monitors for whether a user is logged in or not, and returns
/// a screen accordingly (sign-in vs content). Adopted from the series:
/// The Net Ninja. (2019, November 20). Flutter &amp; Firebase app build.
/// YouTube. Retrieved March 10, 2023, from
/// https://www.youtube.com/playlist?list=PL4cUxeGkcC9j--TKIdkb3ISfRbJeJYQwC

import 'package:birdnerd/screens/home/widgets/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:birdnerd/screens/home/home.dart';
import '../model/user_model.dart';
import 'authenticate/authenticate.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({super.key});



  @override
  Widget build(BuildContext context) {

    final userModel = Provider.of<UserModel?>(context);

    if(userModel == null){
      return  const Authenticate();
    }else{
      return  const HomeScreen();
    }
    //return either home or Authenticate widget

  }
}