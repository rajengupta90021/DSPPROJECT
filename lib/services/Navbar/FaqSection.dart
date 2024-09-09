import 'package:dspuiproject/constant/colors.dart';
import 'package:flutter/material.dart';

class FaqSectionNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('FAQ'),
        backgroundColor: iconcolor, // You can adjust the color as needed
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildFaqItem(
              question: 'What is this app about?',
              answer: 'This app allows you to book various medical tests conveniently from your phone. You can search for tests, view details, and add them to your cart for easy checkout.',
            ),
            _buildFaqItem(
              question: 'How do I book a test?',
              answer: 'To book a test, search for the test you need using the search bar, view the details, and then add the test to your cart. Proceed to checkout when you are ready to complete your purchase.',
            ),
            _buildFaqItem(
              question: 'What should I do if I encounter issues?',
              answer: 'If you encounter any issues while using the app, please contact our support team through the "Contact Us" section or use the "Report an Issue" feature.',
            ),
            _buildFaqItem(
              question: 'How can I update my profile?',
              answer: 'You can update your profile information by going to the "Profile" section in the app. From there, you can edit your details and save the changes.',
            ),
            _buildFaqItem(
              question: 'Is my personal information secure?',
              answer: 'Yes, your personal information is secure. We use industry-standard encryption to protect your data and ensure privacy.',
            ),
            // Add more FAQ items as needed
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem({required String question, required String answer}) {
    return ExpansionTile(
      title: Text(question, style: TextStyle(fontWeight: FontWeight.bold)),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(answer),
        ),
      ],
    );
  }
}
