/// camera.dart
/// @authors:   Katherine Bellman, Russell Waring
/// @version:   2
/// @since:     2023-02-17
/// The camera preview acts as the landing page after a user has successfully
/// signed in. Allows the user quick access to capturing an image.


import 'package:birdnerd/screens/home/identification.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:birdnerd/shared/globals.dart' as globals;
import 'package:location/location.dart';
import '../../shared/globals.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  bool _cameraInitialized = false;
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  int direction = 0;

  final controller = PageController(initialPage: 1);
  Location location = Location();
  @override
  void initState() {
    startCamera(0);
    super.initState();
  }

  Future<void> startCamera(int direction) async {
    cameras = await availableCameras();
    cameraController = CameraController(
        cameras[direction], ResolutionPreset.high,
        enableAudio: false);
    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        _cameraInitialized = true;
      }); // refreshes widget?
    }).catchError((e) {});
  }

  @override
  void dispose() {
    cameraController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraInitialized && cameraController.value.isInitialized) {
      return Scaffold(
        body: Stack(
          children: [
            Container(
                width: double.infinity,
                height: double.infinity,
                child: CameraPreview(cameraController)),
            GestureDetector(
                onTap: () {
                  setState(() {
                    direction = direction == 0 ? 1 : 0;
                    startCamera(direction);
                  });
                },
                child: button(
                    Icons.flip_camera_ios_outlined, Alignment.bottomLeft)),
            GestureDetector(
              onTap: () async {
                try {
                  cameraController.takePicture().then((XFile? file) {
                    if (!mounted) return;
                    if (file != null) {
                      //print("Picture saved to ${file.path}");
                      /// Stores the filepath of captured image into globals
                      globals.filepath = file.path;

                      /// Get the user's location
                      location.getLocation().then((pos) {
                        globals.latitude = pos.latitude;
                        globals.longitude = pos.longitude;
                      //print(globals.latitude);
                      //print(globals.longitude);
                                            });
                      //Navigator.pushNamed(context, '/identification');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => IdentificationScreen()),
                      );
                    }
                  });
                } catch (e) {
// Log error to console.
                  print(e);
                }
              },
              child: button(Icons.camera_alt_outlined, Alignment.bottomCenter),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget button(IconData icon, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.only(
          left: 20,
          bottom: 20,
        ),
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(2, 2),
                blurRadius: 10,
              )
            ]),
        child: Center(
          child: Icon(
            icon,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
