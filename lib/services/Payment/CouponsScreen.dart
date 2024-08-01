import 'package:dspuiproject/constant/colors.dart';
import 'package:flutter/material.dart';

class CouponsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          child: Center(child: Text('Coupons')),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            // Handle back navigation
          },
        ),
        backgroundColor: iconcolor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 30,),
            _buildCouponInputField(),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Coupons not availablee',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCouponInputField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Enter Coupon Code',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            ),
          ),
        ),
        SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            // Handle apply coupon
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16), backgroundColor: iconcolor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text('Apply',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
        ),
      ],
    );
  }
}
