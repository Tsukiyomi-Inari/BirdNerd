/// lifelist.dart
/// author:   Katherine Bellman, Russell Waring
/// date:     2023-02-16
/// version:  1
/// In birding, a “life list” is a list of all the birds a person has seen or
/// heard. The lifelist screen represents birds discovered by the user based in
/// the region of Durham.

import 'package:birdnerd/screens/home/widgets/lifelist_grid.dart';
import 'package:flutter/material.dart';

class LifeList extends StatefulWidget {
  const LifeList({Key? key}) : super(key: key);

  @override
  State<LifeList> createState() => _LifeListState();
}

class _LifeListState extends State<LifeList> {

  final _taken = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      child: LifeListGrid(_taken),
    );
  }
}
