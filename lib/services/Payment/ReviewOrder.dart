import 'dart:convert';

import 'package:dspuiproject/services/Payment/SelectAnAdress.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/ChildMember.dart';
import '../../Model/MyOrder.dart';
import '../../Model/TestInformation.dart';
import '../../dbHelper/DbHelper.dart';
import '../../provider/AddressControlller.dart';
import '../../provider/CartProvider.dart';
import 'package:dspuiproject/constant/colors.dart';

import '../../provider/DateTimeProvider.dart';
import '../../provider/SelectedMemberProvider.dart';
import '../BookingTest3.dart';
import '../family_member_widgets/FamilyMember.dart';
import 'BookingDate.dart';
import 'CouponsScreen.dart';
import 'PaymentMethod.dart';


class ReviewOrder extends StatefulWidget {
  const ReviewOrder({Key? key}) : super(key: key);

  @override
  State<ReviewOrder> createState() => _ReviewOrderState();
}

class _ReviewOrderState extends State<ReviewOrder> {
  DbHelper dbHelper = DbHelper();

  DBHelperOrder DBHelperOrderr= DBHelperOrder();

  @override
  Widget build(BuildContext context) {
    int counter = Provider.of<CartProvider>(context, listen: false).getcounter();
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Review Your Order',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        backgroundColor: iconcolor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              // Add functionality for the circular plus icon
            },
          ),
        ],
      ),
      body: counter ==0 ? _buildEmptyCartContent(context) : SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _buildExpiryBanner(),
                  SizedBox(height: 16),
                  FutureBuilder<List<TestCart>>(
                    future: cart.getData(),
                    builder: (context, AsyncSnapshot<List<
                        TestCart>> snapshot) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return _buildCartContent(context, snapshot.data!,
                            cart);
                      } else {
                        return _buildEmptyCartContent(context);
                      }
                    },
                  ),
                ],
              ),
            ),


            SizedBox(height: 10),
            _buildApplyCoupon(),
            SizedBox(height: 10),
            _buildUserDetails(),

            _buildAddressDetails(),
            
            _buildTimeSlotDetails(),
            SizedBox(height: 10),
            Divider(),
            _buildTotalCharges(),

            SizedBox(height: 10),
            Divider(),
            _buildSpecialInstructions(),
            SizedBox(height: 10),
            _buildProceedToPayButton(),
            SizedBox(height: 10),

          ],
        ),
      ),
    );
  }

  Widget _buildCartContent(BuildContext context, List<TestCart> cartItems, CartProvider cart) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Center(
            child: Text(
              'Test Selected - ${cart.getcounter()}',
              style: TextStyle(fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: cartItems.length,
          itemBuilder: (context, index) {
            TestCart cartItem = cartItems[index];
            return Card(
              elevation: 2,
              shadowColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.white,
              child: ListTile(
                contentPadding: const EdgeInsets.all(1.0),
                leading: Image.asset(
                  'assets/logo.jpg', // Replace with your asset image path
                  width: 30, // Adjust width as needed
                  height: 30, // Adjust height as needed
                ),
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
                          content: Text(
                              "Are you sure you want to delete this item?"),
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
                                  cart.removeTotalPrice(
                                      cartItem.rates!.toInt());
                                  cart.removeCounter();
                                  cart.updateAddIdValue(cartItem.id.toString());
                                });
                                setState(() {
                                  // Refresh the cart data
                                  // _cartFuture = Provider.of<CartProvider>(context, listen: false).getData();
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
      ],
    );
  }

  Widget _buildEmptyCartContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Find some tests',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
              //   return BookingTest3();
              // }));
              // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>BookingTest3()), (route) => false);
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => BookingTest3()), (route) => false);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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

  Widget _buildExpiryBanner() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.blue.shade100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Selected slot will expire in'),
          Text(
            '14 : 30',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildTestDetails() {
    // Replace with your implementation of test details widget
    return Container(
      height: 100,
      color: Colors.blue,
      child: Center(
        child: Text(
          'Test Details',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildApplyCoupon() {
    // Replace with your implementation of apply coupon widget
    return ListTile(
      tileColor: Colors.grey.shade200,
      leading: Icon(Icons.local_offer, color:iconcolor),
      title: Text('Apply Coupon'),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CouponsScreen()));
        // Handle Apply Coupon
      },
    );
  }

  Widget _buildUserDetails() {
    // Replace with your implementation of user details widget
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<SelectedMemberProvider>(
        builder: (context, selectedMemberProvider, child) {
          // Get the selected member details from the provider

          return Card(
            child: ListTile(
              leading: Icon(Icons.person, color: iconcolor, size: 40), // User icon
              title: selectedMemberProvider.name != null
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedMemberProvider.name ?? 'No Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.green,
                    ),
                    child: Text(
                      selectedMemberProvider.relation ?? 'self',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    selectedMemberProvider.phone ?? '999999999',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              )
                  : Text('No member selected'),
              trailing: TextButton(
                onPressed: () {
                  // Navigate to the SelectFamilyMember screen to change the selected member
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectFamilyMember()),
                  );
                },
                child: Text(
                  'CHANGE',
                  style: TextStyle(color: iconcolor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget _buildAddressDetails() {
    return Consumer<AddressProvider>(
      builder: (context, addressProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: ListTile(
              leading: Icon(Icons.location_on, color: Colors.blue),
              title: Text(
                '${addressProvider.address}, ${addressProvider.houseNo}, ${addressProvider.phoneNo}, ${addressProvider.pinCode}, ${addressProvider.cityName}, ${addressProvider.stateName}',
              ),
              trailing: TextButton(
                onPressed: () {
                  // Handle change address
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectAnAddress(), // Update with your page for changing address
                    ),
                  );
                },
                child: Text('CHANGE', style: TextStyle(color: Colors.orange)),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTimeSlotDetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<DateTimeProvider>(
        builder: (context, dateTimeProvider, _) {
          // Extract values from provider
          DateTime? selectedDate = dateTimeProvider.selectedDate;
          String? selectedStartTime = dateTimeProvider.selectedStartTime;
          String? selectedEndTime = dateTimeProvider.selectedEndTime;

          // Format date and time strings
          String formattedDate = DateFormat.yMMMd().format(selectedDate!);
          String displayTime = '$selectedStartTime - $selectedEndTime';

          return Card(
            child: ListTile(
              leading: Icon(Icons.calendar_today, color: Colors.blue),
              title: Text('$formattedDate $displayTime'),
              subtitle: Text('Phlebo will reach between $selectedStartTime for sample collecting'),
              trailing: TextButton(
                onPressed: () {
                  // Handle change time slot
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingDate()));
                },
                child: Text('CHANGE', style: TextStyle(color: iconcolor)),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTotalCharges() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Total Charges',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          // Consumer<CartProvider>(
          //   builder: (context, cart, child) {
          //     return Text(
          //       'Rs. ${cart.getTotalPrice()}',
          //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          //     );
          //   },
          // ),
          _buildChargeRow('Total', Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Text('₹ ${cart.getTotalPrice().toStringAsFixed(2)}');
            },
          )),
          _buildChargeRow('Sub Total', Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Text('₹ ${cart.getTotalPrice().toStringAsFixed(2)}');
            },
          )),
          // _buildChargeRow('Phlebotomy Charges', Text('₹ 100')), // Pass Text widget directly
          SizedBox(height: 8),
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              int totalPayableAmount = cart.getTotalPrice(); // Example additional charges
              return _buildChargeRow('Total Payable Amount', Text('₹ ${totalPayableAmount.toStringAsFixed(2)}',style: TextStyle(fontWeight: FontWeight.bold),), isBold: true);
            },
          ),
        ],
      ),
    );
  }


  Widget _buildChargeRow(String label, dynamic amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
          if (amount is String)
            Text(
              amount,
              style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
            ),
          if (amount is Widget)
            amount,
        ],
      ),
    );
  }


  Widget _buildSpecialInstructions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Special instructions/Requests:', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'If you have any special instructions for this order.',
            ),
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildProceedToPayButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 8),
          backgroundColor: iconcolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () async {
          int counter = Provider.of<CartProvider>(context, listen: false).getcounter();

          if (counter == 0) {
            Fluttertoast.showToast(
              msg: "Add items to proceed to payment",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingTest3()));

          } else {
            // Proceed to payment logic
            print("Proceeding to payment...");
            // _gatherAndStoreData();


            // final cartProvider = Provider.of<CartProvider>(context, listen: false);
            // final selectedMemberProvider = Provider.of<SelectedMemberProvider>(context, listen: false);
            // final addressProvider = Provider.of<AddressProvider>(context, listen: false);
            // final dateTimeProvider = Provider.of<DateTimeProvider>(context, listen: false);
            // SharedPreferences prefs = await SharedPreferences.getInstance();
            // // Gather data
            // Childname = selectedMemberProvider.name;
            // childuserRelation = selectedMemberProvider.relation;
            // ChilduserPhone = selectedMemberProvider.phone;
            // childuserdob = selectedMemberProvider.dob;
            // Childusergender = selectedMemberProvider.gender;
            //
            // ParentchilduserAddress = addressProvider.address;
            // childuserHouseNo = addressProvider.houseNo;
            // childuserPinCode = addressProvider.pinCode;
            // childuserCity = addressProvider.cityName;
            // childuserState = addressProvider.stateName;
            //
            // selectedDate = dateTimeProvider.selectedDate;
            // startTime = dateTimeProvider.selectedStartTime;
            // endTime = dateTimeProvider.selectedEndTime;
            //
            // _userId = prefs.getString('user_id') ?? '';
            // _username = prefs.getString('name') ?? '';
            // _email = prefs.getString('email') ?? '';
            // _password = prefs.getString('password') ?? '';
            // _mobile = prefs.getString('mobile') ?? '';
            // _dob = prefs.getString('dob') ?? '';
            // _gender = prefs.getString('gender') ?? '';
            // _profileImg = prefs.getString('profile_img') ?? '';
            // _role = prefs.getString('role') ?? '';
            // _createdAt = prefs.getString('created_at') ?? '';
            // _updatedAt = prefs.getString('updated_at') ?? '';
            // // Total amount
            // totalAmount = cartProvider.getTotalPrice().toDouble();
            // List<TestCart> cartItems = await _cartFuture;
            // List<Map<String, dynamic>> cartItemsJson = cartItems.map((item) => item.toMap()).toList();
            // String cartItemsString = jsonEncode(cartItemsJson);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentMethod(

                ),
              ),
            );
          }
          // Handle proceed to pay
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'procced to payment',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
            ),
            const SizedBox(width: 8),

          ],
        ),
      ),
    );
}

  // Future<void> _gatherAndStoreData() async {
  //   final cartProvider = Provider.of<CartProvider>(context, listen: false);
  //   final selectedMemberProvider = Provider.of<SelectedMemberProvider>(context, listen: false);
  //   final addressProvider = Provider.of<AddressProvider>(context, listen: false);
  //   final dateTimeProvider = Provider.of<DateTimeProvider>(context, listen: false);
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // Gather data
  //   Childname = selectedMemberProvider.name;
  //   childuserRelation = selectedMemberProvider.relation;
  //   ChilduserPhone = selectedMemberProvider.phone;
  //
  //   ParentchilduserAddress = addressProvider.address;
  //   childuserHouseNo = addressProvider.houseNo;
  //   childuserPinCode = addressProvider.pinCode;
  //   childuserCity = addressProvider.cityName;
  //   childuserState = addressProvider.stateName;
  //
  //   selectedDate = dateTimeProvider.selectedDate;
  //   startTime = dateTimeProvider.selectedStartTime;
  //   endTime = dateTimeProvider.selectedEndTime;
  //
  //   _userId = prefs.getString('user_id') ?? '';
  //   _username = prefs.getString('name') ?? '';
  //   _email = prefs.getString('email') ?? '';
  //   _password = prefs.getString('password') ?? '';
  //   _mobile = prefs.getString('mobile') ?? '';
  //   _profileImg = prefs.getString('profile_img') ?? '';
  //   _role = prefs.getString('role') ?? '';
  //   _createdAt = prefs.getString('created_at') ?? '';
  //   _updatedAt = prefs.getString('updated_at') ?? '';
  //   // Total amount
  //   totalAmount = cartProvider.getTotalPrice().toDouble();
  //
  //   print("parent parent: $_userId");
  //   print("parent _username: $_username");
  //   print("parent _email: $_email");
  //   print("parent _password: $_password");
  //   print("parent _mobile: $_mobile");
  //   print("parent _profileImg: $_profileImg");
  //   print("parent _role: $_role");
  //   print("parent _createdAt: $_createdAt");
  //   print("parent _updatedAt: $_updatedAt");
  //
  //   print("child Name: $Childname");
  //   print("child Relation: $childuserRelation");
  //   print("child Phone: $ChilduserPhone");
  //   print("child Address: $ParentchilduserAddress");
  //   print("House No: $childuserHouseNo");
  //   print("Pin Code: $childuserPinCode");
  //   print("City: $childuserCity");
  //   print("State: $childuserState");
  //   print("Selected Date: $selectedDate");
  //   print("Start Time: $startTime");
  //   print("End Time: $endTime");
  //   print("Total Amount: $totalAmount");
  //
  //   List<TestCart> cartItems = await _cartFuture;
  //   List<Map<String, dynamic>> cartItemsJson = cartItems.map((item) => item.toMap()).toList();
  //   String cartItemsString = jsonEncode(cartItemsJson);
  //
  //   Order order = Order(
  //     orderId: DateTime.now().millisecondsSinceEpoch,
  //     userId: _userId ?? '', // Provide a default value if null
  //     username: _username ?? '',
  //     email: _email ?? '',
  //     password: _password ?? '',
  //     mobile: _mobile ?? '',
  //     profileImg: _profileImg ?? '',
  //     role: _role ?? '',
  //     createdAt: _createdAt ?? '',
  //     updatedAt: _updatedAt ?? '',
  //     childName: Childname ?? '',
  //     childUserRelation: childuserRelation ?? '',
  //     childUserPhone: ChilduserPhone ?? '',
  //     childUserDob: childuserdob ?? '',
  //     parentChildUserAddress: ParentchilduserAddress ?? '',
  //     childUserHouseNo: childuserHouseNo ?? '',
  //     childUserPinCode: childuserPinCode ?? '',
  //     childUserCity: childuserCity ?? '',
  //     childUserState: childuserState ?? '',
  //     selectedDate: selectedDate ?? DateTime.now(), // Format DateTime or provide default
  //     startTime: startTime ?? '',
  //     endTime: endTime ?? '',
  //     totalAmount: totalAmount ?? 0.0, // Provide a default value if null
  //     cartItems: cartItemsString,
  //     orderStatus: 'PENDING',
  //     paymentStatus: 'PENDING', // This should be a non-null string
  //   );
  //
  //   await DBHelperOrderr.insertOrder(order);
  //
  // }


}