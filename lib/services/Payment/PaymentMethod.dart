import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dspuiproject/services/BottomNavigationfooter/NavigationMenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/MyOrder.dart';
import '../../Model/TestInformation.dart';
import '../../Notification_service/NotificationService.dart';
import '../../constant/colors.dart';
import '../../dbHelper/DbHelper.dart';
import '../../provider/AddressControlller.dart';
import '../../provider/CartProvider.dart';
import '../../provider/DateTimeProvider.dart';
import '../../provider/NotificationController.dart';
import '../../provider/SelectedMemberProvider.dart';
import '../../repository/OrderDetailsRepository.dart';

class PaymentMethod extends StatefulWidget {




  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  final OrderDetailsRepository _repository = OrderDetailsRepository();
  int type = 4; // Default to Cash On Delivery
  // **************
  String? _userId;
  String? _username;
  String? _email;
  String? _password;
  String? _mobile;
  String? _dob;
  String? _gender;
  String ?_profileImg;
  String? _role;
  String? _createdAt;
  String? _updatedAt;
  // /*********************
  String? Childname;
  String? childuserRelation;
  String? ChilduserPhone;
  String? childuseremail;
  String? childuserdob;
  String? Childusergender;
  String? ParentchilduserAddress;
  String? childuserHouseNo;
  String? childuserPinCode;
  String? childuserCity;
  String? childuserState;
  // **********************
  DateTime? selectedDate;
  String? startTime;
  String? endTime;
  // *******************
  double? totalAmount;
  late Future<List<TestCart>> _cartFuture;
  final Logger logger = Logger();
  // ******************8
  void handleRadio(int? e) => setState(() {
    type = e!;
  });



