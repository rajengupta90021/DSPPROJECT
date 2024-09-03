import 'package:flutter/material.dart';

import '../constant/colors.dart';
import '../services/auth/login_screen.dart';


class LoginandLoginLaterpage {
  static void show(BuildContext context, String headerText) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.50,
          maxChildSize: 0.9,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    headerText,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Login first to view the complete application and to book the test for home collection and lab visit',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => loginscreen()));
                            // Handle login button tap
                            // You can navigate to login screen or perform any other action
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(iconcolor),
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          child: Text('Login'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        // Handle login later button tap
                        Navigator.pop(context); // Close the modal bottom sheet
                      },
                      child: Text(
                        'Login later',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static Future<void> showInternet(
      BuildContext context, String headerText,
      {bool isDismissible = false}) {
    return showModalBottomSheet(
      context: context,
      isDismissible: isDismissible,
      enableDrag: false,

      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            // Return false to prevent the modal from closing on back button press
            return false;
          },
          child: GestureDetector(
            onTap: () {
              if (isDismissible) {
                Navigator.of(context).pop();
              }
            },
            child: Container(
              height: 300, // Height of the bottom sheet
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // Center align the content
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/noInternet.gif', // Path to your GIF file
                        width: 120, // Adjust the width of the GIF
                        height: 120, // Adjust the height of the GIF
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Center align the row
                      children: [
                        SizedBox(width: 10),
                        Expanded(
                          child: Center(
                            child: Text(
                              headerText,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Detailed Message
                    Text(
                      'Your device is not connected to the internet. Please connect to the internet and try again.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center, // Center align the text
                    ),
                    SizedBox(height: 20),
                    // Optionally, you can add more content here
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}
