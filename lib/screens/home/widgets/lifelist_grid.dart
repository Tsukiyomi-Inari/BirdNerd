/// lifelist_grid.dart
/// author:   Katherine Bellman, Russell Waring
/// date:     2023-03-01
/// version:  1
/// The lifelist_grid provides a layout for the lifelist screen.

import 'package:flutter/material.dart';
import 'package:birdnerd/screens/home/widgets/bird_square.dart';
import 'package:provider/provider.dart';
import '../../../model/birds.dart';
import '../../../services/auth.dart';


class LifeListGrid extends StatelessWidget {

 final bool taken;
  final AuthService _auth =  AuthService();
  LifeListGrid(this.taken, {super.key});

  @override
  Widget build(BuildContext context) {
    final birdData = Provider.of<Birds>(context);
    final birds =  birdData.entries;
    //A method to get the birds img url will replace latter

    return  GridView.builder(
      itemCount: birds.length ,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: birds[i],
        child: const BirdImage(),
      ),
    );

  }
}







