import 'dart:convert'; // Import for jsonDecode if needed
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:order_tracker/order_tracker.dart'; // Assuming this is for visualizing order tracking

import '../../../Model/MyOrder.dart'; // Ensure this path is correct
import '../../../constant/colors.dart';

class OrderDetailsPage extends StatefulWidget {
  final Order order;

  const OrderDetailsPage({Key? key, required this.order}) : super(key: key);

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  List<TextDto> getOrderTrackingList() {
    // Generate tracking list dynamically based on the order status
    switch (widget.order.orderStatus) {
      case 'shipped':
        return [
          TextDto("Your order has been shipped", "Tue, 29th Mar '22 - 5:04pm"),
          TextDto("Your item has been received in the nearest hub to you.", null),
        ];
      case 'out for delivery':
        return [
          TextDto("Your order is out for delivery", "Thu, 31th Mar '22 - 2:27pm"),
        ];
      case 'delivered':
        return [
          TextDto("Your order has been delivered", "Thu, 31th Mar '22 - 3:58pm"),
        ];
      default:
        return [
          TextDto("Your order has been placed", "Fri, 25th Mar '22 - 10:47pm"),
          TextDto("Seller has processed your order", "Sun, 27th Mar '22 - 10:19am"),
          TextDto("Your item has been picked up by courier partner.", "Tue, 29th Mar '22 - 5:00pm"),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TextDto> trackingList = getOrderTrackingList();

    // Extracting details from the widget.order
    List<dynamic> cartItemsList = jsonDecode(widget.order.cartItems);
    String cartItemsFormatted = cartItemsList.asMap().entries.map((entry) {
      int index = entry.key;
      var item = entry.value;
      return '${index + 1}. ${item['tests']}';
    }).join('\n');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Order Details"),
        backgroundColor: iconcolor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order ID: ${widget.order.orderId}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ), Text(
                    "Order ID: ${widget.order.childUserRelation}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ), Text(
                    "Order ID: ${widget.order.orderId}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ), Text(
                    "Order ID: ${widget.order.orderId}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Price: ₹${widget.order.totalAmount}",
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Status: ${widget.order.orderStatus}",
                    style: TextStyle(fontSize: 16, color: Colors.blueAccent),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Date: ${DateFormat('dd/MM/yyyy').format(widget.order.selectedDate)}",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Tests:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    cartItemsFormatted,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Divider(thickness: 1, color: Colors.grey[300]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OrderTracker(
                status: Status.values.firstWhere(
                      (status) => status.toString().split('.').last == widget.order.orderStatus.toLowerCase(),
                  orElse: () => Status.shipped, // Default status
                ),
                activeColor: Colors.green,
                inActiveColor: Colors.grey[300],
                orderTitleAndDateList: getOrderTrackingList(),
                shippedTitleAndDateList: [],
                outOfDeliveryTitleAndDateList: [],
                deliveredTitleAndDateList: [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
