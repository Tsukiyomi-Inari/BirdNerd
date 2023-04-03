/// globals.dart
/// author:   Katherine Bellman, Russell Waring
/// date:     2023-02-16
/// version:  1
/// A local library for storing global variables or data to be used throughout
/// the application.

library globals;
import 'package:location/location.dart';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Camera variables
String filepath = '';
double? latitude;
double? longitude;

int carouselIndex = 0;

// User id
// String uid = '';

// // Marker test
// Map<String, Marker> markers = {
//   'test': location,
// };

// Identification screen / marker variables
String customMarkerPath = '';