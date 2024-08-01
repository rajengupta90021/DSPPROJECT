import 'package:dspuiproject/services/BottomNavigationfooter/NavigationMenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../constant/colors.dart';
import '../../provider/CartProvider.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  int type = 4; // Default to Cash On Delivery

  void handleRadio(int? e) => setState(() {
    type = e!;
  });

  @override
  void initState() {
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
                Divider(height: 30, color: Colors.grey,),
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
                          '\₹ ${subtotal + 50}', // Add shipping fee
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
                SizedBox(height: 40,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    backgroundColor: iconcolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Handle payment confirmation
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.success,
                      title: 'Order Confirmation',
                      text: 'We Will Reach Out you Soon.',
                      confirmBtnText: 'OK',
                      onConfirmBtnTap: () {
                        // Handle additional actions if needed
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
