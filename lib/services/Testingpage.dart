import 'dart:convert'; // Import to use jsonDecode
import 'package:flutter/material.dart';
import '../Model/MyOrder.dart';
import '../dbHelper/DbHelper.dart';

class OrdersScreen extends StatefulWidget {
  final String userId;

  OrdersScreen({required this.userId});

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future<List<Order>> _ordersFuture;
  final dbHelper = DBHelperOrder();

  @override
  void initState() {
    super.initState();
    _ordersFuture = _fetchOrders();
  }

  Future<List<Order>> _fetchOrders() async {
    final ordersMaps = await dbHelper.getOrders(widget.userId);
    return ordersMaps.map((map) => Order.fromMap(map)).toList();
  }

  Future<void> _updateOrder(Order order) async {
    try {
      await dbHelper.updateOrder(
        orderId: order.orderId,
        orderStatus: 'Shipped', // Example status
        paymentStatus: 'Not Paid', // Example status
        deliveryDate: DateTime.now().add(Duration(days: 5)), // Example future date
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order ${order.orderId} updated successfully')),
      );
      setState(() {
        _ordersFuture = _fetchOrders(); // Refresh the order list
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update order: $e')),
      );
    }
  }

  Future<void> _deleteOrder(String orderId) async {
    try {
      await dbHelper.deleteOrder(orderId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order $orderId deleted successfully')),
      );
      setState(() {
        _ordersFuture = _fetchOrders(); // Refresh the order list
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete order: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: FutureBuilder<List<Order>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No orders found.'));
          } else {
            final orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                // Parse the cartItems JSON string
                List<dynamic> cartItemsList = jsonDecode(order.cartItems);

                // Format the cart items for display
                String cartItemsFormatted = cartItemsList.map((item) {
                  return 'Test: ${item['tests']}, Rate: ${item['rates']}';
                }).join('\n');

                return Card(
                  margin: EdgeInsets.all(8.0),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Order ID: ${order.orderId}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text('User ID: ${order.userId}'),
                        Text('Username: ${order.username}'),
                        Text('Email: ${order.email}'),
                        Text('Password: ${order.password}'),
                        Text('Mobile: ${order.mobile}'),
                        Text('Profile Image: ${order.profileImg}'),
                        Text('Role: ${order.role}'),
                        Text('Created At: ${order.createdAt}'),
                        Text('Updated At: ${order.updatedAt}'),
                        Text('Child Name: ${order.childName}'),
                        Text('Child User Relation: ${order.childUserRelation}'),
                        Text('Child User Phone: ${order.childUserPhone}'),
                        Text('Child User Dob: ${order.childUserDob}'),
                        Text('Parent Child User Address: ${order.parentChildUserAddress}'),
                        Text('Child User House No: ${order.childUserHouseNo}'),
                        Text('Child User Pin Code: ${order.childUserPinCode}'),
                        Text('Child User City: ${order.childUserCity}'),
                        Text('Child User State: ${order.childUserState}'),
                        Text('Selected Date: ${order.selectedDate.toLocal()}'),
                        Text('Start Time: ${order.startTime}'),
                        Text('End Time: ${order.endTime}'),
                        Text('Order Status: ${order.orderStatus}'),
                        Text('Payment Status: ${order.paymentStatus}'),
                        Text('Delivery Date: ${order.deliveryDate?.toLocal()}'),
                        Text('Total Amount: \$${order.totalAmount.toStringAsFixed(2)}'),
                        SizedBox(height: 8),
                        Text('Cart Items:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(cartItemsFormatted),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => _updateOrder(order),
                          child: Text('Update Order'),
                        ),
                        Divider(),
                        ElevatedButton(
                          onPressed: () => _deleteOrder(order.orderId),
                          child: Text('Delete Order'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
