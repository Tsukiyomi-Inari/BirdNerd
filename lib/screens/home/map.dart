import 'package:birdnerd/screens/home/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);


  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  late GoogleMapController _mapController;
  //late Set<Marker> _mapMarkers = {};

  final Location _location = Location();
  late LatLng _currentLocation ;


  late  PermissionStatus _permissionGranted = PermissionStatus.grantedLimited ;

  @override
  void initState(){
    super.initState();
    _requestLocationPermission();
  }

  void _requestLocationPermission() async {
    _permissionGranted = await _location.requestPermission();
    if (_permissionGranted == PermissionStatus.granted){
      _getCurrentLocation();
      //_getMarkersFromFireStore();
    }else{
      print('Location permission not granted');
    }
  }

  void _getCurrentLocation() async {
    try{
    LocationData  locationData = await  _location.getLocation();
     _currentLocation = LatLng( double.parse(locationData.latitude.toString()) , double.parse(locationData.longitude.toString()));
    }catch(error){
      print('Error: $error');
    }
  }


/*  void _getMarkersFromFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firestore.collection('markers').get();
    setState(() {
      _mapMarkers = _createMarkers(snapshot.docs)!;
    });
  }

  Set<Marker>? _createMarkers(List<DocumentSnapshot> documents) {
    return documents.map( (doc) {
      GeoPoint geoPoint = doc.data()['location'];
      LatLng latLng = LatLng(geoPoint.latitude, geoPoint.longitude);
      String title = doc.data()['title'];
      String snippet = doc.data()['snippet'];
      return Marker(
          markerId: MarkerId(doc.id),
          position: latLng,
        infoWindow: InfoWindow(title: title, snippet: snippet),
        icon: BitmapDescriptor.defaultMarker,
      );
    }).toSet();
  }*/

  void _onMapCreated(GoogleMapController mapController){
    _mapController = mapController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PermissionStatus.granted != _permissionGranted!
          ?const Center(child: Text('Location permission not granted'))
          : _currentLocation == null
          ? const Center(child: Loading())
          : GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _currentLocation,
            zoom: 11.0,
          ),
        //markers: _mapMarkers,
      ),
    );
  }
}
