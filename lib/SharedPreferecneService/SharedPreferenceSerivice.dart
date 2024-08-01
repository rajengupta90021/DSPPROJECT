import 'package:shared_preferences/shared_preferences.dart';

import '../Model/UserInfo.dart';

class SharedPreferencesService {


  SharedPreferences? _prefs;
  Future<bool> isUserLoggedIn() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userId = prefs.getString('user_id');
      // final String? userPath = prefs.getString('user_path');
      print("is login from shared preferene ");
      print("sharedr prefercne bool vakue $userId");

      return userId != null;
    } catch (e) {
      print('Exception occurred while checking user login status: $e');
      return false;
    }
  }

  Future<String?> getUserId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('user_id');

      print('User ID from SharedPreferences 1 : $userId');
      return userId;
    } catch (e) {
      print('Exception occurred while retrieving user ID from SharedPreferences: $e');
      return null;
    }
  }
  Future<bool> remove() async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.remove("user_id");
      return await sp.clear(); // Clear all SharedPreferences data
    } catch (e) {
      print('Exception occurred while clearing SharedPreferences: $e');
      return false; // Return false if an exception occurs
    }
  }
  Future<void> saveUserData(UserData userData) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs!.setString('user_id', userData.id ?? '');
    // Save data fields
    _prefs!.setString('name', userData.data?.name ?? '');
    _prefs!.setString('email', userData.data?.email ?? '');
    _prefs!.setString('password', userData.data?.password ?? '');
    _prefs!.setString('mobile', userData.data?.mobile ?? '');
    _prefs!.setString('profile_img', userData.data?.profileImg ?? '');
    _prefs!.setString('role', userData.data?.role ?? '');
    _prefs!.setString('created_at', userData.data?.createdAt ?? '');
    _prefs!.setString('updated_at', userData.data?.updatedAt ?? '');
  }

// Add more methods as needed to retrieve other user data from SharedPreferences

  Future<void> updateUserData(UserData userData) async {
    try {
      // print(" ttttttttt  ${userData.data?.mobile}");
      // print(" ttttttttt  ${userData.data?.name}");
      // print(" ttttttt  ${userData.data?.email}");
      // print(" ttttttttt ${userData.data?.createdAt}");
      // print(" tttttttt${userData.data?.mobile}");
      // print("tttttttt  ${userData.data?.role}");
      // print(" ttttttt ${userData.data?.updatedAt}");
      // print("tttt ${userData.data?.profileImg}");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('name', userData.data?.name ?? '');
      prefs.setString('email', userData.data?.email ?? '');
      prefs.setString('mobile', userData.data?.mobile ?? '');
      prefs.setString('profile_img', userData.data?.profileImg ?? '');
      prefs.setString('role', userData.data?.role ?? '');
      prefs.setString('updated_at', userData.data?.updatedAt ?? '');
    } catch (e) {
      print('Exception occurred while updating user data in SharedPreferences: $e');
    }
  }
}
