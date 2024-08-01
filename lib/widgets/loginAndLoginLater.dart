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
  static void showInternet(BuildContext context, String headerText, {bool isDismissible = false}) {
    showModalBottomSheet(
      context: context,
      isDismissible: isDismissible,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            if (isDismissible) {
              Navigator.of(context).pop();
            }
          },
          child: DraggableScrollableSheet(
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
                      // Your row content here
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

}
