import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/UserAddress.dart';

class AddressRepository {
  final String _baseUrl = 'https://us-central1-dsp-backend.cloudfunctions.net/api';

  // Future<UserAdress?> createUserAddress(String uid, String currentAddress,int index) async {
  //   final String url = '$_baseUrl/create_user_address';
  //
  //   final Map<String, dynamic> body = {
  //     'uid': uid,
  //     'current_address': index == 0 ? currentAddress : null,
  //     'permanent_address': index == 1 ? currentAddress : null,
  //     'other_address': index == 2 ? currentAddress : null,
  //   };
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode(body),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       // Successfully created user address
  //       print('Address created successfully');
  //
  //       // Parse the JSON response
  //       List<dynamic> jsonResponse = jsonDecode(response.body);
  //       print('Response JSON: $jsonResponse');
  //       // Handle the response if it's a list with at least one item
  //       if (jsonResponse.isNotEmpty) {
  //         return UserAdress.fromJson(jsonResponse[0]);
  //       } else {
  //         print('No data returned');
  //         return null;
  //       }
  //     } else {
  //       // Handle errors
  //       print('Failed to create address: ${response.body}');
  //       return null; // Indicate failure
  //     }
  //   } catch (e) {
  //     // Handle network or other errors
  //     print('Error: $e');
  //     return null; // Indicate failure
  //   }
  // }



  Future<List<Object>> fetchCurrentAddresses(String userId) async {
    final String url = '$_baseUrl/get_user_address/$userId';

    try {
      final response = await http.get(Uri.parse(url));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        print('Decoded JSON: $jsonResponse');
        List<Object> currentAddresses = jsonResponse
            .map((json) =>
        UserAddress.fromJson(json).data?.currentAddress ?? []) // Assuming currentAddress is List<String>
            .toList();
        print("${currentAddresses}");
        List<Object> flattenedAddresses = [];
        currentAddresses.forEach((addressList) {
          if (addressList is List<String>) {
            flattenedAddresses.addAll(addressList);
          } else if (addressList is String) {
            flattenedAddresses.add(addressList);
          }
        });

        return flattenedAddresses;
      } else {
        print('Failed to fetch addresses. Status Code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }




  Future<bool> deleteAddress(String userId, String addressToDelete) async {
    final String url = '$_baseUrl/delete_user_address/$userId';

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'current_address': addressToDelete,
        }),
      );

      if (response.statusCode == 200) {
        print('Address deleted successfully');
        return true;
      } else {
        print('Failed to delete address. Status Code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error deleting address: $e');
      return false;
    }
  }


  Future<bool> CreateOrUpdate(String userId, String addressToDelete) async {
    final String url = '$_baseUrl/update_user_address/$userId';

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'current_address': addressToDelete,
        }),
      );

      if (response.statusCode == 200) {
        print('Address deleted successfully');
        return true;
      } else {
        print('Failed to delete address. Status Code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error deleting address: $e');
      return false;
    }
  }
}