import 'package:country_code_picker/country_code_picker.dart';
import 'package:dspuiproject/constant/colors.dart';
import 'package:dspuiproject/services/auth/verifynumber.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../helper/utils.dart';
import '../../widgets/SnackBarUtils.dart';
import '../../widgets/rounded_botton.dart';

class loginwithphonenumber extends StatefulWidget {
  const loginwithphonenumber({Key? key}) : super(key: key);

  @override
  _loginwithphonenumberState createState() => _loginwithphonenumberState();
}

class _loginwithphonenumberState extends State<loginwithphonenumber> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();
  String? _errorText;
  bool loading = false;
  String _countryCode = '+91';

  @override
  void initState() {
    super.initState();
    _phoneNumberController.addListener(_validatePhoneNumber);
  }

  @override
  void dispose() {
    _phoneNumberController.removeListener(_validatePhoneNumber);
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _validatePhoneNumber() {
    String text = _phoneNumberController.text;
    if (text.length > 10) {
      SnackBarUtils.showErrorSnackBar(
        context,
        "Phone number cannot be more than 10 digits",
      );

      _phoneNumberController.text = text.substring(0, 10);
      _phoneNumberController.selection = TextSelection.fromPosition(
        TextPosition(offset: _phoneNumberController.text.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(height: 90),
            Image.asset(
              "assets/otpngg.png",
              width: 80,
              height: 150,
            ),
            Center(
              child: Text(
                "Your phone ! ",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
              child: Text(
                'We will send you a one-time password\non this mobile number',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 20),
            PhoneText(),
            SizedBox(height: 50),
            Button(),
          ],
        ),
      ),
    );
  }

  Widget PhoneText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: _phoneNumberController,
        keyboardType: TextInputType.number,
        // decoration: InputDecoration(
        //   prefix: Text("+91 "),
        //   prefixIcon: Icon(Icons.phone),
        //   labelText: "enter phone number ",
        //   hintStyle: TextStyle(color: Colors.grey),
        //   labelStyle: TextStyle(color: Colors.grey),
        //   enabledBorder: UnderlineInputBorder(
        //     borderSide: BorderSide(color: Colors.black),
        //   ),
        //   focusedBorder: UnderlineInputBorder(
        //     borderSide: BorderSide(
        //       color: Colors.blue,
        //     ),
        //   ),
        // ),
        decoration: buildInputDecoration(
          hintText: "+91 ",
          prefixIcon: Icons.phone,
          iconColor: iconcolor,
        ),
      ),
    );
  }

  Widget Button() {
    return Center(
      child: ElevatedButton(
        onPressed: () async {

          showDialog(
            context: context,
            barrierDismissible: false, // Prevent dismiss on tap outside
            builder: (BuildContext context) {
              return Center(
                child: CircularProgressIndicator(), // Loading indicator
              );
            },
          );
          await Future.delayed(Duration(seconds: 2));
          // final phoneNumber = '$_countryCode${_phoneNumberController.text.trim()}';
          // String phoneNumber = _countryCode + _phoneNumberController.text.trim();
          final phoneNumber = _countryCode + _phoneNumberController.text.trim();
          if (phoneNumber.isEmpty) {
            Navigator.pop(context);
            SnackBarUtils.showErrorSnackBar(
              context,
              "Please enter a phone number",
            );
            return;
          }

          if (phoneNumber.length < 10) {
            Navigator.pop(context);
            SnackBarUtils.showErrorSnackBar(
              context,
              "Please enter a valid phone number",
            );
            return;
          }
          _auth.verifyPhoneNumber(
            phoneNumber: phoneNumber,
            verificationCompleted: (PhoneAuthCredential credential) {
                SnackBarUtils.showSuccessSnackBar(
                  context,
                  "Verification completed automatically",
                );

            },
            verificationFailed: (FirebaseAuthException e) {
              Navigator.pop(context);
                _handleVerificationFailure(e);
                print("Verification failed: ${e.message}");

            },
            codeSent: (String verificationId, int? forceResendingToken) {
              Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VerifyCode(
                      verificationId: verificationId,
                      phoneno: _phoneNumberController.text.trim(),
                    ),
                  ),
                );

            },
            codeAutoRetrievalTimeout: (String verificationId) {
              Navigator.pop(context);
                SnackBarUtils.showInfoSnackBar(
                  context,
                  "Auto-retrieval timeout",
                );
                print("Auto-retrieval timeout");

            },
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: iconcolor,
          padding: EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 90),
          child: Text(
            'Receive OTP',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  void _handleVerificationFailure(Object error) {
    String message;

    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-verification-code':
          message = "The verification code entered is invalid.";
          break;
        case 'session-expired':
          message = "The session has expired. Please request a new verification code.";
          break;
        case 'quota-exceeded':
          message = "Quota exceeded. Please try again later.";
          break;
        case 'invalid-phone-number':
          message = "The phone number provided is invalid.";
          break;
        case 'too-many-requests':
          message = "We have blocked all requests from this device due to unusual activity. Please try again later.";
          break;
        default:
          message = "An unknown error occurred. Please try again.";
      }
    } else {
      message = "An unexpected error occurred: ${error.toString()}";
    }


      SnackBarUtils.showErrorSnackBar(
        context,
        message,
      );



  }
  InputDecoration buildInputDecoration({
    required String hintText,
    required IconData prefixIcon,
    required Color iconColor,
  }) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0), // Padding inside the field
      hintText: hintText,
      labelText: "enter phone number ",
      hintStyle: TextStyle(color: Colors.grey[600]), // Hint text style
      prefixIcon: Icon(prefixIcon, color: Colors.black), // Icon with color
      // Background color
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
        borderSide: BorderSide.none, // No border by default
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
        borderSide: BorderSide(color: Colors.black, width: 1.0), // Light border when enabled
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
        borderSide: BorderSide(color: iconcolor, width: 2.0), // Thicker border when focused
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
        borderSide: BorderSide(color: Colors.red, width: 1.0), // Red border for errors
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
        borderSide: BorderSide(color: Colors.red, width: 2.0), // Thicker red border when focused on error
      ),
    );
  }
}
