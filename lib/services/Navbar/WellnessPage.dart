import 'package:dspuiproject/constant/colors.dart';
import 'package:flutter/material.dart';

class WellnessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Wellness'),
        backgroundColor: iconcolor, // You can adjust the color as needed
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Welcome to the Wellness section! Here you can find various resources and options to help you maintain your health and well-being.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            _buildWellnessOption(
              context: context,
              title: 'Health Tips',
              description: 'Read the latest health tips to stay healthy.',
              icon: Icons.health_and_safety,
              onTap: () {
                // Handle tap to show health tips
              },
            ),
            _buildWellnessOption(
              context: context,
              title: 'Book an Appointment',
              description: 'Schedule a wellness check-up or consultation.',
              icon: Icons.calendar_today,
              onTap: () {
                // Handle tap to book an appointment
              },
            ),
            _buildWellnessOption(
              context: context,
              title: 'Wellness Resources',
              description: 'Access a variety of wellness resources and articles.',
              icon: Icons.library_books,
              onTap: () {
                // Handle tap to view wellness resources
              },
            ),
            _buildWellnessOption(
              context: context,
              title: 'Contact Support',
              description: 'Get in touch with our support team for any wellness-related queries.',
              icon: Icons.contact_support,
              onTap: () {
                // Handle tap to contact support
              },
            ),
            // Add more options as needed
          ],
        ),
      ),
    );
  }

  Widget _buildWellnessOption({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
      leading: Icon(icon, color: Colors.green),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(description),
      onTap: onTap,
    );
  }
}
