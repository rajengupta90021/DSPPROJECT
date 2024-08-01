import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/TestInformation.dart';

class SingleCategoryTestRepository {
  final String category;

  SingleCategoryTestRepository(this.category);

  Future<List<TestInformation>> fetchSingleCategoriesdetails() async {
    final url = 'https://us-central1-dsp-backend.cloudfunctions.net/api/getCategoryTestInfo';


    var body = [
      {'category':category},

    ];

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({'category': [category]}),
      );

      if (response.statusCode == 200) {
        // print(response.body);
        final List<dynamic> data = json.decode(response.body);
        List<TestInformation> tests = data.map((json) => TestInformation.fromJson(json)).toList();
        print("List of single test info: ${data}");
        print("List of single test  data info: ${tests}");
        tests.forEach((test) {
          print('Test ID: ${test.id}');
          print('Rates: ${test.rates}');
          print('Pre Test Information: ${test.preTestInformation}');
          print('S No: ${test.sNo}');
          print('Staiblility Room: ${test.staiblilityRoom}');
          print('Method: ${test.method}');
          print('Reporting: ${test.reporting}');
          print('Tests: ${test.tests}');
          print('Specimen: ${test.specimen}');
          print('Staiblility Refrigerated: ${test.staiblilityRefrigerated}');
          print('Sample Coll: ${test.sampleColl}');
          print('Parameters Covered: ${test.parametersCovered}');
          print('Staiblility Frozen: ${test.staiblilityFrozen}');
          print('Report Delivery: ${test.reportDelivery}');
          print('---------------------');
        });
        return tests;
      } else {
        throw Exception('Failed to load tests: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }
}
