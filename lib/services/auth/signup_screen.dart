import 'package:dspuiproject/Model/UserInfo.dart';
import 'package:dspuiproject/constant/colors.dart';
import 'package:dspuiproject/services/auth/VerifyNumberRegister.dart';
import 'package:dspuiproject/services/auth/verifynumber.dart';
import 'package:dspuiproject/services/home_page2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart';
import 'package:provider/provider.dart';


import '../../provider/controller/SignUpcontroller.dart';
import '../../repository/AuthRepository.dart';
import '../../services/BottomNavigationfooter/NavigationMenu.dart';
import '../../helper/utils.dart';
import '../../widgets/SnackBarUtils.dart';
import '../../widgets/rounded_botton.dart';

import 'login_screen.dart';

class signupscreen extends StatefulWidget {
  const signupscreen({super.key});

  @override
  State<signupscreen> createState() => _signupscreenState();
}

class _signupscreenState extends State<signupscreen> {

  final  usernamecontroller = TextEditingController();
  final  emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  String _countryCode = '+91';

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


  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      // appBar: AppBar(
      //
      //   title: Text("sign up  screen"),
      //
      // ),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ChangeNotifierProvider(
            create: (_)=>SignUpController(),
            child:Consumer<SignUpController>(
              builder: (context, provider ,child){
                return SingleChildScrollView(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      SizedBox(height: 30,),
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Image.asset(
                          'assets/loginpng.png',
                          width: 220,
                          height: 220,
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
                              controller:  usernamecontroller,
                              decoration: buildInputDecoration(
                                hintText: "username",
                                prefixIcon: Icons.supervised_user_circle,
                                iconColor: iconcolor,
                              ),

                              validator: (value){
                                if(value!.isEmpty){
                                  return "enter username ";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20,),
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

                                // Regular expression to validate email format
                                RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                                if (!emailRegex.hasMatch(value)) {
                                  return "Please enter a valid email address";
                                }

                                return null;
                              },
                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller:  passwordcontroller,
                              obscureText: true,
                              decoration: buildInputDecoration(
                                hintText: "paswword",
                                prefixIcon: Icons.password_rounded,
                                iconColor: iconcolor,
                              ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return "enter password ";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 50,),

                          ],
                        ),
                      ),

                      roundedbotton(title: "sign up ",
                        loading: provider.loading,
                        onTap: () async {

                          if(formkey.currentState!.validate()){

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
                            var userData = {
                              'name': usernamecontroller.text.toString(),
                              'email': emailcontroller.text.toString(),
                              'password': passwordcontroller.text.toString(),
                              'mobile': phonecontroller.text.trim(), // You can add user mobile number here if needed
                              // 'role': '', // Assuming default role is 'User'
                            };
                            _showOtpDialog(context,userData);
                            // provider.signUpAndCreateUserOnAPI(context,userData);


                            // provider.signup(context,usernamecontroller.text, emailcontroller.text, passwordcontroller.text);
                          }

                        },),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("already  have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginscreen()));

                              // Add your navigation logic here
                            },
                            child: Text("login "),
                          ),
                        ],
                      )

                    ],
                  ),
                );
              },
            ) ,
          ),
        ),
      ),
    );
  }
  void _showOtpDialog(BuildContext context,Map<dynamic, dynamic> userData) {
    final _formKey = GlobalKey<FormState>();
    final _phoneController = TextEditingController();
    Navigator.pop(context);
    // final _phoneController = TextEditingController(text: userData['mobile'] ?? '');
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            height: 290,
            width: 550,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 35), // Padding from the left edge
                      Expanded(
                        child: Text(
                          "Phone Authentication",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "+5678596423",
                        labelText: "Enter your phone number",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your phone number";
                        }
                        // Basic phone number validation
                        RegExp phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
                        if (!phoneRegex.hasMatch(value)) {
                          return "Please enter a valid phone number";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: iconcolor),
                    onPressed: () async {

                      if (_formKey.currentState!.validate()) {

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
                        Navigator.pop(context);
                        // Handle sending OTP here
                        // final phoneNumber = _phoneController.text;
                        final phoneNumber = _countryCode + _phoneController.text.trim();
                        // Print phone number from controller and userData
                        print("Phone number from controller: $phoneNumber");

                        _auth.verifyPhoneNumber(
                          phoneNumber: phoneNumber,
                          verificationCompleted: (PhoneAuthCredential credential) {
                            SnackBarUtils.showSuccessSnackBar(
                              context,
                              "Verification completed automatically",
                            );

                          },
                          verificationFailed: (FirebaseAuthException e) {

                            _handleVerificationFailure(e);
                            print("Verification failed: ${e.message}");

                          },
                          codeSent: (String verificationId, int? forceResendingToken) {
                            Navigator.pop(context);
                             Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VerifyNumberRegister(
                                    verificationId: verificationId,
                                   phoneno: _phoneController.text.trim(),
                                    userData: userData,
                                ),
                              ),
                            );

                          },
                          codeAutoRetrievalTimeout: (String verificationId) {

                            SnackBarUtils.showInfoSnackBar(
                              context,
                              "Auto-retrieval timeout",
                            );
                            print("Auto-retrieval timeout");

                          },
                        );

                      }
                    },
                    child: Text(
                      "Send OTP",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
}
