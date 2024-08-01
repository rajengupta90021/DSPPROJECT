// import 'dart:async';
// import 'package:dspuiproject/services/home_page2.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../helper/session_manager/SessionController.dart';
// import '../services/BottomNavigationfooter/NavigationMenu.dart';
//
//
// class SplashService {
//
//
//   void isLogin(BuildContext context) {
//
//     final _auth = FirebaseAuth.instance;
//
//     final user =  _auth.currentUser;
//
//
//     if(user != null){
//       SessionController().userId= user.uid.toString();
//       Timer(Duration(seconds: 3), () {
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(builder: (context) => homepage2()), // Adjust to your login screen widget's name
//         // );
//         Get.offAll(() => NavigationMenu());
//
//       });
//
//     }else{
//
//       Timer(Duration(seconds: 3), () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => homepage2()), // Adjust to your login screen widget's name
//         );
//         Get.offAll(() => NavigationMenu());
//       });
//     }
//
//
//   }
//
//
//   Future<bool> isLoginwithsharedpreference(BuildContext context) async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//
//       // Retrieve user data from SharedPreferences
//       final String? userId = prefs.getString('user_id');
//       final String? userPath = prefs.getString('user_path');
//
//       if (userId != null && userPath != null) {
//         // User data found in SharedPreferences, set userId and return true
//         SessionController().userId = userId;
//         return true;
//       } else {
//         // No user data found in SharedPreferences, return false
//         return false;
//       }
//     } catch (e) {
//       // Handle exceptions
//       print('Exception occurred while retrieving user data from SharedPreferences: $e');
//       return false; // Return false in case of error
//     }
//   }
// }

// import 'dart:async';
// import 'package:dspuiproject/services/home_page2.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../helper/session_manager/SessionController.dart';
// import '../services/BottomNavigationfooter/NavigationMenu.dart';
//
// class SplashService {
//   void isLogin(BuildContext context) {
//     // Check if user data exists in SharedPreferences
//     isLoginWithSharedPreferences().then((isLoggedIn) {
//       if (isLoggedIn) {
//         Timer(Duration(seconds: 3), () {
//           Get.offAll(() => NavigationMenu());
//         });
//       } else {
//         Timer(Duration(seconds: 3), () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => homepage2()),
//           );
//           Get.offAll(() => NavigationMenu());
//         });
//       }
//     }).catchError((error) {
//       print('Error occurred while checking login status: $error');
//     });
//   }
//
//   Future<bool> isLoginWithSharedPreferences() async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//
//       // Retrieve user data from SharedPreferences
//       final String? userId = prefs.getString('user_id');
//       // final String? userPath = prefs.getString('user_path');
//
//       if (userId != null) {
//         // User data found in SharedPreferences, set userId and return true
//         // SessionController().userId = userId;
//         print("user loggin succesfilly  true  ");
//         return true;
//       } else {
//         // No user data found in SharedPreferences, return false
//         print("user  not loggin false  ");
//         return false;
//       }
//     } catch (e) {
//       // Handle exceptions
//       print('Exception occurred while retrieving user data from SharedPreferences: $e');
//       return false; // Return false in case of error
//     }
//   }
// }

import 'dart:async';
import 'package:dspuiproject/services/UnoHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dspuiproject/services/home_page2.dart';
import '../SharedPreferecneService/SharedPreferenceSerivice.dart';
import '../helper/session_manager/SessionController.dart';
import '../services/BottomNavigationfooter/NavigationMenu.dart';

class SplashService {
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  FirebaseAuth _auth = FirebaseAuth.instance;

  void isLogin(BuildContext context) {

    final user =  _auth.currentUser;

    SessionController().userId=user?.uid.toString();
    // Check if user data exists in SharedPreferences
    _sharedPreferencesService.isUserLoggedIn().then((isLoggedIn) {
      if (isLoggedIn) {
        Timer(Duration(seconds: 3), () {
          Get.offAll(() => NavigationMenu());
        });
      } else {
        Timer(Duration(seconds: 3), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UnoHomePage()),
          );
          Get.offAll(() => NavigationMenu());
        });
      }
    }).catchError((error) {
      print('Error occurred while checking login status: $error');
    });
  }
}
