// import 'dart:async';
// import 'package:dspuiproject/services/home_page2.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../firebase_service/splash_service.dart';
// import 'BottomNavigationfooter/NavigationMenu.dart';
//
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//
//
//   SplashService splashscreen= SplashService();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     setTimeout();
//     splashscreen.isLogin(context);
//     //getPackageInfo();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//             gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomLeft,
//                 stops: [
//                   0.1,
//                   1
//                 ],
//                 colors: [
//                   new Color(0xffC57248),
//                   new Color(0xffffffff),
//                 ])),
//         child: Stack(
//           //  new Color(0xff3ec7fd),new Color(0xff29dfb7)
//           children: [
//             Center(
//               child: Container(
//                 height: 170,
//                 width: 250,
//                 child: Center(child: Image.asset('assets/logo.jpg')),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void setTimeout() {
//     Timer(
//         const Duration(seconds: 3),
//             () {
//           // Navigator.of(context).pushReplacement(
//           //     MaterialPageRoute(builder: (context) => NavigationMenu()));
//           Get.offAll(() => NavigationMenu());
//         }
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../firebase_service/splash_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashService splashService = SplashService();

  @override
  void initState() {
    super.initState();
    splashService.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
            stops: [0.1, 1],
            colors: [Color(0xffC57248), Colors.white],
          ),
        ),
        child: Center(
          child: Container(
            height: 170,
            width: 250,
            child: Center(child: Image.asset('assets/logo.jpg')),
          ),
        ),
      ),
    );
  }
}

