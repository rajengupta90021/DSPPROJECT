import 'package:dspuiproject/services/BottomNavigationfooter/NavigationMenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import '../Model/TestInformation.dart';
import '../SharedPreferecneService/SharedPreferenceSerivice.dart';
import '../constant/colors.dart';
import '../dbHelper/DbHelper.dart';
import '../provider/CartProvider.dart';
import 'package:badges/badges.dart' as badges;

import 'BookingTest3.dart';
import 'Payment/SelectAnAdress.dart';
import 'auth/login_screen.dart';
import 'bookingtest2.dart';
import 'family_member_widgets/FamilyMember.dart';

class Cart2 extends StatefulWidget {
  const Cart2({Key? key}) : super(key: key);

  @override
  _Cart2State createState() => _Cart2State();
}

class _Cart2State extends State<Cart2> {
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();
  DbHelper dbHelper = DbHelper();
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    bool isLoggedIn = await _sharedPreferencesService.isUserLoggedIn();
    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart",style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: iconcolor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
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
      body: FutureBuilder<List<TestCart>>(
        future: cart.getData(),
        builder: (context, AsyncSnapshot<List<TestCart>> snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return _buildCartContent(context, snapshot.data!, cart);
          } else {
            return _buildEmptyCartContent(context);
          }
        },
      ),
    );
  }

  Widget _buildCartContent(BuildContext context, List<TestCart> cartItems, CartProvider cart) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              'Test Selected - ${cart.getcounter()}',
              style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              TestCart cartItem = cartItems[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 2,
                shadowColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.white,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10.0),
                  title: Text(
                    cartItem.tests!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: navyBlueColor,
                    ),
                  ),
                  subtitle: Text(
                    'Rs: ${cartItem.rates.toString()}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirm Delete"),
                            content: Text("Are you sure you want to delete this item?"),
                            actions: <Widget>[
                              TextButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text("Delete"),
                                onPressed: () {
                                  dbHelper.delete(cartItem.id).then((value) {
                                    cart.removeTotalPrice(cartItem.rates!.toInt());
                                    cart.removeCounter();
                                    cart.updateAddIdValue(cartItem.id.toString());
                                  });
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),

                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: 390,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookingTest3()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Add More Tests',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
                      ),
                      Icon(Icons.add_circle_outline,color: Colors.black,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Consumer<CartProvider>(
                    builder: (context, value, child) {
                      return Text(
                        'Rs. ${value.getTotalPrice()}',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 8),
              Container(
                width: 390,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_isLoggedIn) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SelectAnAddress()),
                        // MaterialPageRoute(builder: (context) => SelectFamilyMember()),
                      );

                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => loginscreen()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    backgroundColor: iconcolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isLoggedIn ? 'Proceed' : 'Proceed to Login',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.arrow_forward,color: Colors.black,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyCartContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          CircleAvatar(
            radius: 30,
            backgroundColor: extralightBlueColor,
            child: ClipOval(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/empty-cart.png'),
              ),
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Find some tests',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Looks like there are no tests in your cart.',
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          SizedBox(height: 8),
          Text(
            'Please try some of our tests exclusively recommended for you.',
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
              //   return BookingTest3();
              // }));
              // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>BookingTest3()), (route) => false);
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => BookingTest3()), (route) => false);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              backgroundColor: iconcolor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Explore Tests',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold ,color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
