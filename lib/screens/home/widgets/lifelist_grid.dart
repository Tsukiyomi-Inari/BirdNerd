// /// lifelist_grid.dart
// /// author:   Katherine Bellman, Russell Waring
// /// date:     2023-03-10
// /// version:  2
// /// The lifelist_grid provides a layout for the lifelist screen.
//
// import 'package:flutter/material.dart';
// import 'package:birdnerd/screens/home/widgets/bird_square.dart';
// import 'package:provider/provider.dart';
// import '../../../model/bird_model.dart';
// import '../../../services/auth.dart';
//
//
// class LifeListGrid extends StatelessWidget {
//
//  final bool taken;
//   final AuthService _auth =  AuthService();
//   LifeListGrid(this.taken, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final birdData = Provider.of<Birds>(context);
//     final birds =  birdData.entries;
//     //A method to get the birds img url will replace latter
//
//     return  GridView.builder(
//       itemCount: birds.length ,
//       scrollDirection: Axis.vertical,
//       padding: const EdgeInsets.all(10.0),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 1 / 1,
//         crossAxisSpacing: 8,
//         mainAxisSpacing: 8,
//       ),
//       itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
//         value: birds[i],
//         child: const BirdSquare(),
//       ),
//     );
//
//   }
// }







