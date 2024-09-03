import 'package:dspuiproject/Model/UserInfo.dart';
import 'package:dspuiproject/constant/colors.dart';
import 'package:dspuiproject/helper/LocationService.dart';
import 'package:dspuiproject/services/auth/VerifyNumberRegister.dart';
import 'package:dspuiproject/services/auth/verifynumber.dart';
import 'package:dspuiproject/services/home_page2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../provider/controller/SignUpcontroller.dart';
import '../../repository/AuthRepository.dart';
import '../../services/BottomNavigationfooter/NavigationMenu.dart';
import '../../helper/utils.dart';
import '../../widgets/LoadingOverlay.dart';
import '../../widgets/SnackBarUtils.dart';
import '../../widgets/rounded_botton.dart';

import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final  usernamecontroller = TextEditingController();
  final  emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final otpcontroller = TextEditingController();
  bool isotpsent =false;
  String _verificationId = '';
  final formkey = GlobalKey<FormState>();
  String _countryCode = '+91';
  var code = "";
  bool loading = false;

  List<UserData> userdata= [];


  FirebaseAuth _auth= FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    phonecontroller.dispose();
  }
  late SignUpController provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    provider = Provider.of<SignUpController>(context);
  }
  Future<void> _verifyPhoneNumber() async {
    setState(() {
      loading = true; // Set loading to true
    });

    final phoneNumber = _countryCode + phonecontroller.text.trim();

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        SnackBarUtils.showSuccessSnackBar(context, "Verification completed automatically");
        setState(() {
          loading = false; // Set loading to false
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        _handleVerificationFailure(e);
        setState(() {
          isotpsent = false;
          loading = false; // Set loading to false
        });
      },
      codeSent: (String verificationId, int? forceResendingToken) async {
        setState(() {
          _verificationId = verificationId;
          isotpsent = true;
          loading = false; // Set loading to false
        });
        SnackBarUtils.showSuccessSnackBar(context, "OTP has been sent to your phone");
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          _verificationId = verificationId;
          isotpsent = false;
          loading = false; // Set loading to false
        });
        SnackBarUtils.showInfoSnackBar(context, "Auto-retrieval timeout");
      },
    );
  }

  Future<void> _signInWithOTP() async {
    setState(() {
      loading = true; // Set loading to true
    });

    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: otpcontroller.text.trim(),
    );

    try {
      await _auth.signInWithCredential(credential);
      var userData = {
        'name': usernamecontroller.text.trim(),
        'email': emailcontroller.text.trim(),
        'password': passwordcontroller.text.trim(),
        'mobile': phonecontroller.text.trim(),
      };
      bool success = await provider.signUpAndCreateUserOnAPI(context, userData);

      if (success) {
        await _fetchAndStoreLocation();
        SnackBarUtils.showSuccessSnackBar(context, "Registration successful");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavigationMenu()), // Replace with your next screen
        );
      } else {
        SnackBarUtils.showErrorSnackBar(context, "Registration failed");
      }
    } catch (e) {
      _handleVerificationFailure(e);
    } finally {
      setState(() {
        loading = false; // Set loading to false
      });
    }
  }
  Future<void> _fetchAndStoreLocation() async {
   setState(() {
     loading= true;
   });
    LocationService locationService = LocationService();

    // Call checkPermission with a callback
    await locationService.checkPermission((coordinates, address) async {
      // Extract latitude and longitude from coordinates
      List<String> parts = coordinates.split('\n');
      String latPart = parts[0].replaceAll('Latitude: ', '');
      String lonPart = parts[1].replaceAll('Longitude: ', '');


      // Save latitude and longitude to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('latitude', latPart);
      await prefs.setString('longitude', lonPart);
      await prefs.setString('address', address);


      // Optionally, you can print the saved data for debugging purposes
      print("Saved Latitude: $latPart");
      print("Saved Longitude: $lonPart");
      print("Saved Address: $address");
     setState(() {
       loading=false;
     }); // Stop loading
    });
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ChangeNotifierProvider(
                create: (_) => SignUpController(),
                child: Consumer<SignUpController>(
                  builder: (context, provider, child) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 25),
                          Container(
                            margin: EdgeInsets.only(top: 50),
                            child: Image.asset(
                              'assets/loginpng.png',
                              width: 190,
                              height: 190,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 20),
                          Form(
                            key: formkey,
                            child: Column(
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: usernamecontroller,
                                  decoration: buildInputDecoration(
                                    hintText: "username",
                                    prefixIcon: Icons.supervised_user_circle,
                                    iconColor: iconcolor,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "enter username";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  controller: emailcontroller,
                                  decoration: buildInputDecoration(
                                    hintText: "email",
                                    prefixIcon: Icons.alternate_email,
                                    iconColor: iconcolor,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter an email address";
                                    }
                                    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                    if (!emailRegex.hasMatch(value)) {
                                      return "Please enter a valid email address";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: passwordcontroller,
                                  obscureText: true,
                                  decoration: buildInputDecoration(
                                    hintText: "password",
                                    prefixIcon: Icons.password_rounded,
                                    iconColor: iconcolor,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "enter password";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  keyboardType: TextInputType.phone,
                                  controller: phonecontroller,
                                  decoration: buildInputDecoration(
                                    hintText: "Phone Number",
                                    prefixIcon: Icons.phone,
                                    iconColor: iconcolor,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your phone number";
                                    }
                                    RegExp phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
                                    if (!phoneRegex.hasMatch(value)) {
                                      return "Please enter a valid phone number";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10),
                                if (isotpsent) PhoneText(),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                          roundedbotton(
                            title: isotpsent ? "Verify OTP" : "Sign Up",

                            onTap: () async {
                              if (formkey.currentState!.validate()) {
                                if (isotpsent) {
                                  if (otpcontroller.text.trim().isEmpty) {
                                    SnackBarUtils.showErrorSnackBar(context, "Please enter the OTP");
                                  } else {
                                    await _signInWithOTP();
                                  }
                                } else {
                                  await _verifyPhoneNumber();
                                }
                              }
                            },
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("already have an account?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => loginscreen()));
                                },
                                child: Text("login"),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          LoadingOverlay(isLoading: loading),
        ],
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

  Widget PhoneText() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Pinput(
          length: 6,
          showCursor: true,
          controller: otpcontroller,
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
}



