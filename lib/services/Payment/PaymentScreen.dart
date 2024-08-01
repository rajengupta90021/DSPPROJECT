import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? _selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Payment Method'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RadioListTile<String>(
              title: Text('Google Pay'),
              value: 'Google Pay',
              groupValue: _selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value;
                });
              },
            ),
            RadioListTile<String>(
              title: Text('PhonePe'),
              value: 'PhonePe',
              groupValue: _selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value;
                });
              },
            ),
            RadioListTile<String>(
              title: Text('Cash on Delivery'),
              value: 'Cash on Delivery',
              groupValue: _selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_selectedPaymentMethod != null) {
                  // Handle payment based on selected method
                  switch (_selectedPaymentMethod) {
                    case 'Google Pay':
                    // Implement Google Pay payment logic
                      break;
                    case 'PhonePe':
                    // Implement PhonePe payment logic
                      break;
                    case 'Cash on Delivery':
                    // Implement Cash on Delivery logic
                      break;
                    default:
                      break;
                  }
                } else {
                  // Show a message to select a payment method
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please select a payment method.'),
                    ),
                  );
                }
              },
              child: Text('Proceed to Pay'),
            ),
          ],
        ),
      ),
    );
  }
}
