import 'package:flutter/material.dart';

class OrderActivityScreen extends StatelessWidget {
  const OrderActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock list of past orders
    List<Order> pastOrders = [
      Order(orderNumber: '01', isOutForDelivery: true),
      Order(orderNumber: '02', isOutForDelivery: false),
      Order(orderNumber: '03', isOutForDelivery: true),
      // Add more orders here as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: ListView.builder(
        itemCount: pastOrders.length,
        itemBuilder: (context, index) {
          return OrderTile(order: pastOrders[index]);
        },
      ),
    );
  }
}

class OrderTile extends StatelessWidget {
  final Order order;

  const OrderTile({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Order number: ${order.orderNumber}'),
      subtitle: Text(
        'Status: ${order.isOutForDelivery == true ? "Out for Delivery" : "Pending"}',
      ),
      leading: CircleAvatar(
        // Use a different icon or image for the leading widget if needed
        child: Icon(order.isOutForDelivery == true
            ? Icons.local_shipping
            : Icons.pending),
      ),
    );
  }
}

class Order {
  final String orderNumber;
  final bool isOutForDelivery;

  const Order({
    required this.orderNumber,
    required this.isOutForDelivery,
  });
}
