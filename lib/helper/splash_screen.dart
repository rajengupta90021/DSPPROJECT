
import 'package:flutter/material.dart';


import '../firebase_service/splash_service.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {

  SplashService splashscreen= SplashService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashscreen.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Firebase"),
      ),
    );
  }
}
