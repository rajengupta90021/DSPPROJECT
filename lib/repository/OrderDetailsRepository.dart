import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/MyOrderDetails.dart';

class OrderDetailsRepository {
  final String apiUrl = 'https://66de77a6de4426916ee12f50.mockapi.io/orderDetails';

  // Method to add an order
  Future<Map<String, dynamic>> addOrder(Map<String, dynamic> orderDetails) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(orderDetails),
    );

    if (response.statusCode == 201) {
      print("**************order conformed *********************");
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to add order');
    }
  }

  // Method to get an order by ID
  Future<Map<String, dynamic>> getOrderById(String orderId) async {
    final response = await http.get(Uri.parse('$apiUrl/$orderId'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch order');
    }
  }

  // Method to update an order by ID
  Future<Map<String, dynamic>> updateOrder(String orderId, Map<String, dynamic> updatedDetails) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$orderId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedDetails),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update order');
    }
  }

  // Method to delete an order by ID
  Future<void> deleteOrder(String orderId) async {
    final response = await http.delete(Uri.parse('$apiUrl/$orderId'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete order');
    }
  }

  Future<List<OrderDetails>> getOrdersByUserId(String userId) async {
    final uri = Uri.parse('$apiUrl?userId=$userId');
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);

        return jsonResponse.map((json) {
          return OrderDetails.fromJson(json as Map<String, dynamic>);
        }).toList();
      } else {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Error fetching orders: $e');
      return [];
    }
  }



}
