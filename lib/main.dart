import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dspuiproject/constant/colors.dart';
import 'package:dspuiproject/provider/AddressControlller.dart';
import 'package:dspuiproject/provider/CartProvider.dart';
import 'package:dspuiproject/provider/ChildMemberController.dart';
import 'package:dspuiproject/provider/DateTimeProvider.dart';
import 'package:dspuiproject/provider/InternetCheckingProvider.dart';
import 'package:dspuiproject/provider/ProviderData.dart';
import 'package:dspuiproject/provider/SelectedMemberProvider.dart';
import 'package:dspuiproject/provider/UserImageComtroller.dart';
import 'package:dspuiproject/provider/controller/ForgotpasswordController.dart';
import 'package:dspuiproject/provider/controller/SignUpcontroller.dart';
import 'package:dspuiproject/provider/controller/loginController.dart';
import 'package:dspuiproject/services/splashScreen.dart';
import 'package:dspuiproject/provider/Profile_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/Internet.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // name: 'dspuiproject',
    options: const FirebaseOptions(
      apiKey: "AIzaSyBLdJ9CVaGPEmnKcuzhOsHMFJX-mrxXyFM",
      // authDomain: "dspuiproject-cd859.firebaseapp.com",
      projectId: "dspuiproject-cd859",
      storageBucket: "dspuiproject-cd859.appspot.com",
      // storageBucket: "gs://dspuiproject-cd859.appspot.com",
      messagingSenderId: "526547045932",
      appId: "1:526547045932:android:f133058d57168d907c4b89",
    ),
  );
  SharedPreferences   prefs = await SharedPreferences.getInstance();
  await AwesomeNotifications().initialize( 'resource://drawable/launcher_icon', [
    NotificationChannel(
      channelGroupKey: "basic_channel_group",
      channelKey: "basic_channel",
      channelName: "Basic Notification",
      channelDescription: "Basic notifications channel",
      ledColor: iconcolor,
      icon: 'resource://drawable/launcher_icon',

    )
  ], channelGroups: [
    NotificationChannelGroup(
      channelGroupKey: "basic_channel_group",
      channelGroupName: "Basic Group",
    )
  ]);
  bool isAllowedToSendNotification =
  await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return OverlaySupport.global(
      child: MultiProvider(providers: [
      
        ChangeNotifierProvider(
          create: (context) => ProviderData(),
      
      
        ),
        ChangeNotifierProvider(
          create: (context) => SignUpController(),
      
      
        ),
        ChangeNotifierProvider(
          create: (context) => LoginController(),
      
      
        ),
        ChangeNotifierProvider(
          create: (context) => ForgotPasswordController(),
      
      
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileController(),
      
      
        ),
         ChangeNotifierProvider(
          create: (context) => CartProvider(),
      
      
        ),  ChangeNotifierProvider(
          create: (context) => ChildMemeberController(),


        ), ChangeNotifierProvider(
          create: (context) => SelectedMemberProvider(),


        ),ChangeNotifierProvider(
          create: (context) => InternetChickingProvider(),


        ),ChangeNotifierProvider(
          create: (context) => UserImageController(),


        ),
        ChangeNotifierProvider(
          create: (context) => DateTimeProvider(),


        ),ChangeNotifierProvider(
          create: (context) => AddressProvider(),


        ),
      
      ],
      
        child: GetMaterialApp(
      
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home:  SplashScreen(),
        ),
      
      
      ),
    );
  }
}
