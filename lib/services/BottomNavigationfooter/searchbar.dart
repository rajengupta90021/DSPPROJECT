
import 'package:dspuiproject/services/home_page2.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/colors.dart';
import 'NavigationMenu.dart';



class searchbar extends StatefulWidget {
  const searchbar({super.key});

  @override
  State<searchbar> createState() => _searchbarState();
}

class _searchbarState extends State<searchbar> {
  int searchbar = 1;


  String searchValue = '';
  final List<String> _suggestions = ['Afeganistan', 'Albania', 'Algeria', 'Australia', 'Brazil', 'German', 'Madagascar', 'Mozambique', 'Portugal', 'Zambia'];

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Search City',
        theme: ThemeData(
            primarySwatch: Colors.orange
        ),
        home: Scaffold(



            appBar: EasySearchBar(
              backgroundColor: iconcolor,

              title: Center(child: const Text('search City')),
              onSearch: (value) => setState(() => searchValue = value),
              suggestions: _suggestions,
              // leading: IconButton(
              //   icon: Icon(Icons.arrow_back),
              //   onPressed: () {
              //     Navigator.pop(context, MaterialPageRoute(builder: (context)=>NavigationMenu())); // Navigate back when the back icon is pressed
              //   },
              // ),

            ),

            body: Center(
                child: Text('Value: $searchValue')
            ),
            // bottomNavigationBar: buildBottomNavigationBar(context, searchbar),
        )

    );
  }
}