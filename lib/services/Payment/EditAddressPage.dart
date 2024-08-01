import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditAddressPage extends StatefulWidget {
  @override
  _EditAddressPageState createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController houseBlockController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController areaCityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController localityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PRADHAN NAGAR PATEL ROAD'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: Center(
                    child: Icon(Icons.map, size: 100, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: address1Controller,
                  decoration: InputDecoration(
                    labelText: 'Address 1',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Address 1';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: houseBlockController,
                  decoration: InputDecoration(
                    labelText: 'House/ Flat/ Block No',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter House/ Flat/ Block No';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: pinCodeController,
                        decoration: InputDecoration(
                          labelText: 'Pin Code',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Pin Code';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: areaCityController,
                        decoration: InputDecoration(
                          labelText: 'Area, City Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Area, City Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: stateController,
                  decoration: InputDecoration(
                    labelText: 'State Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter State Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: localityController,
                  decoration: InputDecoration(
                    labelText: 'Locality',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Locality';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: Text('Save Address'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}