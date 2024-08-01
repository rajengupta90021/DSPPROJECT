import 'package:flutter/material.dart';

import '../../constant/colors.dart';


class ReportIssuePage extends StatefulWidget {
  @override
  _ReportIssuePageState createState() => _ReportIssuePageState();
}

class _ReportIssuePageState extends State<ReportIssuePage> {
  final TextEditingController _feedbackController = TextEditingController();
  final int _maxLength = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report An Issue'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back action
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'We would love to hear about your experience using the app.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: Container(

                  child: TextFormField(
                    controller: _feedbackController,
                    maxLength: _maxLength,
                    maxLines: 5,
                    // expands: true,
                    decoration: InputDecoration(
                      hintText: 'Write here...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle submit action
                    print(_feedbackController.text);
                  },
                  child: Text('SUBMIT',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 17),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: iconcolor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
