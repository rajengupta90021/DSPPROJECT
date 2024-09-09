// terms_and_conditions_page.dart
import 'package:dspuiproject/constant/colors.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
        backgroundColor: iconcolor, // Attractive color for the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms and Conditions',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[900],
                ),
              ),
              SizedBox(height: 24),
              _buildSection(
                title: '1. Introduction',
                content: 'Welcome to our application. These Terms and Conditions govern your use of our app. By accessing or using the app, you agree to be bound by these terms. If you do not agree to these terms, please do not use our app.',
              ),
              _buildSection(
                title: '2. Use of the Application',
                content: 'You must use the app in accordance with the terms provided here. Unauthorized use of the app, including but not limited to hacking, data theft, or fraudulent activities, is strictly prohibited and may result in termination of your account.',
              ),
              _buildSection(
                title: '3. User Accounts',
                content: 'To access certain features of the app, you may need to create an account. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. Notify us immediately of any unauthorized use of your account.',
              ),
              _buildSection(
                title: '4. Intellectual Property',
                content: 'All content and materials on the app, including text, graphics, logos, and images, are owned by us or our licensors. You are granted a limited, non-exclusive, non-transferable license to use the content for personal, non-commercial purposes only. Any other use is prohibited without our prior written consent.',
              ),
              _buildSection(
                title: '5. Limitation of Liability',
                content: 'We are not liable for any indirect, incidental, special, or consequential damages, or loss of profits, data, or use arising from or related to your use of the app. Our total liability for any claim arising from your use of the app shall not exceed the amount you paid, if any, for accessing the app.',
              ),
              _buildSection(
                title: '6. Governing Law',
                content: 'These Terms and Conditions are governed by and construed in accordance with the laws of [Your Country]. Any disputes arising from or related to these terms shall be subject to the exclusive jurisdiction of the courts located in [Your Country].',
              ),
              _buildSection(
                title: '7. Changes to Terms',
                content: 'We reserve the right to update these Terms and Conditions at any time. Any changes will be posted on this page with an updated effective date. Your continued use of the app following any changes signifies your acceptance of the revised terms.',
              ),
              _buildSection(
                title: '8. Contact Us',
                content: 'If you have any questions or concerns about these Terms and Conditions, please contact us at [contactDsp@gmail.com]. We are committed to addressing any issues or queries you may have.',
              ),
              _buildSection(
                title: '9. Privacy Policy',
                content: 'Our Privacy Policy explains how we collect, use, and protect your personal information. By using the app, you agree to our Privacy Policy. Please review it to understand our practices regarding your data.',
              ),
              _buildSection(
                title: '10. Termination',
                content: 'We may terminate or suspend your access to the app at our sole discretion, without notice, for conduct that we believe violates these Terms and Conditions or is harmful to other users or the app itself.',
              ),
              _buildSection(
                title: '11. Disclaimer',
                content: 'The app is provided "as is" and "as available" without any warranties of any kind. We do not guarantee the app will be available, error-free, or uninterrupted. Your use of the app is at your own risk.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[800],
            ),
          ),
          SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.6, // Increased line height for better readability
            ),
          ),
        ],
      ),
    );
  }
}
