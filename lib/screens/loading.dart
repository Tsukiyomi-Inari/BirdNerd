// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
//
// /*
// author:   Katherine Bellman, Russell Waring
// version:  1
// since:    2022-02-10
//  */
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
//
//
// class Loading extends StatefulWidget {
//   const Loading({Key? key}) : super(key: key);
//
//   @override
//   State<Loading> createState() => _LoadingState();
// }
//
// class _LoadingState extends State<Loading> {
//
//   void setupLocal() async {
//     WorldTime instance = WorldTime(location: 'Berlin', flag: 'germany.png', url: '/Europe/Berlin');
//     await instance.getTime();
//     Navigator.pushReplacementNamed(context, '/home', arguments: {
//       'location': instance.location,
//       'flag': instance.flag,
//       'time': instance.time,
//       'isDayTime': instance.isDayTime,
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     setupWorldTime();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: Colors.blueAccent,
//       body: Center(
//         child: SpinKitFadingCube(
//           color:Colors.white,
//           size: 50.0,
//         ),
//       ),
//     );
//   }
// }
//
