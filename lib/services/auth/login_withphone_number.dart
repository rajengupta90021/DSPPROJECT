import 'package:country_code_picker/country_code_picker.dart';
import 'package:dspuiproject/services/auth/verifynumber.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../../helper/utils.dart';
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

  String _selectedCountryCode = '+91'; // Default country code

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login with Phone Number"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),

        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 60),
                child: Image.asset(
                  'assets/loginwithphonenumber.png',
                  width: 150, // Adjust the width as needed
                  height: 150, // Adjust the height as needed
                ),
              ),
              SizedBox(height: 50),
          
              Row(
                children: [
                  CountryCodePicker(
                    onChanged: (CountryCode countryCode) {
                      setState(() {
                        _selectedCountryCode = countryCode.toString();
                      });
                    },
                    initialSelection: 'IN', // Initial country code
                    favorite: ['+91'], // Your favorite country codes
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    alignLeft: false,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: _phoneNumberController,
                            decoration: InputDecoration(
                              hintText: "Enter your phone number",
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return "Enter phone number";
                              }
                              return null;
                            },
                          ),
                          if (_errorText != null)
                            Text(
                              _errorText!,
                              style: TextStyle(color: Colors.red),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              roundedbotton(
                title: "Login",
                onTap: () {
                  if (formkey.currentState!.validate()) {
                    _startPhoneNumberVerification();
                  }
                },
                loading: loading,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startPhoneNumberVerification() {
    setState(() {
      loading = true;
    });
    String phoneNumber = _selectedCountryCode + _phoneNumberController.text.trim();
    _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (_) {},
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          _errorText = e.message ?? 'Verification failed';
          loading = false;
        });
      },
      codeSent: (String verificationId, int? token) {
        setState(() {
          _errorText = null;
          loading = false;
        });

        Fluttertoast.showToast(
          msg: 'We have sent an OTP for verification.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VerifyCode(verificationId: verificationId)),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        Utils().toastmessage('Verification timed out',Colors.red);
        setState(() {
          loading = false;
        });
      },
    );
  }
}
