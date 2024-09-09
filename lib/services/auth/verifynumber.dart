import 'dart:async'; // Import for Timer
import 'package:dspuiproject/helper/LocationService.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pinput.dart';
import '../../SharedPreferecneService/SharedPreferenceSerivice.dart';
import '../../constant/colors.dart';
import '../../repository/AuthRepository.dart';
import '../../services/BottomNavigationfooter/NavigationMenu.dart';
import '../../widgets/LoadingOverlay.dart';
import '../../widgets/SnackBarUtils.dart';

class VerifyCode extends StatefulWidget {
   final String verificationId;
  final String phoneno;

  const VerifyCode({Key? key, required this.verificationId, required this.phoneno}) : super(key: key);

  @override
  _VerifyCodeState createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final TextEditingController _verificationCodeController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  String? _errorText;
  var code = "";
  bool _isLoading = false; // Flag to manage loading state
  bool _isOtpExpired = false; // Flag to check OTP expiration
  UserRepository UserRepositoryy = UserRepository();
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  late Timer _timer;
  int _remainingTime = 30; // 60 seconds for the countdown

  @override
  void initState() {
    super.initState();
    _startTimer(); // Start the timer when the widget is initialized
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _startTimer() {
    _remainingTime = 30; // Reset the timer
    _isOtpExpired = false; // Reset OTP expired flag
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
        setState(() {
          _isOtpExpired = true; // Mark OTP as expired
        });
      }
    });
  }

  void _resendOtp() async {
    // Function to resend OTP
    setState(() {
      _isLoading = true; // Show loading indicator while resending OTP
    });

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+91 ${widget.phoneno}",
        verificationCompleted: (PhoneAuthCredential credential) {
          // Automatically handled by Firebase in the background
        },
        verificationFailed: (FirebaseAuthException e) {
          SnackBarUtils.showErrorSnackBar(
            context,
            "Failed to resend OTP: ${e.message}",
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            // widget.verificationId = verificationId; // Update verificationId with new one
            _isOtpExpired = false; // Reset OTP expired flag
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-retrieval timeout handler
          _isLoading = false;
          SnackBarUtils.showInfoSnackBar(context, "Auto-retrieval timeout");
        },
      );

      _startTimer(); // Restart timer after resending OTP

    } catch (e) {
      SnackBarUtils.showErrorSnackBar(
        context,
        "An error occurred while resending OTP: ${e.toString()}",
      );
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
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
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          if (_isOtpExpired) {
            SnackBarUtils.showErrorSnackBar(
              context,
              "OTP has expired. Please request a new one.",
            );
            return;
          }

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

            final userData = await UserRepositoryy.loginwithphoneNumber(widget.phoneno);

            if (userData != null) {
              _sharedPreferencesService.saveUserData(userData);
              await _fetchAndStoreLocation();

              SnackBarUtils.showSuccessSnackBar(
                context,
                "Login successful",
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NavigationMenu()),
              );
            } else {
              SnackBarUtils.showErrorSnackBar(
                context,
                "Please Register yourself then login with phone number",
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

  Future<void> _fetchAndStoreLocation() async {

    setState(() {
      _isLoading = true; // Hide loading indicator
    });
    LocationService locationService = LocationService();

    // Call checkPermission with a callback
    await locationService.checkPermission((coordinates, address) async {
      // Extract latitude and longitude from coordinates
      List<String> parts = coordinates.split('\n');
      String latPart = parts[0].replaceAll('Latitude: ', '');
      String lonPart = parts[1].replaceAll('Longitude: ', '');
      // Save latitude and longitude to SharedPreferences
      await _sharedPreferencesService.saveLocationData(latPart, lonPart, address);
      print("Saved Latitude: $latPart");
      print("Saved Longitude: $lonPart");
      print("Saved Address: $address");
      setState(() {
        _isLoading = false; // Hide loading indicator
      }); // Stop loading
    });
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
          print("Error: ${error}");
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
                SizedBox(height: 20),
                Center(
                  child: Text(
                    _isOtpExpired
                        ? 'OTP has expired. You can request a new one.'
                        : 'Time remaining: $_remainingTime seconds',
                    style: TextStyle(fontSize: 16, color: _isOtpExpired ? Colors.red : Colors.grey),
                  ),
                ),
                if (_isOtpExpired) // Show resend OTP button if OTP is expired
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: _resendOtp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: iconcolor,
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        ),
                        child: Text(
                          'Resend OTP',
                          style: TextStyle(color: Colors.black, fontSize: 16,),
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 20),
                Button(),
              ],
            ),
          ),
          LoadingOverlay(isLoading: _isLoading), // Use the LoadingOverlay widget
        ],
      ),
    );
  }
}
