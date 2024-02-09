import 'shoe.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class Cart extends ChangeNotifier {
  List<Shoe> shoeShop = [
    Shoe(
      name: "Nike Air Max 90",
      price: "150",
      description: 'Adds comfort to your journey.',
      imagePath: 'lib/imagesnike/pexels-aman-jakhar-1124466.jpg',
    ),
    Shoe(
      name: "Nike Air",
      price: "190",
      description: "Stay fresh",
      imagePath: 'lib/imagesnike/pexels-ray-piedra-1456706.jpg',
    ),
    Shoe(
      name: "Nike Air Max",
      price: "200",
      description: "Lightest Ever",
      imagePath: 'lib/imagesnike/pexels-ray-piedra-1464624.jpg',
    ),
    Shoe(
      name: "Air Jordan",
      price: "220",
      description: "Forward-Thinking Utility",
      imagePath: 'lib/imagesnike/pexels-aman-jakhar-1124466.jpg',
    ),
  ];

  //list of itemsin user cart
  List<Shoe> userCart = [];

  //get the list of shoes for sale
  List<Shoe> getShoeList() {
    return shoeShop;
  }

  //get cart
  List<Shoe> getUserCart() {
    return userCart;
  }

  //add items to cart
  void addItemToCart(Shoe shoe) {
    userCart.add(shoe);
    notifyListeners();
  }

  //remove items from cart
  void removeItemFromCart(Shoe shoe) {
    userCart.remove(shoe);
    notifyListeners();
  }
}
