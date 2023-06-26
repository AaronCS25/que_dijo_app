import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:que_dijo_app/views/charging_view.dart';
//import 'package:que_dijo_app/views/home_view.dart';

class DisplayCamera extends StatefulWidget {
  const DisplayCamera({super.key, required this.cameras});
  final List<CameraDescription> cameras;
  @override
  State<DisplayCamera> createState() => _DisplayCameraState();
}

class _DisplayCameraState extends State<DisplayCamera> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _cameraController = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.cameras.first,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // The Future is complete, return the preview.
            return CameraPreview(_cameraController);
          } else {
            // The Future is not complete, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _cameraController.takePicture();

            if (!mounted) return;
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LastConfirmation(
                  // Pass the automatically generated path to
                  // the DisplayPictureScreen widget.
                  imagePath: image.path,
                ),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

class LastConfirmation extends StatelessWidget {
  final String imagePath;

  const LastConfirmation({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    File file = File(imagePath);

    return Scaffold(
      appBar: AppBar(title: const Text('Imagen a enviar')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(file),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () {
          //funcion para enviar a un s3
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LoadingScreen(file: file),
            ),
          );
        },
        child: const Icon(Icons.send),
      ),
    );
  }
}
