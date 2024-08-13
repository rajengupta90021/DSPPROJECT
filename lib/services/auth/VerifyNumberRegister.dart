import 'package:dspuiproject/widgets/SnackBarUtils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../../SharedPreferecneService/SharedPreferenceSerivice.dart';
import '../../constant/colors.dart';
import '../../provider/controller/SignUpcontroller.dart';
import '../../repository/AuthRepository.dart';
import '../../services/BottomNavigationfooter/NavigationMenu.dart';

class VerifyNumberRegister extends StatefulWidget {
  final String verificationId;
  final String phoneno;
  final Map<dynamic, dynamic>? userData;

  const VerifyNumberRegister({Key? key, required this.verificationId, required this.phoneno ,this.userData}) : super(key: key);

  @override
  _VerifyNumberRegisterState createState() => _VerifyNumberRegisterState();
}


class _VerifyNumberRegisterState extends State<VerifyNumberRegister> {
  final TextEditingController _verificationCodeController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  String? _errorText;
  var code = "";
  bool _isLoading = false; // Flag to manage loading state
  UserRepository UserRepositoryy= UserRepository();
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                SizedBox(height: 50),
                Image.asset(
                  "assets/otpngg.png",
                  width: 80,
                  height: 150,
                ),
                Center(
                  child: Text(
                    "OTP verification!",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
                  child: Text(
                    'Enter the OTP sent to ${widget.phoneno}',
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
          if (_isLoading) // Show loading indicator if _isLoading is true
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget PhoneText() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Pinput(
          length: 6,
          showCursor: true,
          controller: _verificationCodeController,
          onChanged: (value) {
            setState(() {
              code = value;
              print("Code entered: $code");
            });
          },
          defaultPinTheme: PinTheme(
            width: 56,
            height: 56,
            textStyle: TextStyle(fontSize: 20, color: Colors.black),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black),
            ),
          ),
          focusedPinTheme: PinTheme(
            width: 56,
            height: 56,
            textStyle: TextStyle(fontSize: 20, color: Colors.black),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: iconcolor),
            ),
          ),
          submittedPinTheme: PinTheme(
            width: 56,
            height: 56,
            textStyle: TextStyle(fontSize: 20, color: Colors.black),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: iconcolor),
            ),
          ),
        ),
      ),
    );
  }

  Widget Button() {
    final provider = Provider.of<SignUpController>(context);
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          print("Entered OTP: ${_verificationCodeController.text}");
          setState(() {
            _isLoading = true; // Show loading indicator
          });

          final credential = PhoneAuthProvider.credential(
            verificationId: widget.verificationId,
            smsCode: _verificationCodeController.text.toString(),
          );
          print("Entered OTP: ${_verificationCodeController.text}");
          try {
            await _auth.signInWithCredential(credential);

            final updatedUserData = {
              ...widget.userData ?? {}, // Existing userData, or an empty map if null
              'mobile': widget.phoneno, // Updated phone number
            };
          var success   =    provider.signUpAndCreateUserOnAPI(context,updatedUserData);
            // final userData = await UserRepositoryy.loginwithphoneNumber(widget.phoneno);

            if ( await success) {

              // _sharedPreferencesService.saveUserData(userData);

              SnackBarUtils.showSuccessSnackBar(
                context,
                "register success successful",
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NavigationMenu()),
              );
            } else {
              SnackBarUtils.showErrorSnackBar(
                context,
                "register failed ",
              );
            }

          } catch (e) {
            _handleVerificationFailure(e);
          } finally {
            setState(() {
              _isLoading = false; // Hide loading indicator
            });
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: iconcolor,
          padding: EdgeInsets.all(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 90),
          child: Text(
            'Verify',
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
        default:
          print(" eroror  rrr  ${error}");
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
}
