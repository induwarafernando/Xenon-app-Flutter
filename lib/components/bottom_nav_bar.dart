import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  final void Function(int)? onTabChange;

  const MyBottomNavBar({Key? key, required this.onTabChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(vertical: 1), // Reduced padding vertically
      child: GNav(
        color: Colors.grey[400],
        activeColor: Colors.black,
        tabActiveBorder: Border.all(
            color: const Color.fromARGB(255, 205, 210, 211), width: 1),
        tabBackgroundColor: Colors.grey.shade100,
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 16,
        onTabChange: (value) => onTabChange!(value),
        tabs: const [
          GButton(
            iconSize: 24, // Adjusted icon size
            icon: Icons.home,
            text: 'Shop',
            textStyle: TextStyle(fontSize: 12), // Adjusted text size
          ),
          GButton(
            iconSize: 24,
            icon: Icons.shopping_bag_rounded,
            text: 'Cart',
            textStyle: TextStyle(fontSize: 12),
          ),
          GButton(
            iconSize: 24,
            icon: Icons.local_activity_rounded,
            text: 'Orders',
            textStyle: TextStyle(fontSize: 12),
          ),
          GButton(
            iconSize: 24,
            icon: Icons.delivery_dining_rounded,
            text: 'Delivery',
            textStyle: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
