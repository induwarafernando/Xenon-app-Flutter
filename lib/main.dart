import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xenon_app/pages/home_page.dart';
import 'package:xenon_app/pages/login_page.dart';
import 'package:xenon_app/pages/product_detail.dart';
import 'package:xenon_app/pages/register_page.dart';
import 'package:xenon_app/pages/welcome_screen.dart';
import 'pages/intro_page.dart';
import 'pages/login_page.dart';
import 'models/cart.dart';
import 'package:xenon_app/pages/welcome_screen.dart';

void main() {
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
        home: ProductDetails(),
      ),
    ); // MaterialApp
  }
}
