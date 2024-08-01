import 'package:dspuiproject/services/home_page2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../services/BottomNavigationfooter/NavigationMenu.dart';
import '../../widgets/rounded_botton.dart';



class VerifyCode extends StatefulWidget {
  final String verificationId;

  const VerifyCode({Key? key, required this.verificationId}) : super(key: key);

  @override
  _VerifyCodeState createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final TextEditingController _verificationCodeController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 60),
                  child: Image.asset(
                    'assets/verifycode.jpg',
                    width: 150, // Adjust the width as needed
                    height: 150, // Adjust the height as needed
                  ),
                ),
                SizedBox(height: 50),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _verificationCodeController,
                  decoration: InputDecoration(
                    hintText: "Enter 6-digit verification code",
                    errorText: _errorText,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Verification code is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                roundedbotton(
                  title: "Verify",
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      _verifyCode();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _verifyCode() async {
    final credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: _verificationCodeController.text.toString(),
    );

    try {
      await _auth.signInWithCredential(credential);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationMenu()));
    } catch (e) {
      setState(() {
        _errorText = e.toString();
      });
    }
  }
  // void _verifyCode() async {
  //   final credential = PhoneAuthProvider.credential(
  //     verificationId: widget.verificationId,
  //     smsCode: _verificationCodeController.text.toString(),
  //   );
  //
  //   try {
  //     final UserCredential userCredential = await _auth.signInWithCredential(credential);
  //     final User user = userCredential.user!;
  //
  //     // Get user ID from SessionController
  //     final userId = SessionController().userId.toString();
  //
  //     // Get a reference to the user node in the Realtime Database
  //     final userRef = FirebaseDatabase.instance.reference().child('User').child(userId);
  //
  //     // Update user information in the Realtime Database
  //     userRef.set({
  //       'email': user.email,
  //       'phone': user.phoneNumber ?? "",
  //       'profile': "",
  //       'uid': userId,
  //       'username': 'USER', // Assuming this is the username
  //
  //        // Use an empty string if phone number is null
  //       // Assuming profile is empty for now
  //       // Add more fields as needed
  //     });
  //
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationMenu()));
  //   } catch (e) {
  //     setState(() {
  //       _errorText = e.toString();
  //     });
  //   }
  // }
}
