// import 'dart:async';
//
// // import 'package:dsp_app/home_page2.dart';
// // import 'package:dsp_app/service/phoneauth_service.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// import 'package:dspuiproject/services/home_page2.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:pin_code_text_field/pin_code_text_field.dart';
//
// //import 'home_page2.dart';
//
// class VerifyOtpScreen extends StatefulWidget {
//   final String number,verId;
//
//   VerifyOtpScreen(this.number,this.verId);
//   @override
//   _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
// }
//
// class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
//   int start = 30;
//   bool wait = false;
//   final _otpController = TextEditingController();
//   // PhoneAuthService _service = PhoneAuthService();
//
//   Future<void> phoneCredential(BuildContext context, String otp) async{
//     // FirebaseAuth _auth = FirebaseAuth.instance;
//     try{
//       // PhoneAuthCredential credential = PhoneAuthProvider.credential
//         (verificationId: widget.verId, smsCode: otp);
//
//       // final User? user = (await _auth.signInWithCredential(credential)).user;
//
//       if(mounted){
//         if(user!=null){
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => homepage()),
//           );
//         }else{
//           _showValidationToast(context, "Invalid OTP");
//           print('Login failed');
//         }
//       }
//
//     }catch(e){
//       print(e.toString());
//     }
//   }
//
//
//
//   @override
//   void initState() {
//     startTimer();
//     // TODO: implement initState
//     super.initState();
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               child: Lottie.asset(
//                 "assets/otpverification.json",
//                 height: 300.0,
//                 width: 250.0,
//               ),
//             ),
//             Stack(
//               children: [
//                 Center(
//                   child: Container(
//                     height: size.height * 0.45,
//                     decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.1),
//                           blurRadius: 10.0,
//                           spreadRadius: 0.0,
//                           offset: Offset(2.0, 5.0),
//                         ),
//                       ],
//                     ),
//                     child: Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       elevation: 10.0,
//                       margin: EdgeInsets.all(12.0),
//                       child: Column(
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(top: 40.0),
//                             padding: EdgeInsets.all(20.0),
//                             child: RichText(
//                               textAlign: TextAlign.center,
//                               text: TextSpan(
//                                 children: <TextSpan>[
//                                   TextSpan(
//                                     text: "Verification\n\n",
//                                     style: TextStyle(
//                                       fontSize: 22.0,
//                                       fontWeight: FontWeight.bold,
//                                       color: Color(0xFF0278AE),
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: "Enter the OTP send to your mobile number",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.normal,
//                                       color: Color(0xFF373A40),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Container(
//                               padding: EdgeInsets.all(12.0),
//                               child: PinCodeTextField(
//                                 maxLength: 6,
//                                 pinBoxWidth: 40,
//                                 pinBoxHeight: 40,
//                                 highlightAnimation: true,
//                                 controller: _otpController,
//                                 //  pinBoxBorderWidth: 1,
//                                 highlightAnimationDuration: Duration(milliseconds: 300),
//                               )
//                           ),
//
//                           RichText(
//                               text: TextSpan(
//                                 children: [
//                                   TextSpan(
//                                     text: "Send OTP again in ",
//                                     style: TextStyle(fontSize: 14, color: Color(0xFF0278AE)),
//                                   ),
//                                   TextSpan(
//                                     text: "00:$start",
//                                     style: TextStyle(fontSize: 14, color: Colors.black45),
//                                   ),
//                                   TextSpan(
//                                     text: " sec ",
//                                     style: TextStyle(fontSize: 14, color: Color(0xFF0278AE)),
//                                   ),
//                                 ],
//                               )),
//                           SizedBox(height: 8),
//                           GestureDetector(
//                             onTap: (){
//                               startTimer();
//                               setState(() {
//                                 start = 30;
//                               });
//                               //  _service.verifyPhoneNumber(context, widget.number);
//                             },
//                             child: Align(
//                                 alignment: Alignment.centerRight,
//                                 child:  Padding(
//                                   padding: const EdgeInsets.only(right: 12),
//                                   child: Text("RESEND OTP",
//                                     //textAlign: TextAlign.end,
//                                     style: TextStyle(fontSize: 14, color: Color(0xFF0278AE),fontWeight: FontWeight.bold),
//                                   ),
//                                 )
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//
//
//                 Center(
//                   child: Container(
//                     margin: EdgeInsets.only(top: size.height * 0.40),
//                     child: SizedBox(
//                       width: size.width * 0.5,
//                       height: 50.0,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           elevation: 10.0,
//                           primary: Color(0xFF4A90E2),
//                           // shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(100.0),
//                             side: BorderSide(color: Color(0xFF4A90E2)),
//                           ),
//                         ),
//
//                         onPressed:  () {
//                           print(_otpController.text);
//                          phoneCredential(context, _otpController.text);
//                           // Navigator.pushReplacement(
//                           //   context,
//                           //   MaterialPageRoute(builder: (context) => homepage()),
//                           // );
//                         },
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "Continue",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 17.0,
//                               ),
//                             ),
//                             Card(
//                               color: Color(0xCDA3C5EC),
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(35.0)),
//                               child: SizedBox(
//                                 width: 35.0,
//                                 height: 35.0,
//                                 child: Icon(
//                                   Icons.chevron_right,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void startTimer() {
//     const onsec = Duration(seconds: 1);
//     Timer _timer = Timer.periodic(onsec, (timer) {
//       if (start == 0) {
//         setState(() {
//           timer.cancel();
//           wait = false;
//         });
//       } else {
//         setState(() {
//           start--;
//         });
//       }
//     });
//   }
//
//
//   void _showValidationToast(BuildContext context, String text) {
//     final scaffold = ScaffoldMessenger.of(context);
//     scaffold.showSnackBar(
//       SnackBar(
//         content: new Text(text),
//         action: SnackBarAction(
//             label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
//       ),
//     );
//   }
//
// }
