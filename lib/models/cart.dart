import 'shoe.dart';
import 'package:flutter/foundation.dart';

class Cart extends ChangeNotifier {
  List<Shoe> shoeShop = [
    Shoe(
      name: "Denim Jacket",
      price: "20",
      //catchy phrase
      description: '"Best Denim Style Ever Seen"',
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
    //for pd8-women casual wear Top price 4200
    Shoe(
      name: "Casual Wear - Top",
      price: "4200",
      description: "\"Casual and Comfortable\"",
      imagePath: 'lib/images/pd7.png',
    ),
    //pd7-casual frock long sleeved 5000
    Shoe(
      name: "Casual Frock - Long Sleeved",
      price: "5000",
      description: "\"Casual and Comfortable\"",
      imagePath: 'lib/images/pd8.png',
    ),
    //pd9- women casual wear top 4000
    Shoe(
      name: "Casual Wear - Top Printed",
      price: "4000",
      description: "\"Stylish and Comfortable\"",
      imagePath: 'lib/images/pd9.png',
    ),
    //pd10 -frock pink long sleeved 4500
    Shoe(
      name: "Casual Frock - Long Sleeved Pink",
      price: "4500",
      description: "\"fasionable and Comfortable\"",
      imagePath: 'lib/images/pd10.png',
    ),
    //,pd11 - women office wear top 4000
    Shoe(
      name: "Office Wear - Top",
      price: "4000",
      description: "\"Elegant and Stylish\"",
      imagePath: 'lib/images/pd11.png',
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
