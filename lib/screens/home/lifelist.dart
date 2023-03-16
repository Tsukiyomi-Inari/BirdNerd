///*
/// @author:   Katherine Bellman, Russell Waring
/// @version:  1
/// @since:    2023-03-10
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
