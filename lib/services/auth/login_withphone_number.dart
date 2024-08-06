import 'package:country_code_picker/country_code_picker.dart';
import 'package:dspuiproject/constant/colors.dart';
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

  @override
  void initState() {
    // TODO: implement initState
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
      // Show Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Phone number cannot be more than 10 digits"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),

        ),
      );

      // Truncate the input to the first 10 digits
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
        SizedBox(height: 50,),
            Image.asset("assets/otpngg.png",
            width: 80,
              height: 150,

            ),
            Center(child: Text("Your phone ! ",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 6),
              child: Text(
                'We will send you a one-time password\non this mobile number',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

            ),
            SizedBox(height: 20,),
            PhoneText(),
            SizedBox(height: 50,),
            Button()

          ],
        ),
      ),
    );

  }

  Widget PhoneText(){
    return Padding(padding:EdgeInsets.symmetric(horizontal: 50),
    child: TextField(
controller: _phoneNumberController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefix: Text("+91 "),
        prefixIcon: Icon(Icons.phone),
        labelText: "enter phone number ",
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue
          )
        )

      ),
    ),
    );
  }

  Widget Button(){
    return Center(
     child:  ElevatedButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyCode(verificationId: '', phoneno: _phoneNumberController.text,)));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: iconcolor, // Button color
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
}
