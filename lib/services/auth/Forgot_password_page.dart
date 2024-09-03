import 'package:dspuiproject/constant/colors.dart';
import 'package:dspuiproject/widgets/SnackBarUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helper/utils.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    // if (_formKey.currentState?.validate() ?? false) {
    //   final email = _emailController.text.trim();
    //   final phone = _phoneController.text.trim();
    //
    //   if (email.isNotEmpty) {
    //     print('Email: $email');
    //   }
    //   if (phone.isNotEmpty) {
    //     print('Phone: $phone');
    //   }


      SnackBarUtils.showInfoSnackBar(context, "working on it ");

      // You can navigate to another page if needed
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => SuccessPage()),
      // );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text('Forgot Password',style: TextStyle(fontWeight: FontWeight.bold),),
      //   backgroundColor: iconcolor,
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 100,),
                Icon(
                  Icons.lock_reset,
                  size: 100,
                  color: iconcolor,
                ),
                SizedBox(height: 10),
                Text(
                  'Reset Your Password',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Enter your email or phone number to receive a password reset link.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: buildInputDecoration(
                    hintText: "Email",
                    prefixIcon: Icons.alternate_email,
                    iconColor: iconcolor,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      // Utils.flushBarErrorMessage(
                      //   "Enter email",
                      //   Colors.red,
                      //   context,
                      // );
                      return "Enter email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey[400],
                        thickness: 1,
                        endIndent: 10,
                      ),
                    ),
                    Text(
                      'or',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey[400],
                        thickness: 1,
                        indent: 10,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _phoneController,
                  decoration: buildInputDecoration(
                    hintText: "phone",
                    prefixIcon: Icons.password_rounded,
                    iconColor: iconcolor,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {

                      return "Enter phone";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _submit,
                  child: Text('Submit',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: iconcolor,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
