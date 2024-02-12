import 'shoe.dart';
import 'package:flutter/foundation.dart';

class Cart extends ChangeNotifier {
  List<Shoe> shoeShop = [
    Shoe(
      name: "Denim Jacket",
      price: "20",
      //catchy phrase
      description: '\"Best Denim Style Ever Seen\"',
      imagePath: 'lib/images/pd2.jpeg',
    ),
    Shoe(
      name: "Long Sleeved Shirt",
      price: "16",
      description: "\"Casual and Comfortable\"",
      imagePath: 'lib/images/pd4.png',
    ),
    Shoe(
      name: "Party Dress",
      price: "29",
      description: "\"Elegant and Stylish\"",
      imagePath: 'lib/images/pd5.png',
    ),
    Shoe(
      name: "Side Bag",
      price: "22",
      description: "\"Richest Leather Quality\"",
      imagePath: 'lib/images/pd6.jpeg',
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
