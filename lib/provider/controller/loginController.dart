import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/UserInfo.dart';
import '../../SharedPreferecneService/SharedPreferenceSerivice.dart';
import '../../repository/AuthRepository.dart';
import '../../helper/utils.dart';
import '../../services/BottomNavigationfooter/NavigationMenu.dart';
import '../../widgets/SnackBarUtils.dart';

class LoginController with ChangeNotifier {
  UserRepository _repository = UserRepository();
  SharedPreferences? _prefs;

  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  UserData? _userData;
  UserData? get userData => _userData;

  UserData _userDatareal = UserData(); // Directly initializing with empty UserData
  UserData get userDatareal => _userDatareal;

  String _name = "";
  String get name => _name;

  Future<void> loginWithApi(BuildContext context, String email, String password) async {
    setLoading(true);

    try {
      final userData = await _repository.login(email, password);
      setLoading(false);

      if (userData != null) {
        _sharedPreferencesService.saveUserData(userData);

        SnackBarUtils.showSuccessSnackBar(
          context,
          "login successful",
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => NavigationMenu()),
              (Route<dynamic> route) => false, // Remove all previous routes
        );
      } else {

        SnackBarUtils.showErrorSnackBar(context, "Login failed, check email and password");
      }
    } catch (e) {
      setLoading(false);
      if (e is SocketException) {
        Utils().toastmessage("Network error: Please check your internet connection", Colors.red);
      } else {
        Utils().toastmessage("Network error: Please check your internet connection", Colors.red);
        print("API Exception: $e");
      }
    }
  }




  Future<bool> remove() async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.remove("user_id");
      return await sp.clear();
    } catch (e) {
      print('Exception occurred while clearing SharedPreferences: $e');
      return false;
    }
  }

  @override
  void dispose() {
    _prefs = null;
    super.dispose();
  }
}


// Future<UserData?> fetchUserData() async {
//   try {
//     setLoading(true);
//     var userId = await _sharedPreferencesService.getUserId();
//     print("User ID from SharedPreferences: $userId");
//
//     final userData = await _repository.getSingleUser(userId!); // Replace with actual method to fetch user data
//     setLoading(false);
//
//     if (userData != null) {
//       _userDatareal = userData;
//       _name = userData.data?.name ?? ''; // Update _name if needed
//       notifyListeners();
//       print("User Name from fetchUserData(): ${userData.data?.name}");
//       return userData;
//     } else {
//       Utils().toastmessage("Failed to fetch user data", Colors.red);
//       return null;
//     }
//   } catch (e) {
//
//     print("Error fetching user data: $e");
//     return null;
//   }
// }