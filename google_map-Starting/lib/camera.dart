import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import "./model.dart";

/* Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure that plugin services are initialized.
  final cameras = await availableCameras(); // Retrieve the list of available cameras.

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: CameraApp(
        camera: firstCamera,
      ),
    ),
  );
} */

class CameraApp extends StatefulWidget {
  final CameraDescription camera;

  const CameraApp({
    Key? key,
    required this.camera,
  }) : super(key: key);

  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeCameraController();
  }

  void _initializeCameraController() async {
    await _controller.initialize();
    if (!mounted) {
      return;
    }
    setState(() {});
  }


void navigateToModelPage(BuildContext context, XFile image) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Model(
        imgPath: image.path,
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(title: Text('Camera Example')),
      body: CameraPreview(_controller),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: () async {
          try {
            // Take a picture and save it to the gallery.
            final image = await _controller.takePicture();
            // go to the model page and pass the image to it
            navigateToModelPage(context, image);
            print('Image saved to gallery: ${image.path}');
          } catch (e) {
            print('Error taking picture: $e');
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
