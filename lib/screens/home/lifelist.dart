/// lifelist.dart
/// author: Katherine Bellman, Russell Waring
/// date: 2023-03-10
/// version: 2
/// In birding, a “life list” is a list of all the birds a person has seen or
/// heard. The lifelist screen represents birds discovered by the user based in
/// the region of Durham.

import 'package:birdnerd/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:birdnerd/model/bird_model.dart';
// Accessing data from the stream requires provider
import 'package:provider/provider.dart';
import '../../model/userbird.dart';
import '../../services/auth.dart';
import 'package:birdnerd/screens/home/widgets/bird_detail.dart' as BirdDetail;

class LifeList extends StatefulWidget {
  LifeList({super.key});

  @override
  _LifeListState createState() => _LifeListState();
}

class _LifeListState extends State<LifeList> {
  final AuthService _auth = AuthService();
  final _authInstance = FirebaseAuth.instance;

  /// Variables for toggles
  bool _showBirdList = true;
  bool _showUniqueBirds = true;

  /// Variable for loading buffer
  bool _isLoading = true;

  /// List for userBirds
  List<UserBird> userBirds = [];
  List<UserBird> uniqueUserBirds = [];

  /// Count variable for dynamically sharing info
  int totalBirds = 0;
  int uniqueDiscoveries = 0;
  int totalDiscoveries = 0;
  bool birdsCounted = false;

  /// Override initialize state method to immediately call for markers
  @override
  void initState() {
    super.initState();
    _getUserBirds();
  }

  Future<void> _getUserBirds() async {
    String? uid = _authInstance.currentUser?.uid.toString();
    userBirds = await DatabaseService.getUserList(uid!);
    for (UserBird bird in userBirds) {
      bool found = false;
      for (UserBird uniqueBird in uniqueUserBirds) {
        if (bird.id == uniqueBird.id) {
          found = true;
          break;
        }
      }
      if (!found) {
        uniqueUserBirds.add(bird);
        uniqueDiscoveries++;
      }
    }
    /// Sort userBirds by id
    userBirds.sort((a, b) => a.id.compareTo(b.id));
    totalDiscoveries = userBirds.length;
    setState(() {
      _isLoading = false;
    });
  }

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
//String? uid = _authInstance.currentUser?.uid.toString();
    return Scaffold(
        appBar: AppBar(
//toolbarOpacity: 0,
          foregroundColor: const Color(0xff58901F),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          title: Column(
//mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(_showBirdList ? 'Bird List' : 'My List',)
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: _showBirdList
                    ? const Text ('208 birds to discover')
                    : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        visualDensity: const VisualDensity(
                          horizontal: -4,
                          vertical: -4,
                        ),
                        icon: Icon(_showUniqueBirds
                            ? Icons.toggle_off
                            : Icons.toggle_on),
                        onPressed: () {
                          setState(() {
                            _showUniqueBirds = !_showUniqueBirds;
                          });
                        },
                      ),
                    ),
                    Text(_showUniqueBirds
                        ? '$uniqueDiscoveries unique species'
                        : '$totalDiscoveries birds snapped'),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(_showBirdList ? Icons.toggle_off : Icons.toggle_on),
              onPressed: () {
                setState(() {
                  _showBirdList = !_showBirdList;
                });
              },
            )
          ],
        ),
        body: _showBirdList
            ? FutureBuilder<List<Bird>>(
          future: DatabaseService.getBirds(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Bird>? birds = snapshot.data;
//totalBirds = birds!.length;
              return GridView.builder(
                itemCount: birds!.length,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(10.0),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
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
                            backgroundColor: Colors.lightGreen.shade800
                                .withOpacity(0.50),
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
                              BirdDetail.birdDetail(
                                  context,
                                  _authInstance,
                                  _auth,
                                  mounted,
                                  null,
                                  null,
                                  birds[i]);
                            },
                            child: Opacity(
                              opacity: 0.72,
                              child: Image.network(
                                birds[i].url,
                                fit: BoxFit.cover,
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
        )
            : _isLoading
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
          itemCount:
          _showUniqueBirds ? uniqueUserBirds.length : userBirds.length,
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(10.0),
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: _showUniqueBirds ? uniqueUserBirds[i] : userBirds[i],
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: GridTile(
                    footer: GridTileBar(
                      backgroundColor: Colors.lightGreen.shade800
                          .withOpacity(0.50),
                      title: Text(
                        _showUniqueBirds ? uniqueUserBirds[i].commonName : userBirds[i].commonName,
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
                        _showUniqueBirds
                            ? BirdDetail.birdDetail(
                            context,
                            _authInstance,
                            _auth,
                            mounted,
                            mapIconButton,
                            uniqueUserBirds[i])
                            : BirdDetail.birdDetail(
                            context,
                            _authInstance,
                            _auth,
                            mounted,
                            mapIconButton,
                            userBirds[i]);
                      },
                      child: Opacity(
                        opacity: 0.72,
                        child: Image.network(
                          _showUniqueBirds
                              ? uniqueUserBirds[i].url
                              : userBirds[i].url,
                          fit: BoxFit.cover,
//colorBlendMode: birdData.isTaken ? null : const BlendMode.color(Colors.grey, BlendMode.color),
                        ),
                      ),
                    ),
                  ))),
        ));
  }
}