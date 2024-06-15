import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xenon_app/pages/welcome_screen.dart'; // Ensure this is correct
import 'models/cart.dart'; // Ensure this is correct
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pages/login_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // try {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // } catch (e) {
  //   print("Firebase initialization error: $e");
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Cart>(
      create: (context) => Cart(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: const WelcomeScreen(), // Ensure this is defined and working
      ),
    ); // MaterialApp
  }
}
