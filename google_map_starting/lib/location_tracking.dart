/* import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:green_campus_map/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:convert'; // for JSON parsing

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);

  @override
  State<OrderTrackingPage> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(38.9069, -77.0727);
  static const LatLng destination = LatLng(38.9083, -77.0736);

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  Map<String, List<LatLng>> pins = {};

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then((location) {
      currentLocation = location;
    });

    GoogleMapController greenMapController = await _controller.future;

    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;

        greenMapController
            .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                zoom: 13.5,
                target: LatLng(
                  newLoc.latitude!,
                  newLoc.longitude!,
                ))));

        setState(() {});
      },
    );
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
      setState(() {});
    }
  }

  @override
  void initState() {
    //getCurrentLocation();
    getPolyPoints();
    super.initState();
    loadGeoJson().then((geoJson) {
      setState(() {
        pins = extractCoordinates(geoJson);
      });
    });
  }

  Set<Marker> makeMarkers() {
    Set<Marker> highlighters = {};
    for (String type in pins.keys) {
      for (LatLng latlng in pins[type]!) {
        highlighters.add(Marker(
          markerId: MarkerId(type),
          position: latlng,
        ));
      }
    }
    return highlighters;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Welcome to GreenMaps",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 65, 172, 68),
      ),
      body: Stack(children: [
        //currentLocation == null
        //? const Center(child: Text("Loading..."))
        //:
        GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(sourceLocation.latitude, sourceLocation.longitude),
              zoom: 18),
          polylines: {
            Polyline(
              polylineId: PolylineId("route"),
              points: polylineCoordinates,
              color: primaryColor,
              width: 6,
            )
          },
          markers: makeMarkers(),
          onMapCreated: (mapController) {
            _controller.complete(mapController);
          },
        ),
        Positioned(
          top: 16,
          left: 8,
          right: 8,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(Icons.camera_alt),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 30,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildIconWithText(Icons.local_drink, "Water Refill"),
                    _buildIconWithText(Icons.directions_bike, "Bike Racks"),
                    _buildIconWithText(Icons.ev_station, "EV Chargers"),
                    _buildIconWithText(Icons.recycling, "Recycling"),
                    _buildIconWithText(Icons.compost, "Compost Bins"),
                    // Add more icons as needed
                  ],
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

  Widget _buildIconWithText(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(
                30), // Adjust this value for completely round sides
            right: Radius.circular(
                30), // Adjust this value for completely round sides
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 3, horizontal: 12), // Adjust vertical padding here
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20), // Adjust this value for the icon size
              SizedBox(
                  width:
                      8), // Adjust this value for spacing between icon and text
              Text(
                text,
                style: TextStyle(
                    fontSize: 14), // Adjust this value for the text size
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> loadGeoJson() async {
    // Load your GeoJSON data from a file or API endpoint
    // For example, you can use the http package to make a GET request
    // or load data from assets using rootBundle.loadString
    // Here, we're just using a hardcoded GeoJSON string for demonstration
    String jsonString = '''{
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "geometry": {
            "type": "Point",
            "coordinates": [0, 0] // Example coordinates
          }
        }
        // Add more features as needed
      ]
    }''';
    return json.decode(jsonString);
  }

  Map<String, List<LatLng>> extractCoordinates(Map<String, dynamic> geoJson) {
    // Parse GeoJSON data and extract coordinates
    Map<String, List<LatLng>> coordinates = {
      'WaterRefill': [],
      'BikeRack': [],
      'Disposal': [],
      'ChargingStation': []
    };
    if (geoJson.containsKey('features') && geoJson['features'] != null) {
      List features = geoJson['features'];
      for (var feature in features) {
        String type = feature['geometry']['type'];
        List<dynamic> coords = feature['geometry']['coordinates'];
        double lat = coords[1]; // Latitude
        double lng = coords[0]; // Longitude
        print("$lat : $lng");
        // coordinates.add(LatLng(lat, lng));
        coordinates[type]!.add(LatLng(lat, lng));
      }
    }
    return coordinates;
  }
}
 */