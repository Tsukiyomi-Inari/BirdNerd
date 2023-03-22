/// lifelist.dart
/// author:   Katherine Bellman, Russell Waring
/// date:     2023-03-10
/// version:  2
/// In birding, a “life list” is a list of all the birds a person has seen or
/// heard. The lifelist screen represents birds discovered by the user based in
/// the region of Durham.

import 'package:birdnerd/screens/home/widgets/lifelist_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LifeList extends StatefulWidget {
  const LifeList({Key? key}) : super(key: key);

  @override
  State<LifeList> createState() => _LifeListState();
}

class _LifeListState extends State<LifeList> {

  final _taken = false;
  @override
  Widget build(BuildContext context) {
    FontLoader("Tenko");
    return Container(
      decoration:  const BoxDecoration(
        image: DecorationImage(
            image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/bird-nerd-15f35.appspot.com/o/Splash%20background%20color.png?alt=media&token=d56e2f5a-2d56-47fc-9a28-0de2108eb82d"),
            fit: BoxFit.cover,
        )
      ),
      alignment: AlignmentDirectional.center,
      child: LifeListGrid(_taken),
    );
  }
}
