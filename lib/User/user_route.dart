import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:async';

class UserRoute extends StatefulWidget {
  @override
  _UserRouteState createState() => _UserRouteState();
}

class _UserRouteState extends State<UserRoute> {
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

  final List<String> placeNames = [
    "Location A",
    "Location B",
    "Location C",
    "Location D",
    "Location E",
    "Location F",
    "Location G",
    "Start Point"
  ];

  final List<Color> markerColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.yellow,
  ];

  late LatLng currentPosition;
  int currentSegmentIndex = 0;
  double interpolationFactor = 0.0;
  Timer? _timer;
  bool isWaiting = false;
  bool routeCompleted = false;
  bool isRouteStarted = false;

  final double speed = 0.0005;
  final int waitDuration = 3;
  int currentWaitTime = 0;

  final MapController _mapController = MapController();

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

  Future<void> _assignRouteAndStart() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
            'Route has been assigned by the admin for waste management collection.'),
        duration: Duration(seconds: 2),
      ),
    );

    await Future.delayed(const Duration(seconds: 3));
    _startRoute();
  }

  void _startRoute() {
    setState(() {
      isRouteStarted = true;
    });
    _startMovementTimer();
  }

  void _startMovementTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
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
      currentPosition = end;

      if (currentSegmentIndex == polygonPoints.length - 2) {
        routeCompleted = true;
        _timer?.cancel();
        _showCompletionDialog();
        return;
      }

      isWaiting = true;
      currentSegmentIndex++;
      return;
    }

    double newLat =
        start.latitude + (end.latitude - start.latitude) * interpolationFactor;
    double newLng = start.longitude +
        (end.longitude - start.longitude) * interpolationFactor;
    currentPosition = LatLng(newLat, newLng);
  }

  void _showCompletionDialog() {
    Future.delayed(const Duration(milliseconds: 500), () {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Route Completed'),
            content:
                const Text('Today\'s waste collection has been completed.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
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

  Widget _buildMarkerWithLabel(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            placeNames[index],
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        const SizedBox(height: 4),
        Icon(
          Icons.location_on,
          color: markerColors[index],
          size: 25, // Reduced size for thinner appearance
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Collection Route'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
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
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: polygonPoints, // Define the polygon
                          color:
                              Colors.blue.withOpacity(0.7), // Semi-transparent
                          strokeWidth: 2.0, // Thin polygon line
                        ),
                      ],
                    ),
                    MarkerLayer(
                      markers: List.generate(
                        polygonPoints.length,
                        (index) => Marker(
                          point: polygonPoints[index],
                          width: 80,
                          height: 80,
                          child: _buildMarkerWithLabel(index),
                        ),
                      )..add(
                          Marker(
                            point: currentPosition,
                            width: 40,
                            height: 40,
                            child: const Icon(
                              Icons.local_shipping,
                              color: Colors.black,
                              size: 40,
                            ),
                          ),
                        ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (!isRouteStarted)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _assignRouteAndStart,
                child: const Text(
                  'Navigate',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  fixedSize: const Size(380, 48),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
