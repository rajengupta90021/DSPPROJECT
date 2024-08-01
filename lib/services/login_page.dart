// //import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// // import 'package:p2power_flutter_app/homePage/home_page2.dart';
// // import 'package:p2power_flutter_app/otpVerificationScreen/otp_verification_screen.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
//
// // import 'otp_verification_screen.dart';
// // import 'package:dsp_app/service/phoneauth_service.dart';
//
//
//
// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//
//
//   bool validate = false;
//   late String phoneNumber;
//
//
//
//   // phoneAuthentication(number){
//   //   print(number);
//   // }
//
//   // PhoneAuthService _service = PhoneAuthService();
//
//
//   showAlertDialog(BuildContext context){
//     AlertDialog alert = AlertDialog(
//       content: Row(
//         children: [
//           CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
//           ),
//           SizedBox(width: 8,),
//           Text('Please wait')
//         ],
//       ),
//     );
//     showDialog(
//         barrierDismissible: false,
//         context: context, builder: (BuildContext context){
//       return alert;
//     });
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//
//     // FirebaseAuth.instance
//     //     .authStateChanges()
//     //     .listen((user) {
//     //   if(user == null){
//     //     print('User is currently signed out!');
//     //   }else{
//     //     Navigator.pushReplacement(context,
//     //         MaterialPageRoute(builder: (context) => Homepage()));
//     //   }
//     // });
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               margin: EdgeInsets.only(top: size.height * 0.05),
//               child: Lottie.asset(
//                 "assets/opt.json",
//                 height: size.height * 0.4,
//                 alignment: Alignment.bottomCenter,
//               ),
//             ),
//             Stack(
//               children: [
//                 Container(
//                   height: size.height * 0.45,
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.1),
//                         blurRadius: 10.0,
//                         spreadRadius: 0.0,
//                         offset: Offset(2.0, 5.0),
//                       ),
//                     ],
//                   ),
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15.0),
//                     ),
//                     elevation: 10.0,
//                     margin: EdgeInsets.all(12.0),
//                     child: Container(
//                       padding: EdgeInsets.all(20.0),
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: RichText(
//                               textAlign: TextAlign.center,
//                               text: TextSpan(
//                                 style: TextStyle(
//                                   fontSize: 13.0,
//                                   color: Colors.black,
//                                   letterSpacing: 0.5,
//                                 ),
//                                 children: <TextSpan>[
//                                   TextSpan(
//                                     text: "Login with mobile number\n\n\n",
//                                     style: TextStyle(
//                                       fontSize: 22.0,
//                                       fontWeight: FontWeight.bold,
//                                       color: Color(0xFF0278AE),
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: "We will send you an",
//                                     style: TextStyle(
//                                       color: Color(0xFF373A40),
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: " One Time Password (OTP) ",
//                                     style: TextStyle(
//                                       color: Color(0xFF373A40),
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   TextSpan(text: "on this mobile number"),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Container(
//                               //height: 29,
//                               margin: EdgeInsets.only(top: size.height * 0.045),
//                               child: Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: IntlPhoneField(
//                                     decoration: InputDecoration(
//                                       labelText: 'Phone Number',
//                                       border: OutlineInputBorder(
//                                         borderSide: BorderSide(),
//                                       ),
//                                     ),
//                                     initialCountryCode: 'IN',
//                                     autoValidate: true,
//                                     onChanged: (phone) {
//                                       if(phone.completeNumber.length == 13)
//                                       {
//                                         setState(() {
//                                           phoneNumber = phone.completeNumber;
//                                           validate = true;
//                                         });
//                                       }else{
//                                         setState(() {
//                                           validate = false;
//                                         });
//                                       }
//                                       print(phone.completeNumber);
//
//                                     },
//                                   )
//
//
//                               ),
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
//                       child: AbsorbPointer(
//                         absorbing: validate ? false: true,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             elevation: 10.0,
//                             // primary: validate ?Color(0xFF4A90E2):Colors.grey,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(100.0),
//                               side: BorderSide(color: Color(0xFF4A90E2)),
//                             ),
//                           ),
//
//                           onPressed:  () {
//                            // phoneAuthentication(phoneNumber);
//                             showAlertDialog(context);
//                             // _service.verifyPhoneNumber(context, phoneNumber);
//                             // Navigator.push(
//                             //   // context,
//                             //   // MaterialPageRoute(builder: (context) => VerifyOtpScreen("","")),
//                             // );
//                           },
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Next",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 17.0,
//                                 ),
//                               ),
//                               Card(
//                                 color: Color(0xCDA3C5EC),
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(35.0)),
//                                 child: SizedBox(
//                                   width: 35.0,
//                                   height: 35.0,
//                                   child: Icon(
//                                     Icons.chevron_right,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }