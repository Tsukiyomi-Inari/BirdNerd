/// bird_square.dart
/// author:   Katherine Bellman, Russell Waring
/// date:     2023-03-01
/// version:  1
/// This is an object to represent a bird that will occur repeatably in the
/// lifelist_grid, presented in the lifelist screen.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/bird_model.dart';

class BirdImage extends StatelessWidget {
  const BirdImage({super.key});

  @override
  Widget build(BuildContext context) {
    final birdData = Provider.of<Bird>(context, listen: false);
    return ClipRect(
      child: GridTile(
        footer: GridTileBar(
      backgroundColor: Colors.tealAccent.withOpacity(0.45),
    title: Text(
      birdData.birdCommon,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 16
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
    Image.network(
      birdData.imageUrl,
      fit: BoxFit.cover,


    ),
    ),
    ),
    );
  }
}
