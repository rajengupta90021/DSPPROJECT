import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Model/TestInformation.dart';
import '../../constant/colors.dart';
import 'package:dspuiproject/provider/CartProvider.dart';
import 'package:badges/badges.dart' as badges;

import '../../dbHelper/DbHelper.dart';
import '../../widgets/ShimmerEffect.dart';
import '../Detailspage.dart';
import '../cart2.dart';

class SingleCategoryDetailsPage2 extends StatefulWidget {
  final String category;

  const SingleCategoryDetailsPage2(this.category, {Key? key}) : super(key: key);

  @override
  State<SingleCategoryDetailsPage2> createState() => _SingleCategoryDetailsPage2State();
}

class _SingleCategoryDetailsPage2State extends State<SingleCategoryDetailsPage2> {
  DbHelper? dbhelper = DbHelper();
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<CartProvider>(context, listen: false).fetchSingleCategories(widget.category);
    });
  }
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    // final provider = Provider.of<CartProvider>(context, listen: false);
    // provider.fetchSingleCategories(widget.category);

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('${widget.category}',style: TextStyle(fontWeight: FontWeight.bold),)),
        backgroundColor: iconcolor,
        // automaticallyImplyLeading: false,
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
      body: Center(
        child: Consumer<CartProvider>(
          builder: (context, provider, _){
            if (provider.singlecategories.isEmpty) {
              return Center(
                child: Text(
                  'No tests available right now.',
                  style: TextStyle(fontSize: 18.0, color: Colors.black54),
                ),
              );
            } else if (provider.isLoading) {
              return ShimmerCategoryListWidget();
            }else{
              return ListView.builder(
                itemCount: provider.singlecategories.length,
                  itemBuilder:  (context, index) {
                    TestInformation testInfo = provider.singlecategories[index];
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
                                          builder: (context) => DetailsPage(testInfo: testInfo,),
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
                  }

              );
              }
          },
        ),
      )
    );
  }
}
