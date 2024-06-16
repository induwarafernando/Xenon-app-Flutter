import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xenon_app/pages/login_page.dart';
import 'package:location/location.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;
  String? networkStatus = 'WiFi'; // Default network status as WiFi
  StreamSubscription? _subscription;
  final ImagePicker _picker = ImagePicker();
  File? _localImageFile;
  bool _isLocationServiceEnabled = false;
  bool _isNetworkStatusEnabled = false;
  LocationData? _locationData;

  @override
  void initState() {
    super.initState();
    _subscription = Connectivity().onConnectivityChanged.listen((event) {
      getNetworkStatus();
    });
    getUser();
    getNetworkStatus();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void getUser() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    setState(() {
      user = currentUser;
      if (user != null) {
        getUserImage();
      }
    });
  }

  Future<void> getNetworkStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      if (connectivityResult == ConnectivityResult.mobile) {
        networkStatus = 'Mobile Data';
      } else if (connectivityResult == ConnectivityResult.wifi) {
        networkStatus = 'WiFi';
      } else if (connectivityResult == ConnectivityResult.none) {
        networkStatus = 'No Network';
      } else {
        networkStatus = 'WiFi';
      }
    });

    if (_isNetworkStatusEnabled) {
      _showNetworkStatusDialog();
    }
  }

  Future<void> getUserImage() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/${user!.uid}.jpg';
      final localImage = File(filePath);
      if (localImage.existsSync()) {
        setState(() {
          _localImageFile = localImage;
        });
      }
    } catch (e) {
      print('Error getting user image: $e');
    }
  }

  Future<void> _pickImage() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      await _saveImageLocally(File(selectedImage.path));
    }
  }

  Future<void> _takePhoto() async {
    final XFile? takenImage =
        await _picker.pickImage(source: ImageSource.camera);
    if (takenImage != null) {
      await _saveImageLocally(File(takenImage.path));
    }
  }

  Future<void> _saveImageLocally(File image) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/${user!.uid}.jpg';
      final localImage = await image.copy(filePath);
      setState(() {
        _localImageFile = localImage;
      });
    } catch (e) {
      print('Error saving image locally: $e');
    }
  }

  Future<void> _fetchLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    setState(() {
      _isLocationServiceEnabled = true;
    });

    _showLocationDialog(_locationData!.latitude, _locationData!.longitude);
  }

  void _showLocationDialog(double? latitude, double? longitude) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Current Location'),
          content: Text('Latitude: $latitude\nLongitude: $longitude'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showNetworkStatusDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Network Status'),
          content: Text('Current Network Status: Connected to WiFi'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _localImageFile != null
                        ? FileImage(_localImageFile!)
                        : NetworkImage(user?.photoURL ??
                                'https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper-thumbnail.png')
                            as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () {
                        _showPicker(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              user?.email?.split('@').first ?? 'No Name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              user?.email ?? 'No Email',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Network Status: $networkStatus',
              style: TextStyle(fontSize: 16),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('My Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Fetch Location'),
              trailing: Switch(
                value: _isLocationServiceEnabled,
                onChanged: (value) {
                  if (value) {
                    _fetchLocation();
                  } else {
                    setState(() {
                      _isLocationServiceEnabled = false;
                    });
                  }
                },
              ),
            ),
            // Add a toggle to fetch network status popup
            ListTile(
              leading: Icon(Icons.network_check),
              title: Text('Network Status'),
              trailing: Switch(
                value: _isNetworkStatusEnabled,
                onChanged: (value) {
                  setState(() {
                    _isNetworkStatusEnabled = value;
                    if (value) {
                      getNetworkStatus();
                    }
                  });
                },
              ),
            ),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  _pickImage();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  _takePhoto();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
