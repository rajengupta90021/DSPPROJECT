import 'package:flutter/material.dart';
import '../Model/UserAddress.dart'; // Replace with your UserAddress model
import '../repository/UserAddressRepository.dart'; // Replace with your repository file

class UpdateAddressScreen extends StatefulWidget {
  @override
  _UpdateAddressScreenState createState() => _UpdateAddressScreenState();
}

class _UpdateAddressScreenState extends State<UpdateAddressScreen> {
  final String userId = 'hRLvJBry4MLyNqOrJwx7'; // Replace with your user ID
  final AddressRepository _addressRepository = AddressRepository();
   List<Object> _currentAddresses = [];

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    try {
      List<Object> addresses = await _addressRepository.fetchCurrentAddresses(userId);
      setState(() {
        _currentAddresses = addresses;
      });
    } catch (e) {
      print('Error loading addresses: $e');
      setState(() {
        _currentAddresses = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Addresses'),
      ),
      body: _currentAddresses.isEmpty
          ? Center(
        child:CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _currentAddresses.length,
        itemBuilder: (context, index) {
          // Assuming each item is a String
          String address = _currentAddresses[index] as String;
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text('Address ${index + 1}:'),
              subtitle: Text(address),
            ),
          );
        },
      ),
    );
  }
}
