import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../Model/ChildMember.dart';

class ChildMemberRepository {
  Stream<List<childmember>> getAllChildMembers(String apiKey) async* {
    final url = Uri.parse('https://us-central1-dsp-backend.cloudfunctions.net/api/getAll_users_child/$apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        yield List<childmember>.from(list.map((model) => childmember.fromJson(model)));
      } else {
        throw Exception('Failed to load child members');
      }
    } catch (e) {
      throw Exception('Failed to load child members: $e');
    }
  }
// **************************using futre bui8lder ??????????
  Future<List<childmember>> getAllChildMembersusingFutureBuilder(String apiKey) async {
    final url = Uri.parse('https://us-central1-dsp-backend.cloudfunctions.net/api/getAll_users_child/$apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        return List<childmember>.from(list.map((model) => childmember.fromJson(model)));
      } else {
        throw Exception('Failed to load child members');
      }
    } catch (e) {
      throw Exception('Failed to load child members: $e');
    }
  }


//   ************create child memeber *****************8

  Future<childmember> createUserChild({
    required String parentId,
    required String name,
    required String email,
    required String mobile,
    required String relation,
    required String address,
  }) async {
    final String apiUrl = 'https://us-central1-dsp-backend.cloudfunctions.net/api/create_user_child';

    final Map<String, dynamic> requestData = {
      'parentId': parentId,
      'name': name,
      'email': email,
      'mobile': mobile,
      'relation': relation,
      'address': address,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        // Request successful
        final jsonResponse = jsonDecode(response.body);
        final childMemberResponse = childmember.fromJson(jsonResponse);
        print('Created user child: ${childMemberResponse.data?.name}');

        return childMemberResponse;
      } else {
        // Request failed
        print('Failed to create user child. Error ${response.statusCode}: ${response.reasonPhrase}');
        throw Exception('Failed to create user child');
      }
    } catch (e) {
      // Exception thrown
      print('Error creating user child: $e');
      throw Exception('Error creating user child: $e');
    }
  }

//   ***********************************8

  Future<childmember> updateUserChild({
    required String userId,
    required String parentId,
    required String name,
    required String email,
    required String mobile,
    required String relation,
    required String address,
  }) async {
    final String apiUrl = 'https://us-central1-dsp-backend.cloudfunctions.net/api/update_user_child/$userId';

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'parentId': parentId,
          'name': name,
          'email': email,
          'mobile': mobile,
          'relation': relation,
          'address': address,
        }),
      );

      if (response.statusCode == 200) {
        // Request successful
        final jsonResponse = jsonDecode(response.body);
        final childMemberResponse = childmember.fromJson(jsonResponse);
        print('Updated user child: ${childMemberResponse.data?.name}');
        return childMemberResponse;
      } else {
        // Request failed
        print('Failed to update user child. Error ${response.statusCode}: ${response.reasonPhrase}');
        throw Exception('Failed to update user child');
      }
    } catch (e) {
      // Exception thrown
      print('Error updating user child: $e');
      throw Exception('Error updating user child: $e');
    }
  }

}
