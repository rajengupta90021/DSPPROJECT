import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/colors.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 100,
        backgroundColor: iconcolor,
        title: Text('My Subscription'), // Title in the app bar
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Pop the current route to go back
          },
        ),
      ),
      body: Center(
        child: Column(

          children: [
            SizedBox(height: 25,),
            const Text(
              'You have not subscribed to any healthy program. Please subscribe to a program to enjoy a host of benefits.',
              textAlign: TextAlign.center,style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 20),
            Image.asset('assets/mysubscription.jpg'), // Placeholder image
          ],
        ),
      ),
    );
  }
}
