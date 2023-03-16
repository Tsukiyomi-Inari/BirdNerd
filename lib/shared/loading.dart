import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// loading.dart
/// author:   Katherine Bellman, Russell Waring
/// date:     2023-03-16
/// version:  1
/// This loading widget concept was adopted from the tutorial series
/// Flutter and Firebase App by The Net Ninja found on YouTube.com.
class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: const Center(
        child: SpinKitFadingCircle(
          color: Colors.teal,
          size: 50.0,
        ),
      ),
    );
  }
}
