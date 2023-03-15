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
