import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dspuiproject/helper/Internet.dart';
import 'package:dspuiproject/services/UnoHomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import '../constant/colors.dart';
import '../provider/CartProvider.dart';
import '../Model/TestInformation.dart';
import '../dbHelper/DbHelper.dart';
import '../widgets/ShimmerEffect.dart';
import 'BottomNavigationfooter/NavigationMenu.dart';
import 'Detailspage.dart';
import 'cart2.dart';
import 'package:badges/badges.dart' as badges;
import 'dart:developer' as developer;

class BookingTest3 extends StatefulWidget {
  const BookingTest3({Key? key}) : super(key: key);

  @override
  State<BookingTest3> createState() => _BookingTest3State();
}

class _BookingTest3State extends State<BookingTest3> {
  DbHelper? dbhelper = DbHelper();
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {

    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<CartProvider>(context, listen: false).loadTestInfos();
    });
    // Internet().CheckInternet();

  }



  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        // Prevent back navigation
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Book Test", style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: iconcolor,
          // automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Navigator.pop(context);
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>NavigationMenu()), (route) => false);

            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Cart2()));
                },
                child: Consumer<CartProvider>(
                  builder: (context, value, child) {
                    return badges.Badge(
                      badgeContent: Text(
                        value.getcounter().toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      position: BadgePosition.topEnd(top: -17, end: 3),
                      child: Image.asset(
                        'assets/shopping-cart.png', // Path to your image asset
                        height: 30,
                        width: 30,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        body:  Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: double.infinity,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search Tests',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value.toLowerCase();
                    });
                  },
                  onSubmitted: (value) {
                    // Hide keyboard when the user presses done on the keyboard
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
            ),
            Expanded(
              child: Consumer<CartProvider>(
                builder: (context, provider, _) {
                  // Filtered test infos based on search query
                  List<TestInformation> filteredTestInfos = provider.testInfos.where((testInfo) {
                    return testInfo.tests!.toLowerCase().contains(_searchQuery);
                  }).toList();

                  // Display fetched and filtered data or "Test not available" message
                  return filteredTestInfos.isEmpty
                      ? Center(
                      child: ShimmerCategoryListWidget()
                  )
                      : ListView.builder(
                    itemCount: filteredTestInfos.length,
                    itemBuilder: (context, index) {
                      TestInformation testInfo = filteredTestInfos[index];
                      bool isInCart = cartProvider.addIdValue.contains(testInfo.id.toString());

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/logo.jpg',
                                      height: 30,
                                      width: 30,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        testInfo.tests ?? '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: navyBlueColor,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Implement compare functionality
                                      },
                                      child: const Text(
                                        "Compare",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: textColor,
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.compare,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.info_outline, color: Colors.black, size: 30),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        testInfo.reporting ?? '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: textColor,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            // builder: (context) => DetailsPage(),
                                            builder: (context) => DetailsPage(testInfo: testInfo),

                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "DETAILS",
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: navyBlueColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.settings, color: Colors.black, size: 30),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        testInfo.rates != null ? 'Rs. ${testInfo.rates}' : '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: textColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.text_snippet_outlined, color: Colors.black, size: 30),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        testInfo.sNo != null ? 'S No. ${testInfo.sNo}' : '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: textColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: isInCart ? tealGreenColor : navyBlueColor,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (isInCart) {
                                          // Remove from cart
                                          dbhelper?.delete(testInfo.id!).then((value) {
                                            cartProvider.removeTotalPrice(testInfo.rates!.toInt());
                                            cartProvider.removeCounter();
                                            cartProvider.updateAddIdValue(testInfo.id.toString());
                                          }).onError((error, stackTrace) {
                                            print("error occurred: ${error.toString()}");
                                          });
                                        } else {
                                          // Add to cart
                                          dbhelper?.insert(
                                            TestCart(
                                              id: testInfo.id.toString(),
                                              rates: testInfo.rates,
                                              sampleColl: testInfo.sampleColl,
                                              reporting: testInfo.reporting,
                                              tests: testInfo.tests,
                                            ),
                                          ).then((value) {
                                            cartProvider.addTotalPrice(testInfo.rates!);
                                            cartProvider.addcounter();
                                            cartProvider.updateAddIdValue(testInfo.id.toString());
                                          }).onError((error, stackTrace) {
                                            print("error occurred: ${error.toString()}");
                                          });
                                        }
                                      });

                                    },
                                    child: Center(
                                      child: Text(
                                        isInCart ? "REMOVE FROM CART" : "ADD TO CART",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: isInCart ? redColor : navyBlueColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        )
      ),
    );
  }
}



// class NoInternetPage extends StatelessWidget {
//
//   final AsyncSnapshot<ConnectivityResult> snapshot;
//   final Widget widget;
//
//   const NoInternetPage({
//     Key? key,
//     required this.widget,
//     required this .snapshot,
// }): super (key: key);
//   @override
//   Widget build(BuildContext context) {
//
//     switch(snapshot.connectionState){
//       case ConnectionState.active:
//         final state = snapshot.data!;
//         switch(state){
//           case ConnectivityResult.none:
//             return Center(child: Text("no internet"),);
//           default:
//             return widget;
//
//         }
//       default :
//         return Text("");
//
//     }
//   }
// }
//
//
class NoInternetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "No Internet Connection",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

