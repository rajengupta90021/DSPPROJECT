import 'dart:convert';

import 'package:http/http.dart' as http;

class CategegoryRepository{



  Future<List<String>> fetchCategories() async {
    final response = await http.get(Uri.parse('https://us-central1-dsp-backend.cloudfunctions.net/api/getAllCategoryList'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      List<dynamic> data = json.decode(response.body);
      // Assuming data is already a list of strings
      List<String> categories = List<String>.from(data);
      print("lsit is category $categories");
      return categories;
    } else {
      // If the server response was not OK, throw an error.
      throw Exception('Failed to load categories');
    }
  }

}