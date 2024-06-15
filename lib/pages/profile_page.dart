import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;
  String? networkStatus;
  StreamSubscription? _subscription;
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    _subscription = Connectivity().onConnectivityChanged.listen((event) {
      getNetworkStatus();
    });
    getUser();
    getNetworkStatus();
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
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        networkStatus = 'Mobile';
      });
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        networkStatus = 'WiFi';
      });
    } else if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        networkStatus = 'No Network';
      });
    }
  }

  Future<void> getUserImage() async {
    var userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    if (userDoc.exists) {
      setState(() {
        imageUrl = userDoc['photoURL'];
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      _uploadImage(File(selectedImage.path));
    }
  }

  Future<void> _takePhoto() async {
    final XFile? takenImage =
        await _picker.pickImage(source: ImageSource.camera);
    if (takenImage != null) {
      _uploadImage(File(takenImage.path));
    }
  }

  Future<void> _uploadImage(File image) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child(user!.uid + '.jpg');
      await storageRef.putFile(image);
      final downloadUrl = await storageRef.getDownloadURL();
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'photoURL': downloadUrl,
      }, SetOptions(merge: true));
      setState(() {
        imageUrl = downloadUrl;
      });
    } catch (e) {
      print('Error uploading image: $e');
    }
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
                    backgroundImage: imageUrl == null
                        ? NetworkImage(user?.photoURL ??
                            'https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper-thumbnail.png')
                        : NetworkImage(imageUrl!) as ImageProvider,
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
              //use the email of the user and get string before @
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
              leading: Icon(Icons.help),
              title: Text('FAQs'),
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Share'),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed('/login');
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
