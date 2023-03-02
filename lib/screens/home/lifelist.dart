import 'package:flutter/material.dart';
import 'package:birdnerd/screens/home/widgets/bird_square.dart';
import '../../services/auth.dart';

class LifeList extends StatefulWidget {
  const LifeList({Key? key}) : super(key: key);

  @override
  State<LifeList> createState() => _LifeListState();
  }


class _LifeListState extends State<LifeList>{

  final AuthService _auth =  AuthService();

  @override
  Widget build(BuildContext context) {
    //A method to get the birds img url will replace latter
    final List<String> tempBirdsImgURLs = [
      'https://cdn.download.ams.birds.cornell.edu/api/v1/asset/538268251',
      'https://cdn.download.ams.birds.cornell.edu/api/v1/asset/538268251',
      'https://cdn.download.ams.birds.cornell.edu/api/v1/asset/538268251',
      'https://cdn.download.ams.birds.cornell.edu/api/v1/asset/538268251',
      'https://cdn.download.ams.birds.cornell.edu/api/v1/asset/538268251',
      'https://cdn.download.ams.birds.cornell.edu/api/v1/asset/538268251',
      'https://cdn.download.ams.birds.cornell.edu/api/v1/asset/538268251',
      'https://cdn.download.ams.birds.cornell.edu/api/v1/asset/538268251',
      'https://cdn.download.ams.birds.cornell.edu/api/v1/asset/538268251',
    ];
/*    return GridView.count(
        crossAxisCount: 2,
        children: [
          for(String url in tempBirdsImgURLs.reversed)
            BirdImage(url: url)
        ]);*/

    return  GridView.builder(
      itemCount: tempBirdsImgURLs.length,
      scrollDirection: Axis.vertical,
      gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (BuildContext context, int index) {
        final birdUrl = tempBirdsImgURLs[index];
        return BirdImage(url: birdUrl);
      },

    );
  }
}







