import 'package:dspuiproject/repository/AuthRepository.dart';
import 'package:dspuiproject/helper/utils.dart';
import 'package:dspuiproject/services/UnoHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Model/UserInfo.dart';
import '../../SharedPreferecneService/SharedPreferenceSerivice.dart';
import '../../helper/session_manager/SessionController.dart';
import '../../services/BottomNavigationfooter/NavigationMenu.dart';

class SignUpController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('User');
  final UserRepository _userRepository = UserRepository();
  bool _loading = false;
  bool get loading => _loading;
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
  Future<bool> signUpAndCreateUserOnAPI(BuildContext context, Map<dynamic, dynamic> userData) async {
    try {


      print("Password is ${userData['password']}");

      userData.forEach((key, value) {
        print("$key: $value");
      });
      UserData? result = await UserRepository.createUserOnAPI(userData); // Await the result

      if (result != null) {
        print("from sign up controller  ${result.data?.name}");
        print("${result.data?.email}");
        print("${result.data?.password}");
        print("${result.data?.role}");
        print("${result.data?.mobile}");

        _sharedPreferencesService.saveUserData(result);
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigationMenu()));
        print("Added to database API success: $result");
        return true ;

      } else {
        print("Failed to add to database API");
        return false;
      }
    } catch (error) {
      Utils().toastmessage(error.toString(), Colors.red);
      print("Error: $error");
      return false;
    }
  }

  Future<void> updateUserData({
     String? fullName,
     String? email,
     String? mobileNumber,
     String? profile_img,
    // Add other fields as needed
  }) async {
    setLoading(true);

    try {

      print("full name $fullName");
      print("full name $email");
      print("full name $mobileNumber");

      // Fetch current user ID from Firebase Auth
      // Replace with your method to get current user ID

      // Call UserRepository to update user data
      UserData? result =   await _userRepository.updateUser(
        fullName: fullName,
        email: email,
        mobileNumber: mobileNumber,

        // Add other fields as needed
      );
      notifyListeners();
  if(result != null){

    print("result is ${result.data?.name}");
    _sharedPreferencesService.saveUserData(result);
    setLoading(false);
    Fluttertoast.showToast( backgroundColor: Colors.green,msg: 'User data updated successfully');


  }else{
    Fluttertoast.showToast( backgroundColor: Colors.red,msg: 'User data not updated');

  }
      } catch (error) {
      setLoading(false);
      Fluttertoast.showToast(msg: 'Failed to update user data: $error');
    }
  }

}

