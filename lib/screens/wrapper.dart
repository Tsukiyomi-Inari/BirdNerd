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