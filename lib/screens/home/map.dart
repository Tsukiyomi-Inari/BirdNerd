/// map.dart
/// author:   Katherine Bellman, Russell Waring
/// date:     2023-03-15
/// version:  3
/// The map screen. Will display meaningful map markers based on discovered
/// birds.

import 'package:birdnerd/services/database.dart';
import 'package:birdnerd/shared/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:birdnerd/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:birdnerd/model/marker.dart';
import 'package:image/image.dart' as IMG;
import 'package:flutter/services.dart';
import 'package:custom_info_window/custom_info_window.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  final AuthService _auth = AuthService();
  final _authInstance = FirebaseAuth.instance;

  /// State level variables
  late GoogleMapController _mapController;
  final Map<String, Marker> _markers = {};

  // Used for loading state before result is identified
  late bool _isLoading = true;

  /// Override initialize state method to immediately call for markers
  @override
  void initState() {
    super.initState();
    _getUserMarkers();
  }

  Future<void> _getUserMarkers() async {
    String? uid = _authInstance.currentUser?.uid.toString();
    print('**********\n** TEST **\n**********');
    print(uid);
    print('**********\n** TEST **\n**********');
    List<MyMarker> myMarkers = await DatabaseService.getUserMarkers(uid!);

    /// Convert image to being useable?
    for (int i = 0; i < myMarkers.length; i++) {
      LatLng location = LatLng(myMarkers[i].latitude, myMarkers[i].longitude);
      var bytes = (await NetworkAssetBundle(Uri.parse(myMarkers[i].imgUrl))
              .load(myMarkers[i].imgUrl))
          .buffer
          .asUint8List();
      IMG.Image? img = IMG.decodeImage(bytes);
      IMG.Image resized = IMG.copyResize(img!, width: 150, height: 150);
      Uint8List resizedImg = Uint8List.fromList(IMG.encodePng(resized));
      String id = i.toString();
      var marker = Marker(
        markerId: MarkerId(id),
        position: location,
        infoWindow: InfoWindow(
          title: myMarkers[i].commonName,
          snippet: myMarkers[i].date,
        ),
        icon: BitmapDescriptor.fromBytes(resizedImg),
      );
      _markers[id] = marker;
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<LocationData>(
          future: Location().getLocation(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final currentLocation =
                  LatLng(snapshot.data!.latitude!, snapshot.data!.longitude!);
              return _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : GoogleMap(
                    /// Alleviates page view sensitivity when interacting with map
                    gestureRecognizers: {
                      Factory<PanGestureRecognizer>(
                          () => PanGestureRecognizer())
                    },
                    initialCameraPosition: CameraPosition(
                      target: currentLocation,
                      zoom: 13,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      setState(() {
                        _mapController = controller;
                      });
                    },
                    markers: _markers.values.toSet(),
                  );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
