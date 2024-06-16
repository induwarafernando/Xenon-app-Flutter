import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart' as perm;
import 'dart:async';
import 'dart:ui';

class LiveOrderScreen extends StatefulWidget {
  const LiveOrderScreen({Key? key}) : super(key: key);

  @override
  _LiveOrderScreenState createState() => _LiveOrderScreenState();
}

class _LiveOrderScreenState extends State<LiveOrderScreen> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng _currentPosition = LatLng(0, 0); // Initial position at (0, 0)
  loc.Location location = loc.Location();
  bool _mapLoaded = false; // Flag to track if Google Map is loaded

  @override
  void initState() {
    super.initState();
    _requestLocationPermission(); // Request location permission
  }

  Future<void> _requestLocationPermission() async {
    while (true) {
      var status = await perm.Permission.location.request();
      if (status.isGranted) {
        _getLocation(); // Get current location if permission is granted
        break;
      } else if (status.isDenied || status.isPermanentlyDenied) {
        await Future.delayed(Duration(seconds: 2)); // Retry after delay
      } else {
        perm.openAppSettings(); // Open app settings if permission is denied
        break;
      }
    }
  }

  Future<void> _getLocation() async {
    loc.LocationData locationData;
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    loc.PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    setState(() {
      _currentPosition = LatLng(
          locationData.latitude!,
          locationData
              .longitude!); // Update current position with fetched location
      _mapLoaded = true; // Set map loaded flag to true
    });

    // Move the camera to the current location
    if (_controller.isCompleted) {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newLatLngZoom(
          _currentPosition, // Zoom level of 14.0
          14.0,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Always show the fallback image in the background
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                width: MediaQuery.of(context).size.width *
                    2, // Adjust width as needed
                height: MediaQuery.of(context).size.height *
                    2, // Adjust height as needed
                child: Image.asset(
                  'lib/images/map.png',
                  fit: BoxFit.cover, // Cover the entire scrollable area
                ),
              ),
            ),
          ),
          // Google Map widget if loaded
          if (_mapLoaded)
            GoogleMap(
              mapType: MapType.normal, // Normal map type
              initialCameraPosition: CameraPosition(
                target: _currentPosition, // Initial camera position
                zoom: 14.0, // Initial zoom level
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(
                    controller); // Complete controller when map is created
              },
              myLocationEnabled: true, // Show my location button
              myLocationButtonEnabled: true, // Enable my location
              zoomControlsEnabled: false, // Disable zoom controls
            ),
          // Order details at the bottom
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassMorphismTile(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Order number: 01',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 64, 65, 67),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Order status: Out for delivery',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                          color: Color.fromARGB(255, 29, 131, 4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Remaining time: 34 mins',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.red[800],
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GlassMorphismTile extends StatelessWidget {
  final Widget child;

  const GlassMorphismTile({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.4),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
