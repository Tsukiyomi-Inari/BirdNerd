import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:birdnerd/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const LatLng currentLocation = LatLng(43.941990, -78.894478);

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  // Future<Position> _getCurrentLocation() async{
  //
  // }


  final AuthService _auth =  AuthService();
  final _authInstance = FirebaseAuth.instance;

  /// State level variables
  late GoogleMapController _mapController;
  final Map<String, Marker> _markers = {};
  //Map<String, Marker> _markers = globals.markers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        /// Alleviates page view sensitivity when interacting with map
        gestureRecognizers: {
          Factory<PanGestureRecognizer>(() => PanGestureRecognizer())
        },
        initialCameraPosition: const CameraPosition(
          target: currentLocation,
          zoom: 14,
        ),
        onMapCreated: (controller) {
          _mapController = controller;
          addMarker('test', currentLocation);
        },
        markers: _markers.values.toSet(),
      ),
    );
  }

  addMarker(String id, LatLng location) async {

    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: const InfoWindow(
        title: 'My position',
        snippet: 'Some description of the place',
      ),
    );

    _markers[id] = marker;
    setState(() {});
  }

  /// Query database based on uid and retrieve relevant markers
  setMarkers() async {

  }
}