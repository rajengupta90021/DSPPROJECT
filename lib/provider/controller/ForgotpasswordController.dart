import 'package:dspuiproject/helper/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../services/BottomNavigationfooter/NavigationMenu.dart';
import '../../services/auth/login_screen.dart';

class ForgotPasswordController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void forgot(BuildContext context, String email) {
    setLoading(true);

    try {
      auth.sendPasswordResetEmail(email: email,).then((value) {


        setLoading(false);
        Utils().toastmessage("please check your email to recover your password !  ",Colors.green);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => loginscreen()));
      }).onError((error, stackTrace){
        setLoading(false);
        Utils().toastmessage("Some exception occurred", Colors.red);

      });

    } catch (e, stackTrace) {
      setLoading(false);
      Utils().toastmessage("Some exception occurred", Colors.red);
      print("Exception: $e\nStackTrace: $stackTrace");
    }
  }
}
