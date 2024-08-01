
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/colors.dart';
import '../home_page2.dart';
import '../Navbar/navbar.dart';

class offerpage extends StatefulWidget {
  const offerpage({Key? key});

  @override
  State<offerpage> createState() => _offerpageState();
}


class _offerpageState extends State<offerpage> {
  int page =3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: iconcolor,
        title: Padding(
          padding: const EdgeInsets.only(right: 60),
          child: Center(child: Text('Offers')),
        ),
      ),
      body: Container(
        // Your content for the Offers page
        child: Center(
          child: Text(
            'Offers Page Content',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
      // bottomNavigationBar: buildBottomNavigationBar(context, page),
    );
  }
}