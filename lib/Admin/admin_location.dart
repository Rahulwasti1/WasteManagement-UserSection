import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map/flutter_map.dart'; // For FlutterMap, TileLayer, PolygonLayer, etc.
import 'package:latlong2/latlong.dart'; // For LatLng

import 'dart:async';
import 'dart:math';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final List<LatLng> polygonPoints = [
    LatLng(27.693186004732294, 85.30165366470834),
    LatLng(27.698497058305616, 85.30042888215243),
    LatLng(27.698524864188766, 85.29405373192552),
    LatLng(27.69991514931399, 85.28629677573807),
    LatLng(27.70631023276118, 85.28849510340252),
    LatLng(27.704113702879493, 85.29565537065248),
    LatLng(27.703446393904898, 85.30039747747152),
    LatLng(27.693186004732294, 85.30165366470834),
  ];

  late LatLng currentPosition;
  int currentSegmentIndex = 0;
  double interpolationFactor = 0.0;
  Timer? _timer;
  bool isWaiting = false;
  bool routeCompleted = false;
  final double speed = 0.001; // Adjusted for ~10 second total movement time

  // New variables for timing
  int waitDuration = 6; // seconds to wait at each point
  int currentWaitTime = 0;

  final MapController _mapController = MapController(); // Added MapController

  bool isRouteStarted = false; // Flag to control route start

  @override
  void initState() {
    super.initState();
    currentPosition = polygonPoints[0];
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startRoute() {
    setState(() {
      isRouteStarted = true; // Route started, hide the button
    });
    _startMovementTimer();
  }

  void _startMovementTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (!routeCompleted) {
        setState(() {
          if (isWaiting) {
            currentWaitTime += 50;
            if (currentWaitTime >= waitDuration * 1000) {
              isWaiting = false;
              currentWaitTime = 0;
              interpolationFactor = 0.0;
            }
          } else {
            _moveAlongPolygon();
          }
        });
      }
    });
  }

  void _moveAlongPolygon() {
    if (routeCompleted) return;

    LatLng start = polygonPoints[currentSegmentIndex];
    LatLng end = polygonPoints[currentSegmentIndex + 1];

    interpolationFactor += speed;

    if (interpolationFactor >= 1.0) {
      // Reached a vertex
      currentPosition = end;

      if (currentSegmentIndex == polygonPoints.length - 2) {
        // Reached final point
        routeCompleted = true;
        _timer?.cancel();
        _showCompletionDialog();
        return;
      }

      // Start waiting at the vertex
      isWaiting = true;
      currentSegmentIndex++;
      return;
    }

    // Linear interpolation between points
    double newLat =
        start.latitude + (end.latitude - start.latitude) * interpolationFactor;
    double newLng = start.longitude +
        (end.longitude - start.longitude) * interpolationFactor;
    currentPosition = LatLng(newLat, newLng);
  }

  void _showCompletionDialog() {
    Future.delayed(Duration(milliseconds: 500), () {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Route Completed'),
            content: Text('Today\'s collection is completed'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }

  double _calculateRotationAngle() {
    if (isWaiting) return 0;
    LatLng start = polygonPoints[currentSegmentIndex];
    LatLng end = polygonPoints[currentSegmentIndex + 1];
    double deltaLng = end.longitude - start.longitude;
    double deltaLat = end.latitude - start.latitude;
    return atan2(deltaLng, deltaLat);
  }

  List<Color> markerColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.teal,
    Colors.pink,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collection Route'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                FlutterMap(
                  mapController: _mapController, // Added MapController
                  options: MapOptions(
                    initialCenter:
                        LatLng(27.699748118746737, 85.29397472007343),
                    initialZoom: 15.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    PolygonLayer(
                      polygons: [
                        Polygon(
                          points: polygonPoints,
                          color: Colors.blue.withOpacity(0.3),
                          borderColor: Colors.blue,
                          borderStrokeWidth: 2,
                        ),
                      ],
                    ),
                    MarkerLayer(
                      markers: [
                        ...List.generate(
                          polygonPoints.length,
                          (index) => Marker(
                            point: polygonPoints[index],
                            width: 30,
                            height: 30,
                            child: Icon(
                              Icons.location_on,
                              color: markerColors[index],
                              size: 30,
                            ),
                          ),
                        ),
                        Marker(
                          point: currentPosition,
                          width: 40,
                          height: 40,
                          child: Transform.rotate(
                            angle: _calculateRotationAngle(),
                            child: Icon(
                              Icons.local_shipping,
                              color: isWaiting ? Colors.red : Colors.black,
                              size: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (isWaiting && !routeCompleted)
                  Positioned(
                    top: 20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Text(
                          'Collecting at stop ${currentSegmentIndex + 1}...',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (!isRouteStarted)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _startRoute,
                child: Text(
                  'Start Route',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  fixedSize: Size(double.infinity, 50),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _launchURL() async {
    final Uri url = Uri.parse('https://openstreetmap.org/copyright');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
