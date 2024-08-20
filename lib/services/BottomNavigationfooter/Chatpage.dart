import 'package:flutter/material.dart';

import '../../constant/colors.dart';
import 'Support_page.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int page = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: iconcolor,
        title: Text('chat'),
      ),
      body: Container(
        // Your content for the Offers page
        child: Center(
          child: Text(
            'we are live  ',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
      floatingActionButton: Stack(
        alignment: Alignment.topCenter,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SupportPage()));
            },



            // backgroundColor: browncolor2, // Customize the background color
            // foregroundColor: iconcolor, // Customize the icon and text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Adjust the button shape
            ),
            child: Image.asset(
              'assets/live-chat.png', // Provide the path to your image asset
              width: 70, // Adjust the width of the image
              height: 70, // Adjust the height of the image
              // color: iconcolor, // Customize the color of the image
            ),
          ),

        ],
      ),
    );
  }
}
