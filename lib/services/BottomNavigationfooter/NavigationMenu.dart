import 'package:dspuiproject/services/BottomNavigationfooter/offerpage.dart';
import 'package:dspuiproject/services/BottomNavigationfooter/searchbar.dart';
import 'package:dspuiproject/services/UnoHomePage.dart';
import 'package:dspuiproject/services/home_page2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import 'Chatpage.dart';
import 'Wallet.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {

    final controller =Get.put(Navgationcontroller());
    return  Scaffold(


        bottomNavigationBar: Obx(
            ()=>NavigationBar(
                // color: Colors.brown.shade100,
              backgroundColor: deeporange,
              height: 55,
                elevation: 1,
                selectedIndex:controller.selectedindex.value ,
                onDestinationSelected: (index)=> controller.selectedindex.value=index,
                destinations:  [
                  NavigationDestination(icon: Image.asset(
                    'assets/home.png',  // Replace 'assets/your_image.png' with your actual image path
                    width: 28,
                    height: 28,
                    fit: BoxFit.contain,  // Adjust the fit as per your requirement
                  ), label: "home"),
                  // NavigationDestination(icon: Icon(Icons.home , color: browncolor2), label: "home"),
                  NavigationDestination(icon: Image.asset(
                    'assets/searchnav.png',  // Replace 'assets/your_image.png' with your actual image path
                    width: 28,
                    height: 28,
                    fit: BoxFit.contain,  // Adjust the fit as per your requirement
                  ), label: "search"),
                  NavigationDestination(icon: Image.asset(
                    'assets/wallets.png',  // Replace 'assets/your_image.png' with your actual image path
                    width: 28,
                    height: 28,
                    fit: BoxFit.contain,  // Adjust the fit as per your requirement
                  ), label: "wallet"),
                  NavigationDestination(icon: Icon(Icons.local_offer , color: browncolor2), label: "offers"),
                  NavigationDestination(icon: Image.asset(
                    'assets/chat.png',  // Replace 'assets/your_image.png' with your actual image path
                    width: 28,
                    height: 28,
                    fit: BoxFit.contain,  // Adjust the fit as per your requirement
                  ), label: "chat"),

                ],  )

        ),
        body: Obx(()=>controller.screen[controller.selectedindex.value]),
    );
  }
}

class Navgationcontroller extends GetxController{

  final Rx<int> selectedindex =0.obs;
  final screen=[UnoHomePage(),searchbar(),Wallet(),offerpage(), ChatPage()];
}
// homepage2()
