import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import '../Model/TestInformation.dart';

class TestInformationRepository{

  Future<List<TestInformation>> getAllTestInfo2() async {
    final response = await http.post(Uri.parse('https://us-central1-dsp-backend.cloudfunctions.net/api/getAllTestInfo'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      List<TestInformation> testInfos = jsonList.map((json) => TestInformation.fromJson(json)).toList();
      return testInfos;
    } else {
      throw Exception('Failed to load test info');
    }
  }

}


