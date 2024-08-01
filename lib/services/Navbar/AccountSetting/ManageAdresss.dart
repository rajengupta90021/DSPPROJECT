import 'package:flutter/material.dart';
import '../../Payment/EditAddressPage.dart'; // Adjust import path as per your project structure

class ManageAddressPage extends StatefulWidget {
  @override
  _ManageAddressPageState createState() => _ManageAddressPageState();
}

class _ManageAddressPageState extends State<ManageAddressPage> {
  final List<Map<String, String>> addresses = [
    {
      'type': 'Home',
      'address':
      'PRADHAN NAGAR PATEL ROAD, Institute of Technology, Ward No 3, Pradhan Nagar, India, Siliguri, West Bengal, 734003',
    },
    {
      'type': 'Home',
      'address':
      'HILL CART ROAD MALAGURI, New Sofa House, Shiv Nagar, Ujanu P, India, Siliguri, West Bengal, 734003',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Address'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Saved Addresses',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  return AddressItem(
                    type: addresses[index]['type']!,
                    address: addresses[index]['address']!,
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditAddressPage(),
                        ),
                      );
                    },
                    onDelete: () {
                      _showDeleteConfirmationDialog(index);
                    },
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditAddressPage(),
                    ),
                  );
                },
                child: Text(
                  'ADD NEW ADDRESS',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Address'),
          content: Text('Are you sure you want to delete this address?', style: TextStyle(fontSize: 18),),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                setState(() {
                  addresses.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class AddressItem extends StatelessWidget {
  final String type;
  final String address;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const AddressItem({
    required this.type,
    required this.address,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.home,
              color: Colors.blue,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    address,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
