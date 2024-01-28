// import 'dart:collection';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:convert'; // for JSON parsing

// class MapWithPins extends StatefulWidget {
//   @override
//   _MapWithPinsState createState() => _MapWithPinsState();
// }

// class _MapWithPinsState extends State<MapWithPins> {
//   GoogleMapController? _controller;
//   Map<String, List<LatLng>> pins = {}; // List to hold pin coordinates

//   @override
//   void initState() {
//     super.initState();
//     // Load GeoJSON data and extract coordinates
//     loadGeoJson().then((geoJson) {
//       setState(() {
//         pins = extractCoordinates(geoJson);
//       });
//     });
//   }

//   Future<Map<String, dynamic>> loadGeoJson() async {
//     // Load your GeoJSON data from a file or API endpoint
//     // For example, you can use the http package to make a GET request
//     // or load data from assets using rootBundle.loadString
//     // Here, we're just using a hardcoded GeoJSON string for demonstration
//     String jsonString = '''{
//       "type": "FeatureCollection",
//       "features": [
//         {
//           "type": "Feature",
//           "geometry": {
//             "type": "Point",
//             "coordinates": [0, 0] // Example coordinates
//           }
//         }
//         // Add more features as needed
//       ]
//     }''';
//     return json.decode(jsonString);
//   }

//   Map<String, List<LatLng>> extractCoordinates(Map<String, dynamic> geoJson) {
//     // Parse GeoJSON data and extract coordinates
//     Map<String, List<LatLng>> coordinates = {
//       'WaterRefill': [],
//       'BikeRack': [],
//       'Disposal': [],
//       'ChargingStation': []
//     };
//     List features = geoJson['features'];
//     for (var feature in features) {
//       String type = feature['geometry']['type'];
//       List<dynamic> coords = feature['geometry']['coordinates'];
//       double lat = coords[1]; // Latitude
//       double lng = coords[0]; // Longitude
//       // coordinates.add(LatLng(lat, lng));
//       coordinates[type]!.add(LatLng(lat, lng));
//     }
//     return coordinates;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Map with Pins'),
//       ),
//       body: GoogleMap(
//         onMapCreated: (GoogleMapController controller) {
//           _controller = controller;
//         },
//         initialCameraPosition: CameraPosition(
//           target: LatLng(0, 0), // Initial center of the map
//           zoom: 2.0, // Initial zoom level
//         ),
//         markers: pins.map((LatLng latLng) {
//           return Marker(
//             markerId: MarkerId('${latLng.latitude}-${latLng.longitude}'),
//             position: latLng,
//             icon: BitmapDescriptor.defaultMarker,
//             infoWindow: InfoWindow(
//               title: 'Pin', // Info window title
//               snippet: 'Description', // Info window snippet
//             ),
//           );
//         }).toSet(),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: MapWithPins(),
//   ));
// }
