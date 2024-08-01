import 'package:dspuiproject/constant/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BookingDate.dart';
import 'EditAddressPage.dart';

class ChangeAnAdress extends StatefulWidget {
  @override
  _ChangeAnAdressState createState() => _ChangeAnAdressState();
}

class _ChangeAnAdressState extends State<ChangeAnAdress> {
  int _selectedAddressIndex = -1; // No address selected by default

  final List<Map<String, String>> _addresses = [
    {
      'label': 'Home',
      'address':
      'PRADHAN NAGAR PATEL ROAD, Institute of Technology, Ward No 3, Pradhan Nagar, India, Siliguri, West Bengal, 734003'
    },
    {
      'label': 'Home',
      'address':
      'HILL CART ROAD MALAGURI, New Sofa House, Shiv Nagar, Ujanu P, India, Siliguri, West Bengal, 734003'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.grey,
        title: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text('Select An Address'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Saved Addresses',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _addresses.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAddressIndex = index;
                      });
                      print('Selected address: ${_addresses[index]['address']}');
                    },
                    child: Card(
                      elevation: 3,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      color: _selectedAddressIndex == index ? null : Colors.blueGrey.shade50,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: _selectedAddressIndex == index ? Colors.black : Colors.transparent,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        leading: Radio(
                          value: index,
                          groupValue: _selectedAddressIndex,
                          onChanged: (value) {
                            setState(() {
                              _selectedAddressIndex = value as int;
                            });
                            print('Selected index: $value');
                            print('Selected address: ${_addresses[index]['address']}');
                          },
                        ),
                        title: Text(
                          _addresses[index]['label']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(_addresses[index]['address']!),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Implement edit functionality
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EditAddressPage()));
                          },
                        ),
                        selected: _selectedAddressIndex == index,
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement add new address functionality
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditAddressPage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add New Address',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  Icon(Icons.add),
                ],
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                backgroundColor: iconcolor,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Implement book a slot functionality
                Navigator.push(context, MaterialPageRoute(builder: (context) => BookingDate()));
              },
              child: Text(
                'BOOK A SLOT',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 120, vertical: 12),
                backgroundColor: iconcolor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
