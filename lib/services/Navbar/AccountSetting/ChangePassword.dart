import 'package:dspuiproject/constant/colors.dart';
import 'package:dspuiproject/helper/utils.dart';
import 'package:dspuiproject/widgets/SnackBarUtils.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController _mobileController = TextEditingController();

  void _verifyMobileNumber() {
    String mobileNumber = _mobileController.text.trim();
    // if (mobileNumber.isNotEmpty) {
    //   print('Verifying mobile number: $mobileNumber');
    //   Utils().toastmessage('Verifying mobile number: $mobileNumber', Colors.green);
    // } else {
    //   print('Please enter a valid mobile number');
    //   Utils().toastmessage('Please enter a valid mobile number', Colors.red);
    // }
    SnackBarUtils.shownormalSnackBar(context, "working on it ");
  }

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Centered Image with Back Button
              Container(
                alignment: Alignment.center,
                height: 200, // Adjust height as needed
                color: Colors.white,
                child: Stack(
                  children: [

                    Center(
                      child: Image.asset(
                        'assets/logo.jpg', // Path to your image asset
                        width: 110, // Adjust width as needed
                        height: 110, // Adjust height as needed
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Text: Welcome to DSP
              Text(
                'Welcome to DSP',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              // Text: Please enter your registered mobile number for verification purpose
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Please enter your registered mobile number for verification purpose',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Text field for mobile number
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Enter mobile number',
                    labelText: 'Mobile Number', // Optional label text
                    prefixIcon: Icon(Icons.phone), // Icon before the input field
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey), // Border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.blue), // Focused border color
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0), // Padding around text field content
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Verify button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                  onPressed: _verifyMobileNumber,
                  child: Text('Verify'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: iconcolor,
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Circular Back Button
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    iconSize: 40,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
