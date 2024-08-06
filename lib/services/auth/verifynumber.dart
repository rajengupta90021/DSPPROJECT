import 'package:dspuiproject/services/home_page2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../../constant/colors.dart';
import '../../services/BottomNavigationfooter/NavigationMenu.dart';
import '../../widgets/rounded_botton.dart';



class VerifyCode extends StatefulWidget {
  final String verificationId;
  final String phoneno;

  const VerifyCode({Key? key, required this.verificationId,required this.phoneno}) : super(key: key);

  @override
  _VerifyCodeState createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final TextEditingController _verificationCodeController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  String? _errorText;
    var code="";
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
            Center(child: Text("OTP verification  ! ",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 6),
              child: Text(
                'Enter the otp sent to ${widget.phoneno}',
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Pinput(
          length: 6,
          showCursor: true, // Show cursor in the input fields
          onChanged: (value) {
            setState(() {
              code = value; // Update the code value on change
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



  Widget Button(){
    return Center(
      child:  ElevatedButton(
        onPressed: () {
          // Add your onPressed code here!

        },
        style: ElevatedButton.styleFrom(
          backgroundColor: iconcolor, // Button color
          padding: EdgeInsets.all(16.0),

        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 90),
          child: Text(
            ' Verify',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
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
