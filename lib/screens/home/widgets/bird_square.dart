/// bird_square.dart
/// author:   Katherine Bellman, Russell Waring
/// date:     2023-03-01
/// version:  1
/// This is an object to represent a bird that will occur repeatably in the
/// lifelist_grid, presented in the lifelist screen.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../model/bird_model.dart';


class BirdSquare extends StatelessWidget {

  const BirdSquare({super.key});


  // loading ? const Loading() :
  @override
  Widget build(BuildContext context) {

    final birdData = Provider.of<Bird>(context, listen: false);
    return ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child:  GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.lightGreen.shade800.withOpacity(0.50),
            title: Text(
              birdData.birdCommon,
              textAlign: TextAlign.center,
              style:  const TextStyle(
                  fontFamily: 'Tenko',
                  color: Colors.white ,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ),
          child: GestureDetector(
            onTap: () {
/*           Navigator.of(context).pushNamed(
            ProductDetailScreen.routeName,
            arguments: product.id,
          );*/
            },
            child:
            Opacity(
              opacity: 0.72,
              child: Image.network(
                birdData.imageUrl,
                fit: BoxFit.cover,
                //colorBlendMode:  birdData.isTaken ? null : const BlendMode.color(Colors.grey, BlendMode.color),
              ),
            )
            ,
          ),

        ));
  }
}
