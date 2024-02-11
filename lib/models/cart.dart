import 'shoe.dart';
import 'package:flutter/foundation.dart';

class Cart extends ChangeNotifier {
  List<Shoe> shoeShop = [
    Shoe(
      name: "Long Sleeved Denim",
      price: "12",
      //catchy phrase
      description: 'Best Denim Style Ever',
      imagePath: 'lib/images/pd2.jpeg',
    ),
    Shoe(
      name: "Long Sleeved Shirt",
      price: "16",
      description: "Casual and Comfortable",
      imagePath: 'lib/images/pd4.png',
    ),
    Shoe(
      name: "Party Dress",
      price: "29",
      description: "Elevate Your Game",
      imagePath: 'lib/images/pd5.png',
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
