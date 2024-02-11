import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  final void Function(int)? onTabChange;

  MyBottomNavBar({Key? key, required this.onTabChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1), // Reduced padding vertically
      child: GNav(
        color: Colors.grey[400],
        activeColor: Colors.black,
        tabActiveBorder: Border.all(color: Colors.white, width: 1),
        tabBackgroundColor: Colors.grey.shade100,
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 16,
        onTabChange: (value) => onTabChange!(value),
        tabs: [
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
            icon: Icons.person,
            text: 'Profile',
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
