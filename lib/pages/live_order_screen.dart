import 'dart:ui';

import 'package:flutter/material.dart';

class LiveOrderScreen extends StatelessWidget {
  const LiveOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Wrap the image in a SingleChildScrollView to enable scroll
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Image.asset(
                'lib/images/map.png', // Path to your image asset
                fit: BoxFit.cover, // Cover the entire screen
                width: 700, // Adjust width based on image size
                height: 1000, // Adjust height based on image size
              ),
            ),
          ),
          // Positioned widget to place the order details at the bottom center
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
                      Text(
                        'Order number: 01',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 64, 65, 67),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Order status: Out for delivery',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                          color: Color.fromARGB(255, 29, 131, 4),
                        ),
                      ),
                      SizedBox(height: 8),
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
          padding: EdgeInsets.all(16),
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