  @override
  void initState() {
    _cartFuture = Provider.of<CartProvider>(context, listen: false).getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment method ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: iconcolor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 40,),
                // Amazon Pay
                if (type == 1 || type == 4) // Show only if selected or default
                  Container(
                    width: size.width,
                    height: 55,
                    decoration: BoxDecoration(
                      border: type == 1 ? Border.all(width: 1, color: Colors.black) : Border.all(width: 0.3, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Radio(
                                  value: 1,
                                  groupValue: type,
                                  onChanged: type == 4 ? null : handleRadio,
                                  activeColor: Colors.black,
                                ),
                                Text(
                                  "Amazon Pay",
                                  style: type == 1
                                      ? TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black)
                                      : TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),
                                ),
                              ],
                            ),
                            Image.asset(
                              "assets/Amazon_Pay.png",
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 15,),
                // Credit Card
                if (type == 2 || type == 4) // Show only if selected or default
                  Container(
                    width: size.width,
                    height: 55,
                    decoration: BoxDecoration(
                      border: type == 2 ? Border.all(width: 1, color: Colors.black) : Border.all(width: 0.3, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Radio(
                                  value: 2,
                                  groupValue: type,
                                  onChanged: type == 4 ? null : handleRadio,
                                  activeColor: Colors.black,
                                ),
                                Text(
                                  "Credit Card",
                                  style: type == 2
                                      ? TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black)
                                      : TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),
                                ),
                              ],
                            ),
                            Image.asset(
                              "assets/Visa.png",
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 15,),
                // Google Pay
                if (type == 3 || type == 4) // Show only if selected or default
                  Container(
                    width: size.width,
                    height: 55,
                    decoration: BoxDecoration(
                      border: type == 3 ? Border.all(width: 1, color: Colors.black) : Border.all(width: 0.3, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Radio(
                                  value: 3,
                                  groupValue: type,
                                  onChanged: type == 4 ? null : handleRadio,
                                  activeColor: Colors.black,
                                ),
                                Text(
                                  "Google Pay",
                                  style: type == 3
                                      ? TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black)
                                      : TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),
                                ),
                              ],
                            ),
                            Image.asset(
                              "assets/Google_Pay.png",
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 15,),
                // Cash On Delivery
                Container(
                  width: size.width,
                  height: 55,
                  decoration: BoxDecoration(
                    border: type == 4 ? Border.all(width: 1, color: Colors.black) : Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: 4,
                                groupValue: type,
                                onChanged: handleRadio,
                                activeColor: Colors.black,
                              ),
                              Text(
                                "Cash On Delivery",
                                style: type == 4
                                    ? TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black)
                                    : TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),
                              ),
                            ],
                          ),
                          Image.asset(
                            "assets/cash-on-delivery.png",
                            width: 35,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 100,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sub-total",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    Consumer<CartProvider>(
                      builder: (context, cart, child) {
                        int subtotal = cart.getTotalPrice(); // Use correct subtotal calculation
                        return Text(
                          '\₹ ${subtotal.toStringAsFixed(2)}', // Format the number to 2 decimal places
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shipping fee",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "\₹ 50",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Divider(height: 10, color: Colors.grey,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Discount",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '\₹ 50', // Fixed discount amount
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.green, // Color for discount text
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8), // Add some spacing between Discount and Total Payment
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Payment",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        Consumer<CartProvider>(
                          builder: (context, cart, child) {
                            int subtotal = cart.getTotalPrice(); // Use correct subtotal calculation
                            return Text(
                              '\₹ ${subtotal + 50 - 50}', // Adjust subtotal by subtracting discount and adding shipping fee
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.redAccent,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 40,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    backgroundColor: iconcolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    // Handle payment confirmation
                    showDialog(
                      context: context,
                      barrierDismissible: false, // Prevent dismiss on tap outside
                      builder: (BuildContext context) {
                        return Center(
                          child: CircularProgressIndicator(), // Loading indicator
                        );
                      },
                    );
                    await Future.delayed(Duration(seconds: 2));
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.success,
                      title: 'Order Confirmation',
                      text: 'We Will Reach Out you Soon.',
                      confirmBtnText: 'OK',
                      onConfirmBtnTap: () async {

                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await showNotification(
                          title: "Order confirmed,  ${ _username = prefs.getString('name') ?? ''}",
                          body: "🎉 Your order has been successfully placed! 🚀 \n Thank you for connecting with us.",

                          // summary: "Thissss is Basic Summary",
                          notificationLayout: NotificationLayout.BigPicture,

                          bigPicture:
                          "resource://drawable/launcher_icon",
                        );
                        final cartProvider = Provider.of<CartProvider>(context, listen: false);

                        // Clear the cart

                        //*****************************


                        // final cartProvider = Provider.of<CartProvider>(context, listen: false);
                        final selectedMemberProvider = Provider.of<SelectedMemberProvider>(context, listen: false);
                        final addressProvider = Provider.of<AddressProvider>(context, listen: false);
                        final dateTimeProvider = Provider.of<DateTimeProvider>(context, listen: false);

                        // Gather data
                        Childname = selectedMemberProvider.name;
                        childuserRelation = selectedMemberProvider.relation;
                        ChilduserPhone = selectedMemberProvider.phone;
                        childuserdob = selectedMemberProvider.dob;
                        Childusergender = selectedMemberProvider.gender;
                        childuseremail = selectedMemberProvider.email;

                        ParentchilduserAddress = addressProvider.address;
                        childuserHouseNo = addressProvider.houseNo;
                        childuserPinCode = addressProvider.pinCode;
                        childuserCity = addressProvider.cityName;
                        childuserState = addressProvider.stateName;

                        selectedDate = dateTimeProvider.selectedDate;
                        startTime = dateTimeProvider.selectedStartTime;
                        endTime = dateTimeProvider.selectedEndTime;

                        _userId = prefs.getString('user_id') ?? '';
                        _username = prefs.getString('name') ?? '';
                        _email = prefs.getString('email') ?? '';
                        _password = prefs.getString('password') ?? '';
                        _mobile = prefs.getString('mobile') ?? '';
                        _dob = prefs.getString('dob') ?? '';
                        _gender = prefs.getString('gender') ?? '';
                        _profileImg = prefs.getString('profile_img') ?? '';
                        _role = prefs.getString('role') ?? '';
                        _createdAt = prefs.getString('created_at') ?? '';
                        _updatedAt = prefs.getString('updated_at') ?? '';
                        // Total amount
                        totalAmount = cartProvider.getTotalPrice().toDouble();
                        List<TestCart> cartItems = await _cartFuture;
                        List<Map<String, dynamic>> cartItemsJson = cartItems.map((item) => item.toMap()).toList();
                        String cartItemsString = jsonEncode(cartItemsJson);

                        // ***********************8

                        // Prepare the details for printin
                        // Log the details
                        logger.i("User Details:");
                        logger.i("  Name: $Childname");
                        logger.i("  Relation: $childuserRelation");
                        logger.i("  Phone: $ChilduserPhone");
                        logger.i("  Date of Birth: $childuserdob");
                        logger.i("  Gender: $Childusergender");

                        logger.i("Address Details:");
                        logger.i("  Address: $ParentchilduserAddress");
                        logger.i("  House No: $childuserHouseNo");
                        logger.i("  Pin Code: $childuserPinCode");
                        logger.i("  City: $childuserCity");
                        logger.i("  State: $childuserState");

                        logger.i("Date and Time Details:");
                        logger.i("  Selected Date: $selectedDate");
                        logger.i("  Start Time: $startTime");
                        logger.i("  End Time: $endTime");

                        logger.i("User Preferences:");
                        logger.i("  User ID: $_userId");
                        logger.i("  Username: $_username");
                        logger.i("  Email: $_email");
                        logger.i("  Password: $_password");
                        logger.i("  Mobile: $_mobile");
                        logger.i("  Date of Birth: $_dob");
                        logger.i("  Gender: $_gender");
                        logger.i("  Profile Image: $_profileImg");
                        logger.i("  Role: $_role");
                        logger.i("  Created At: $_createdAt");
                        logger.i("  Updated At: $_updatedAt");

                        logger.i("Order Details:");
                        logger.i("  Total Amount: $totalAmount");
                        // Log cart items details
                        logger.i("Cart Items Details:");
                        for (var item in cartItemsJson) {
                          logger.i("  Item ID: ${item['id']}");
                          logger.i("  Rates: ${item['rates']}");
                          logger.i("  Sample Collection: ${item['sampleColl']}");
                          logger.i("  Reporting: ${item['reporting']}");
                          logger.i("  Tests: ${item['tests']}");
                        }
                        // Define additional fields
                        String orderStatus = 'Completed'; // Example values: 'Pending', 'Completed', 'Cancelled'
                        String paymentStatus = 'Paid'; // Example values: 'Paid', 'Unpaid'
                        String testReport = 'Generated'; // Example: URL or status of the test report
                        String sampleCollected = 'NO'; // Example values: 'Yes', 'No'
                        DateTime orderDate = DateTime.now();

                        String uniqueId = DateTime.now().millisecondsSinceEpoch.toString();
                        String OrderId = "#ORDERID${uniqueId.substring(uniqueId.length - 4)}";
                        // Create the order map
                        final Map<String, dynamic> orderByPatientsDetails = {
                          'userId': _userId,
                          'OrderId':OrderId,
                          'username': _username,
                          'email': _email,
                          'password': _password,
                          'mobile': _mobile,
                          'dob':_dob,
                          'gender':_gender,
                          'profileImg': _profileImg,
                          'role': _role,
                          'createdAt': _createdAt,
                          'updatedAt': _updatedAt,
                          'childName': Childname,
                          'childUserRelation': childuserRelation,
                          'childUserPhone': ChilduserPhone,
                          'childUserDob': childuserdob,
                          'childuseremail':childuseremail,
                          'parentChildUserAddress': ParentchilduserAddress,
                          'childUserHouseNo': childuserHouseNo,
                          'childUserPinCode': childuserPinCode,
                          'childUserCity': childuserCity,
                          'childUserState': childuserState,
                          'orderDate': orderDate.toIso8601String(),
                            'selectedDate': selectedDate?.toIso8601String(),
                          'startTime': startTime,
                          'endTime': endTime,
                          'totalAmount': totalAmount,
                          'cartItems': cartItemsJson,
                          'orderStatus': orderStatus,
                          'paymentStatus': paymentStatus,
                          'testReport': testReport,
                          'sampleCollected': sampleCollected,
                        };

                      // Log the order object
                        logger.i("Order Object: ${orderByPatientsDetails.toString()}");

                        // await cartProvider.clearCart();
                        // Call the API to create the order
                        try {
                          await _repository.addOrder(orderByPatientsDetails);
                          // Clear the cart
                          await cartProvider.clearCart();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => NavigationMenu()),
                                (Route<dynamic> route) => false,
                          );
                        } catch (e) {
                          print('Error creating order: $e');
                        }


                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => NavigationMenu()),
                              (Route<dynamic> route) => false,
                        );
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Confirm Payment',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
