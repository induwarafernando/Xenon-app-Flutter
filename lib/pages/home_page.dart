import 'package:flutter/material.dart';
import 'package:xenon_app/pages/live_order_screen.dart';
import 'package:xenon_app/pages/order_activity_screen.dart';
import '../components/bottom_nav_bar.dart';
import 'cart_page.dart';
import 'shop_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void navigateBottomNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> get _pages => [
        const ShopPage(),
        const CartPage(),
        const OrderActivityScreen(),
        LiveOrderScreen()
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 245, 253),
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomNavBar(index),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: const Icon(Icons.menu),
            ),
            color: Colors.black,
          ),
        ),
        title: Row(
          children: [
            SizedBox(width: 2), // Adjust spacing between logo and text
            Text(
              'XENON',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w700 // Adjust font size as needed
                  ),
            ),
            SizedBox(width: 4), // Adjust spacing between text and slogan
            Text(
              ': Your Style, Your Stores, We Deliver',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 13, // Adjust font size as needed
              ),
            ),
            SizedBox(width: 4), // Adjust spacing between text and icon
            //add aprofile icon
            IconButton(
              alignment: Alignment.topRight,
              //on prressed navigate to profile page route
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },

              icon: Icon(Icons.account_circle),
              color: Colors.black,
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
                  child: Image.asset(
                    'lib/images/LogoX1.png',
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Divider(
                    color: Colors.grey[800],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Home',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                    title: Text(
                      'About',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
