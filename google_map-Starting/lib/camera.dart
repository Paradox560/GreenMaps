import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:camera/camera.dart';


class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  Interpreter? interpreter;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadModel();
  }
    Future<void> loadModel() async {
    interpreter = await Interpreter.fromAsset('model.tflite');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}