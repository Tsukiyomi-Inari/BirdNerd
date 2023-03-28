/// lifelist.dart
/// author:   Katherine Bellman, Russell Waring
/// date:     2023-03-10
/// version:  2
/// In birding, a “life list” is a list of all the birds a person has seen or
/// heard. The lifelist screen represents birds discovered by the user based in
/// the region of Durham.

import 'package:birdnerd/services/database.dart';
import 'package:flutter/material.dart';
import 'package:birdnerd/model/bird_model.dart';
// Accessing data from the stream requires provider
import 'package:provider/provider.dart';
import '../../services/auth.dart';

class LifeList extends StatelessWidget {
  LifeList({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Bird>>(
        future: DatabaseService.getBirds(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Bird>? birds = snapshot.data;

            return GridView.builder(
              itemCount: birds!.length,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(10.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                  value: birds[i],
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: GridTile(
                        footer: GridTileBar(
                          backgroundColor:
                          Colors.lightGreen.shade800.withOpacity(0.50),
                          title: Text(
                            birds[i].commonName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontFamily: 'Tenko',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {

/*           Navigator.of(context).pushNamed(
            ProductDetailScreen.routeName,
            arguments: product.id,
          );*/
                          },
                          child: Opacity(
                            opacity: 0.72,
                            child: Image.network(
                              birds[i].url,
                              fit: BoxFit.cover,
                              //colorBlendMode:  birdData.isTaken ? null : const BlendMode.color(Colors.grey, BlendMode.color),
                            ),
                          ),
                        ),
                      ))
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error retrieving data'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
