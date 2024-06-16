import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class OrderActivityScreen extends StatefulWidget {
  const OrderActivityScreen({Key? key}) : super(key: key);

  @override
  _OrderActivityScreenState createState() => _OrderActivityScreenState();
}

class _OrderActivityScreenState extends State<OrderActivityScreen> {
  List<Order> pastOrders = [];

  @override
  void initState() {
    super.initState();
    loadOrderData();
  }

  Future<void> loadOrderData() async {
    try {
      final String response = await rootBundle.loadString('assets/orders.json');
      final List<dynamic> data = jsonDecode(response);
      setState(() {
        pastOrders = data.map((json) => Order.fromJson(json)).toList();
      });
    } catch (e) {
      print("Error loading order data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        backgroundColor: const Color.fromARGB(255, 238, 245, 253),
        automaticallyImplyLeading: false, // Remove back button
      ),
      body: Container(
        color: const Color.fromARGB(
            255, 238, 245, 253), // Set background color to grey
        child: pastOrders.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: pastOrders.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Card(
                      color: const Color.fromARGB(184, 156, 222,
                          241), // Set card background color to white
                      elevation: 3, // Add a slight elevation to the card
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Set border radius
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: OrderTile(order: pastOrders[index]),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class OrderTile extends StatelessWidget {
  final Order order;

  const OrderTile({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String statusText = '';

    switch (order.orderStatus) {
      case OrderStatus.Pending:
        statusText = 'Pending';
        break;
      case OrderStatus.OutForDelivery:
        statusText = 'Out for Delivery';
        break;
      case OrderStatus.Recieved:
        statusText = 'Received';
        break;
    }

    Color statusColor = Colors.black;

    switch (order.orderStatus) {
      case OrderStatus.Pending:
        statusColor = Colors.red;
        break;
      case OrderStatus.OutForDelivery:
        statusColor = Colors.blue;
        break;
      case OrderStatus.Recieved:
        statusColor = const Color.fromARGB(255, 2, 103, 5);
        break;
    }

    return ListTile(
      title: Text('Order number: ${order.orderNumber}'),
      subtitle: Text(
        'Status: $statusText',
        style: TextStyle(color: statusColor),
      ),
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        // Use a different icon or image for the leading widget if needed
        child: Icon(order.orderStatus == OrderStatus.OutForDelivery
            ? Icons.local_shipping
            : Icons.pending),
      ),
    );
  }
}

class Order {
  final String orderNumber;
  final OrderStatus orderStatus;

  const Order({
    required this.orderNumber,
    required this.orderStatus,
  });

  // Factory constructor to create an Order from JSON
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderNumber: json['orderNumber'],
      orderStatus: _parseOrderStatus(json['orderStatus']),
    );
  }

  // Method to convert an Order to JSON
  Map<String, dynamic> toJson() {
    return {
      'orderNumber': orderNumber,
      'orderStatus': orderStatus.toString().split('.').last,
    };
  }

  // Helper method to parse OrderStatus
  static OrderStatus _parseOrderStatus(String status) {
    switch (status) {
      case 'Pending':
        return OrderStatus.Pending;
      case 'OutForDelivery':
        return OrderStatus.OutForDelivery;
      case 'Received':
      case 'Recieved':
        return OrderStatus.Recieved;
      default:
        throw ArgumentError('Invalid order status: $status');
    }
  }
}

enum OrderStatus {
  Pending,
  OutForDelivery,
  Recieved,
}
