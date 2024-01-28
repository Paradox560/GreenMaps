import 'package:flutter/material.dart';

class TrashScreen extends StatelessWidget {
  const TrashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "GreenMaps",
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 65, 172, 68),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                image: DecorationImage(
                  image: AssetImage("assets/trash.png"),
                  
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Happy Trashing!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
            child: Text(
              "This material cannot be safely recycled. Please take care and dispose of this material in a trash can nearby.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              child: Text("View Map"),
              style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 135, 201, 255)),
            ),
          ),
        ],
      ),
    );
  }
}
