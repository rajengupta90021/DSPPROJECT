import 'package:dspuiproject/services/BottomNavigationfooter/FaqSection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart';

import '../../constant/colors.dart';
import '../Navbar/navbar.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: iconcolor,
        title: Padding(
          padding: const EdgeInsets.only(right: 60),
          child: Center(child: Text('Wallet',style: TextStyle(fontSize: 30),)),
        ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 450,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black), // Add border color
              borderRadius: BorderRadius.circular(7),
              color: iconcolor4,
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 140,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Row(
                        children: [
                          Text(
                            'Swasth point',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8,),
                          Icon(Icons.info_outline)
                        ],
                      ),

                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 190,

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Row(
                        children: [
                          Text(
                            '0',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8,),

                        ],
                      ),

                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FaqSection()));
                      },
                      child: Icon(
                        Icons.mark_unread_chat_alt_outlined,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],

            ),

          ),

          Container(
            width: 450,
            height: 390,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black), // Add border color
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Transaction',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20), // Adjust the spacing between the text and 'No wallet transaction' as needed
                Expanded(
                  child: Center(
                    child: Text(
                      'No wallet transaction',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),



        ],

      ),


    );
  }
}
