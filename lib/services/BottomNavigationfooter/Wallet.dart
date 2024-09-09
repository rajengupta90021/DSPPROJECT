import 'package:dspuiproject/services/BottomNavigationfooter/FaqSection.dart';
import 'package:flutter/material.dart';

import '../../constant/colors.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsiveness
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: iconcolor,
        title: Text(
          'Wallet',
          style: TextStyle(fontSize: 24), // Adjusted font size for better fit
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Added padding for better spacing
        child: Column(
          children: [
            Container(
              width: screenSize.width, // Use full width
              height: screenSize.height * 0.25, // Use 25% of the screen height
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
                color: iconcolor4,
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Swasth Point',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.info_outline),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: screenSize.height * 0.1, // Adjust based on screen height
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        '0',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 60, // Increased font size for emphasis
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FaqSection()),
                        );
                      },
                      child: Icon(
                        Icons.mark_unread_chat_alt_outlined,
                        color: Colors.black,
                        size: 28, // Increased icon size for better touch target
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                width: screenSize.width, // Use full width
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0), // Added padding for better spacing
                      child: Text(
                        'Transaction',
                        style: TextStyle(
                          fontSize: 20, // Increased font size for emphasis
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: Center(
                        child: Text(
                          'No wallet transactions',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18, // Increased font size for better readability
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
