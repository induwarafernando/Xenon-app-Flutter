import 'package:flutter/material.dart';
import 'package:xenon_app/components/cart_item.dart';
import 'package:xenon_app/models/shoe.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //heading
            const Text(
              'My Cart',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
                child: ListView.builder(
                    itemCount: value.getUserCart().length,
                    itemBuilder: (context, index) {
                      //get individual shoe
                      Shoe individualShoe = value.getUserCart()[index];

                      //return the cart item
                      return CartItem(
                        shoe: individualShoe,
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
