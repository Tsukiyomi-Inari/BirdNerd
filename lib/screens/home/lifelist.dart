/// lifelist.dart
/// author:   Katherine Bellman, Russell Waring
/// date:     2023-03-10
/// version:  2
/// In birding, a “life list” is a list of all the birds a person has seen or
/// heard. The lifelist screen represents birds discovered by the user based in
/// the region of Durham.

import 'package:birdnerd/screens/home/widgets/lifelist_grid.dart';
import 'package:birdnerd/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:birdnerd/model/bird.dart';
import 'package:birdnerd/services/database.dart';
// Accessing data from the stream requires provider
import 'package:provider/provider.dart';
import 'bird_tile.dart';


class LifeList extends StatelessWidget {
  const LifeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bird List'),
      ),
      body: FutureBuilder<List<Bird>>(
        future: DatabaseService.getBirds(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Bird>? birds = snapshot.data;

            return ListView.builder(
              itemCount: birds!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(birds[index].commonName),
                  subtitle: Text(birds[index].scientificName),
                  leading: Image.network(birds[index].url),
                );
              },
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