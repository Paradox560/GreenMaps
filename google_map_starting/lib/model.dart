import "dart:io";
import "dart:typed_data";
import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:image/image.dart" as img;
import "package:tflite_flutter/tflite_flutter.dart";

class Model extends StatefulWidget {
  final String imgPath;
  const Model({super.key, required this.imgPath});
  @override
  State<Model> createState() => _ModelState();
}

class _ModelState extends State<Model> {
  late Interpreter interpreter;
  Future<void> classifyImage() async {
    // Load image from path and convert it to bytes and resize to 256x256 for our model input
    var resizedImg = Image.file(File(widget.imgPath), width: 256, height: 256);
    runInference(resizedImg);
  }


  Future<List> runInference(Image image) async {
    // Preprocess the input image
    

    // Allocate memory for the output
    final output = List<double>.filled(1, 0).reshape([1, 1]);

    // Run inference
    interpreter.run(input, output);

    return output;
  }

  Future<String> loadModel() async {
    interpreter = await Interpreter.fromAsset('assets/model.tflite');
    return classifyImage();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Interpreter>(
      future: loadModel(),
      builder: (BuildContext context, AsyncSnapshot<Interpreter> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          classifyImage(snapshot.data!);
          return Scaffold(
              // Your other widgets here...
              );
        }
      },
    );
  }
}
