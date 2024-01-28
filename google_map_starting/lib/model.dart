import "dart:typed_data";
import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:image/image.dart" as img;
import "package:tflite_flutter/tflite_flutter.dart";


class Model extends StatefulWidget {
  final imgPath;
  const Model({super.key, required this.imgPath});
  @override
  State<Model> createState() => _ModelState();
}

class _ModelState extends State<Model> {
  Future<void> classifyImage(Interpreter interpreter) async {
    //loading the image from file
    var image = img.decodeImage(widget.imgPath.readAsBytesSync());
    //resizing the image to be a 256x256 image as the model only accepts that size by manipulating the bytes
    var height = image!.height;
    var width = image.width;
    Uint32List input = Uint32List(256 * 256);
    var index = 0;
    for (var i = 0; i < 256; i++) {
      for (var j = 0; j < 256; j++) {
        var pixel = image.getPixel(j, i);
        input[index] = pixel as int;
        index++;
      }
    }


    final output = List<List<dynamic>>.filled(1, List<dynamic>.filled(1001, 0));
    interpreter.run(input, output);
  
    print(output);

  }
  @override
  Future<void> initState() async {
    // TODO: implement initState
    super.initState();
    final interpreter = await Interpreter.fromAsset('assets/model.tflite');
    classifyImage(interpreter);
    interpreter.run;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
    );
  }
}