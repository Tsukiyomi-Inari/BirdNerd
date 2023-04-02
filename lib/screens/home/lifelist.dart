/// lifelist.dart
/// author:   Katherine Bellman, Russell Waring
/// date:     2023-03-10
/// version:  2
/// In birding, a “life list” is a list of all the birds a person has seen or
/// heard. The lifelist screen represents birds discovered by the user based in
/// the region of Durham.
import 'package:birdnerd/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:birdnerd/model/bird_model.dart';
// Accessing data from the stream requires provider
import 'package:provider/provider.dart';
import '../../services/auth.dart';
import 'package:birdnerd/screens/home/widgets/bird_detail.dart' as BirdDetail;
import 'package:birdnerd/shared/loading.dart';

class LifeList extends StatefulWidget {
  const LifeList({Key? key}) : super(key : key);

  @override
  State<LifeList> createState() => _LifeListState();
}

class _LifeListState extends State<LifeList> {
  final AuthService _auth = AuthService();
  final _authInstance = FirebaseAuth.instance;
  late String? user = _authInstance.currentUser?.uid.toString();
  final defaultImage =
      "https://firebasestorage.googleapis.com/v0/b/bird-nerd-15f35.appspot.com/o/NotFound-Graphic.png?alt=media&token=4dc6b7c2-4dbd-4f3b-a42c-b6af08a5c10b";
// Future<List<Bird>> _getUserList() async{
//     List<Bird> finalList = [];
//     var masterSnapshot = await DatabaseService.getBirds();
//     var userSnapshot = await DatabaseService.getUserLifeList(user);
//     if(userSnapshot.isNotEmpty) {
//       try {
//               masterSnapshot.forEach((element) {
//         if (!userSnapshot.contains(element.id)) {
//         finalList.add(Bird(
//               commonName: "???",
//               id: element.id,
//               scientificName: "???",
//               url: defaultImage.toString()
//           )
//           );
//         } else {
//           finalList.add(Bird(
//             commonName: element.commonName,
//             id: element.id,
//             scientificName: element.scientificName,
//             url: element.url,
//           )
//           );
//         }
//       });
//     } on Exception catch (e) {
//       return masterSnapshot;
//     }
//     // finally{
//     //   return finalList;
//     // }
//     loading = false;
//     hasUserList = true;
//     return finalList;
//   }
//   else{
//     return masterSnapshot;
//   }
//
//   }

  /// Map icon button to navigate to user's location at time of entry photo taken
  final IconButton mapIconButton = IconButton(
    onPressed: () {
      /// Launch map page where marker is
    },
    icon: Icon(
      Icons.location_on_sharp,
      color: Colors.lightGreen.shade800,
      size: 50,
    ),
  );

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
                          onTap: () async {
                            BirdDetail.birdDetail(context, _authInstance, _auth,
                                mounted, birds[i], mapIconButton);
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
                      ))),
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
