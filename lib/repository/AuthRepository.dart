// Importing the required packages
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../Model/UserInfo.dart';
import '../SharedPreferecneService/SharedPreferenceSerivice.dart';
import '../SharedPreferecneService/SharedPreferenceSerivice.dart';
import '../data/app_exception.dart';


class UserRepository {

  final SharedPreferencesService _sharedPreferencesService =
  SharedPreferencesService();


  static Future<UserData?> createUserOnAPI(Map<dynamic, dynamic> userData) async {
    try {
      // Send user data to the backend API
      var response = await http.post(
        Uri.parse(
            'https://us-central1-dsp-backend.cloudfunctions.net/api/create_user'),
        body: jsonEncode(userData),
        headers: {'Content-Type': 'application/json'},
      );
      // Check if the request was successful
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return UserData.fromJson(responseData);

      } else {
        print('Failed to create user. StatusCode: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('API Error: $error');
      return null;
    }
  }



  static const String baseUrl = 'https://us-central1-dsp-backend.cloudfunctions.net/api';


  Future<UserData?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      ).timeout(
        const Duration(seconds: 10), // Set your desired timeout duration
        onTimeout: () {
          throw TimeoutException('The connection timed out');
        },
      );;

      if (response.statusCode == 200) {
        // Handle successful login
        final responseData = jsonDecode(response.body);
        print("user data from user repository : $responseData");

        // Assuming UserData.fromJson(responseData) parses the JSON correctly
        return UserData.fromJson(responseData);
      } else {
        // Handle other status codes
        print('Login failed with status code: ${response.statusCode}');
        return null; // Return null or appropriate value
      }
    } on SocketException {
      throw NoInternetException('no internet connection ');
    }on TimeoutException {
      throw FetchDataException('Network Request time out');
    }
  }

  // login with phone numebr

  Future<UserData?> loginwithphoneNumber(String phoneno) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/get_user_by_mob'),
        body: jsonEncode({'mobile': phoneno}),
        headers: {'Content-Type': 'application/json'},
      ).timeout(
        const Duration(seconds: 10), // Set your desired timeout duration
        onTimeout: () {
          throw TimeoutException('The connection timed out');
        },
      );

      if (response.statusCode == 200) {
        // Handle successful login
        final responseData = jsonDecode(response.body);
        print("user data from user repository : $responseData");

        // Assuming UserData.fromJson(responseData) parses the JSON correctly
        return UserData.fromJson(responseData);
      } else {
        // Handle other status codes
        print('Login failed with status code: ${response.statusCode}');
        return null; // Return null or appropriate value
      }
    } on SocketException {
      throw NoInternetException('no internet connection ');
    }on TimeoutException {
      throw FetchDataException('Network Request time out');
    }
  }

  static const String _apiUrl = 'https://us-central1-dsp-backend.cloudfunctions.net/api/update_user';

  Future<UserData?> updateUser({
     String? fullName,
     String? email,
     String? mobileNumber,
     String? dob,
     String? gender,

    // Add other fields as needed
  }) async {
    try {
      // Optionally, you can update user data in an API

      var userId = await _sharedPreferencesService.getUserId();
      print("User ID from SharedPreferences 2 : $userId");
    print("user id from authrepostirot $userId");
    print("from repostroty controller for update ");
    print("user id from dovb $dob");
    print("user id from gender  $gender");
      var response = await http.put(
        Uri.parse('$_apiUrl/$userId'),
        body: jsonEncode({
          'name': fullName,
          'email': email,
          'mobile': mobileNumber,
          'dob': dob,
          'gender': gender,

          // Include other fields here if needed
        }),
        headers: {'Content-Type': 'application/json'},
      );

      // Check if API request was successful
      if (response.statusCode == 200) {
        print("udated in backend ");
        print('Response body: ${response.body}');
        final responseData = jsonDecode(response.body);
        print("user data from user repository : $responseData");

        // Assuming UserData.fromJson(responseData) parses the JSON correctly
        // return UserData.fromJson(responseData);

        UserData? updatedUserData = UserData.fromJson(responseData);

        // Save updated user data to SharedPreferences
        await _sharedPreferencesService.updateUserData(updatedUserData);

        return updatedUserData;
      } else {
        print('Failed to update user on API. StatusCode: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Update User Error: $error');
      return null;
    }
  }

  static const String baserl = 'https://us-central1-dsp-backend.cloudfunctions.net/api';

  Future<UserData?> getSingleUser(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baserl/get_user/$userId'), // Adjust API endpoint as per your backend
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return UserData.fromJson(responseData);
      } else {
        print('Failed to fetch user. StatusCode: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception occurred during fetching user: $e');
      return null;
    }
  }

  dynamic returnResponse (http.Response response){
    if (kDebugMode) {
      print(response.statusCode);
    }

    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson ;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException('Error occured while communicating with server');

    }
  }

//   *************update user profile *************************8
  static const String _apiUrll = 'https://us-central1-dsp-backend.cloudfunctions.net/api/update_user';

  Future<UserData?> updateUserProfile({
   required String profile_img
    // Add other fields as needed
  }) async {
    try {
      // Optionally, you can update user data in an API

      var userId = await _sharedPreferencesService.getUserId();
      print("User ID from SharedPreferences 2 : $userId");
      print("user id from authrepostirot $userId");
      var response = await http.put(
        Uri.parse('$_apiUrll/$userId'),
        body: jsonEncode({
          'profile_img':profile_img
          // Include other fields here if needed
        }),
        headers: {'Content-Type': 'application/json'},
      );

      // Check if API request was successful
      if (response.statusCode == 200) {
        print("udated in backend ");
        print('Response body: ${response.body}');
        final responseData = jsonDecode(response.body);
        print("user data from user repository : $responseData");

        // Assuming UserData.fromJson(responseData) parses the JSON correctly
        // return UserData.fromJson(responseData);

        UserData? updatedUserData = UserData.fromJson(responseData);

        // Save updated user data to SharedPreferences
        await _sharedPreferencesService.updateUserData(updatedUserData);

        return updatedUserData;
      } else {
        print('Failed to update user on API. StatusCode: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Update User Error: $error');
      return null;
    }
  }
}
