import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Model/MyOrder.dart';
import '../../../Model/MyOrderDetails.dart';
import '../../../constant/colors.dart';
import '../../../dbHelper/DbHelper.dart';
import '../../../repository/OrderDetailsRepository.dart';
import 'MyOrderDetails.dart';

class MyOrderDetails extends StatefulWidget {
  const MyOrderDetails({Key? key}) : super(key: key);

  @override
  State<MyOrderDetails> createState() => _MyOrderDetailsState();
}

class _MyOrderDetailsState extends State<MyOrderDetails> {
  late Future<List<OrderDetails>> _ordersFuture;
  final OrderDetailsRepository _orderDetailsRepository = OrderDetailsRepository();
  late String _userId;

  @override
  void initState() {
    super.initState();
    _ordersFuture = _fetchOrders();
  }

  Future<List<OrderDetails>> _fetchOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('user_id') ?? '';

    // Ensure the correct variable is used
    return _orderDetailsRepository.getOrdersByUserId(_userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("My Orders",style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: iconcolor,
      ),
      body: FutureBuilder<List<OrderDetails>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/no_item2.gif",
                  height: 60,width: 60,),
                  SizedBox(height: 20),
                  Text(
                    'No orders found.',
                    style: TextStyle(fontSize: 25, color: Colors.black54),
                  ),
                ],
              ),
            );
          }

          final orders = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];

              // Assuming `order.cartItems` is already a List of CartItems
              List<CartItems> cartItemsList = order.cartItems as List<CartItems>;
              String cartItemsFormatted = cartItemsList.asMap().entries.map((entry) {
                int index = entry.key + 1;
                var item = entry.value;
                return '$index. ${item.tests}'; // Adjust based on your CartItems model
              }).join('\n');




              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "assets/logo.jpg",
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 25),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.OrderId ?? 'No Order ID', // Default value if OrderId is null
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Price: ₹${order.totalAmount}",
                                  style: TextStyle(fontSize: 16, color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[200],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                              child: Text(
                                order.orderStatus ?? 'no order status',
                                style: TextStyle(fontSize: 16, color: Colors.blueAccent),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 1, color: Colors.grey[300]),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Tests", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          SizedBox(height: 8.0),
                          Center(
                            child: Text(
                              cartItemsFormatted,
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            // "Date: ${DateFormat('dd/MM/yyyy').format(order.selectedDate)}",
                            "Date: ${DateFormat('dd/MM/yyyy').format(DateTime.now())}",
                            style: TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderDetailsPage(orderDetails: order),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: iconcolor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            ),
                            child: Text(
                              "Details",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
