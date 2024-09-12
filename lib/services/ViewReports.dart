import 'package:dspuiproject/constant/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewReports extends StatefulWidget {
  const ViewReports({super.key});

  @override
  State<ViewReports> createState() => _ViewReportsState();
}

class _ViewReportsState extends State<ViewReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'View Reports',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: iconcolor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/noReports.gif', // Ensure this path matches your assets directory
                height: 80, // Adjust height as needed
                width: 80,  // Adjust width as needed
              ),
              SizedBox(height: 16),
              Text(
                'No reports available',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
