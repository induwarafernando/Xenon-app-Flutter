import 'package:flutter/material.dart';

class OrderActivityScreen extends StatelessWidget {
  const OrderActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock list of past orders
    List<Order> pastOrders = [
      Order(orderNumber: '01', orderStatus: OrderStatus.Pending),
      Order(orderNumber: '02', orderStatus: OrderStatus.OutForDelivery),
      Order(orderNumber: '03', orderStatus: OrderStatus.Recieved),
      // Add more orders here as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
        backgroundColor: Color.fromARGB(255, 238, 245, 253),
        automaticallyImplyLeading: false, // Remove back button
      ),
      body: Container(
        color:
            Color.fromARGB(255, 238, 245, 253), // Set background color to grey
        child: ListView.builder(
          itemCount: pastOrders.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Card(
                color: Color.fromARGB(
                    184, 156, 222, 241), // Set card background color to white
                elevation: 3, // Add a slight elevation to the card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Set border radius
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
        statusColor = Color.fromARGB(255, 2, 103, 5);
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
}

enum OrderStatus {
  Pending,
  OutForDelivery,
  Recieved,
}
