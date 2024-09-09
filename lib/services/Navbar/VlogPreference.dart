import 'package:dspuiproject/constant/colors.dart';
import 'package:flutter/material.dart';

class VlogPreference extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Vlog Preference'),
        backgroundColor: iconcolor, // You can adjust the color as needed
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Manage your vlog preferences and view your favorite vlogs here.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            _buildPreferenceOption(
              context: context,
              title: 'Preferred Vlog Categories',
              description: 'Choose your favorite vlog categories.',
              onTap: () {
                // Handle tap to choose categories
              },
            ),
            _buildPreferenceOption(
              context: context,
              title: 'Notification Preferences',
              description: 'Set your preferences for vlog notifications.',
              onTap: () {
                // Handle tap to set notification preferences
              },
            ),
            _buildPreferenceOption(
              context: context,
              title: 'View Vlogs',
              description: 'Watch the latest vlogs based on your preferences.',
              onTap: () {
                // Handle tap to view vlogs
              },
            ),
            // Add more options as needed
          ],
        ),
      ),
    );
  }

  Widget _buildPreferenceOption({
    required BuildContext context,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
      leading: Icon(Icons.settings), // You can use different icons based on the option
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(description),
      onTap: onTap,
    );
  }
}
