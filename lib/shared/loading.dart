/// loading.dart
/// author:   Katherine Bellman, Russell Waring
/// date:     2023-03-16
/// version:  1
/// This loading widget concept was adopted from this tutorial series:
/// The Net Ninja. (2019, November 20). Flutter &amp; Firebase app build.
/// YouTube. Retrieved March 10, 2023, from
/// https://www.youtube.com/playlist?list=PL4cUxeGkcC9j--TKIdkb3ISfRbJeJYQwC

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: SpinKitFadingCircle(
          color: Colors.teal,
          size: 50.0,
        ),
      ),
    );
  }
}
