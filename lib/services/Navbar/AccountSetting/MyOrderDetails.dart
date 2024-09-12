import 'dart:convert';
import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../Model/MyOrder.dart'; // Update this import as per your project structure
import '../../../Model/MyOrderDetails.dart';
import '../../../constant/colors.dart'; // Update this import as per your project structure

class OrderDetailsPage extends StatefulWidget {
  final OrderDetails orderDetails;

  const OrderDetailsPage({Key? key, required this.orderDetails}) : super(key: key);

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  List<StepperData> stepperData = [
    StepperData(

        subtitle: StepperText("Your order has been placed"),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.looks_one, color: Colors.white),
        )),
    StepperData(
        // title: StepperText("Preparing"),
        subtitle: StepperText("We will Catch you soon"),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: iconcolor,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.looks_two, color: Colors.white),
        )),
    StepperData(
        subtitle: StepperText(
            "Sample Collected Conformed"),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: iconcolor,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.looks_3, color: Colors.white),
        )),
    StepperData(
        title: StepperText("Test Reports",
            textStyle: const TextStyle(color: Colors.grey)),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: iconcolor,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.looks_4, color: Colors.white),
        )),
  ];
  @override
  Widget build(BuildContext context) {
    // Extracting details from the widget.order
    List<CartItems> cartItemsList = widget.orderDetails.cartItems ?? [];
    String cartItemsFormatted = cartItemsList.asMap().entries.map((entry) {
      int index = entry.key;
      var item = entry.value;
      return '${index + 1}. ${item.tests}';
    }).join('\n');

    DateTime? selectedDate = widget.orderDetails.selectedDate != null
        ? DateTime.tryParse(widget.orderDetails.selectedDate!)
        : null;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Order Details",style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: iconcolor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 5,right: 10),
                child: AnotherStepper(
                  stepperList: stepperData,
                  stepperDirection: Axis.horizontal,
                  iconWidth: 40,
                  iconHeight: 40,
                  activeBarColor: Colors.green,
                  inActiveBarColor: Colors.grey,
                  inverted: true,
                  verticalGap: 30,
                  activeIndex: 1,
                  barThickness: 5,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "ORDER DETAILS",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Background color
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order Created",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    Text(
                      selectedDate != null
                          ? DateFormat('dd/MM/yyyy').format(selectedDate)
                          : 'N/A',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 10),

              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Background color
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order ID",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    Text(
                      "${widget.orderDetails.OrderId}",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "TIME FOR CONSULTING",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Background color
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Date",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    Text(
                      selectedDate != null
                          ? DateFormat('dd/MM/yyyy').format(selectedDate)
                          : 'N/A',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Background color
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "START TIME  ",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    Text(
                      "7:00 pm",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),

                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Background color
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "END TIME  ",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    Text(
                      "8:00 PM",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              Text(
                "ORDER STATUS",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Background color
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "order status ",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    Text(
                      (widget.orderDetails.orderStatus ?? 'N/A').toUpperCase(), // Convert to uppercase
                      style: TextStyle(
                        color: widget.orderDetails.orderStatus != null ? Colors.red : Colors.red,
                        fontSize: 16,
                      ),
                    ),


                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Background color
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Payment status",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    Text(
                      (widget.orderDetails.paymentStatus ?? 'N/A').toUpperCase(), // Convert to uppercase
                      style: TextStyle(
                        color: widget.orderDetails.orderStatus != null ? Colors.red : Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Background color
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Test report ",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    Text(
                      (widget.orderDetails.testReport ?? 'N/A').toUpperCase(), // Convert to uppercase
                      style: TextStyle(
                        color: widget.orderDetails.orderStatus != null ? Colors.red : Colors.red,
                        fontSize: 16,
                      ),
                    ),


                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Background color
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "sampleCollected",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    Text(
                      (widget.orderDetails.sampleCollected ?? 'N/A').toUpperCase(), // Convert to uppercase
                      style: TextStyle(
                        color: widget.orderDetails.orderStatus != null ? Colors.red : Colors.red,
                        fontSize: 16,
                      ),
                    ),


                  ],
                ),
              ),

              SizedBox(height: 20),

              Text(
                "ORDER ITEM",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Background color
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${cartItemsFormatted}",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),

                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Background color
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Bill",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    Text(
                      "${widget.orderDetails.totalAmount}",
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "ADDRESS DETAILS",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              _buildDetailCard("Address :", widget.orderDetails.parentChildUserAddress ?? ''),
              _buildDetailCard("House No:", widget.orderDetails.childUserHouseNo ?? ''),
              _buildDetailCard("Pin Code:", widget.orderDetails.childUserPinCode ?? ''),
              _buildDetailCard("City:", widget.orderDetails.childUserCity ?? ''),
              _buildDetailCard("State:", widget.orderDetails.childUserState ?? ''),
              SizedBox(height: 20),
              Text(
                "PATIENT DETAILS",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Background color
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "name",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    Text(
                      "${widget.orderDetails.childName}",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Background color
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Phone number",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    Text(
                      "${widget.orderDetails.childUserPhone}",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Background color
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Relations",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    Text(
                      "${widget.orderDetails.childUserRelation}",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Background color
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    Text(
                      "${widget.orderDetails.email}",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildDetailCard(String title, String value) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200], // Background color
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.black54, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
