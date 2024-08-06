import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/UserAddress.dart';
import '../../provider/AddressControlller.dart';
import '../../repository/UserAddressRepository.dart';
import 'AddNewAddress.dart';

import '../family_member_widgets/FamilyMember.dart';
import 'BookingDate.dart';
import 'package:dspuiproject/constant/colors.dart';

class SelectAnAddress extends StatefulWidget {
  @override
  _SelectAnAddressState createState() => _SelectAnAddressState();
}

class _SelectAnAddressState extends State<SelectAnAddress> {
  List<Object> _addresses = [];
  String? userId;
  bool _isLoading = true;
  final AddressRepository _addressRepository = AddressRepository();
  late Future<List<UserAddress>> addressesFuture;
  String? _selectedAddressId; // Track selected address ID

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('user_id') ?? '';
    });
    if (userId != null && userId!.isNotEmpty) {
      List<Object> addresses = await _addressRepository.fetchCurrentAddresses(userId!);
      setState(() {
        _addresses = addresses;
      });
    } else {
      print('User ID is null or empty');
    }
    setState(() {
      _isLoading = false; // Update loading state
    });
  }
  void _onAddressSelected(String addressId, Map<String, String> addressComponents) {
    setState(() {
      _selectedAddressId = addressId;
    });

    // Update the AddressProvider with selected address details
    final addressProvider = Provider.of<AddressProvider>(context, listen: false);
    addressProvider.setAddress(addressComponents['address'] ?? '');
    addressProvider.setHouseNo(addressComponents['houseNo'] ?? '');
    addressProvider.setPhoneNo(addressComponents['phoneNo'] ?? '');
    addressProvider.setPinCode(addressComponents['pinCode'] ?? '');
    addressProvider.setCityName(addressComponents['cityName'] ?? '');
    addressProvider.setStateName(addressComponents['stateName'] ?? '');
    addressProvider.setLocality(addressComponents['locality'] ?? '');

    print('Selected Address:\n$addressId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: iconcolor,
        centerTitle: true,
        shadowColor: Colors.grey,
        title: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text('Select An Address'),
        ),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_addresses.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Saved Addresses',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: InkWell(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddNewAddress(),
                          ),
                        );
                        if (result == true) {
                          // Refresh the address list
                          setState(() {
                            _isLoading = true;
                          });
                          await _loadUsername(); // Reload addresses
                        }
                      },
                      child: Image.asset('assets/addressicon.png', width: 24, height: 24),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                child: Expanded(
                  child: ListView.builder(
                    itemCount: _addresses.length,
                    itemBuilder: (context, index) {
                      final addressData = _addresses[index];
                      final addressText = addressData.toString();
                      final formattedAddressText = _extractAddressDetails(addressText);
                      final addressComponents = _extractAddressComponents(addressText);


                      return GestureDetector(
                        onTap: () => _onAddressSelected(formattedAddressText,addressComponents),
                        child: Card(
                          elevation: 5,
                          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            side: BorderSide(
                              color: _selectedAddressId == formattedAddressText ? iconcolor : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: formattedAddressText,
                                  groupValue: _selectedAddressId,
                                  onChanged: (value) {
                                    _onAddressSelected(value!,addressComponents);
                                  },
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Address ${index+1}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.blueGrey.shade800,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        formattedAddressText,
                                        style: TextStyle(
                                          color: Colors.blueGrey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: iconcolor),
                                  onPressed: () {
                                    // print("Address Text: $addressText");
                                    // print("Formatted Address Text: $formattedAddressText");
                                    // print("Address Components: $addressComponents");

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Confirm Delete'),
                                          content: Text('Are you sure you want to delete this address?'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('Cancel'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: Text('Delete'),
                                              onPressed: () async {
                                                bool deleteResult = await _addressRepository.deleteAddress(userId!, addressText);
                                                if (deleteResult) {
                                                  setState(() {
                                                    _addresses.remove(addressData);
                                                  });
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text('Address deleted successfully')),
                                                  );
                                                } else {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text('Failed to delete address')),
                                                  );
                                                }
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ] else ...[
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Container(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddNewAddress(),
                              ),
                            );
                            if (result == true) {
                              // Refresh the address list
                              setState(() {
                                _isLoading = true;
                              });
                              await _loadUsername(); // Reload addresses
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Add New Address',
                                style: TextStyle(color: Colors.black, fontSize: 15),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.add, color: Colors.black,),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            backgroundColor: iconcolor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () async {

            if (_addresses.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('No addresses available please add address')),
              );
            } else if (_selectedAddressId == null || _selectedAddressId!.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please select an address or add new address')),
              );
            } else {



              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectFamilyMember(),
                ),
              );
            }

            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text('Please add address')),
            // );
          },
          child: Text(
            'BOOK A SLOT',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 120, vertical: 12),
            backgroundColor: iconcolor,
          ),
        ),
      ),
    );
  }

  String _extractAddressDetails(String address) {
    final addressLines = address.split('\n');
    final labels = [
      'Address',
      'House No',
      'Phone No',
      'Pincode',
      'City Name',
      'State Name',
      'Locality'
    ];
    final addressMap = <String, String>{};
    for (int i = 0; i < addressLines.length; i++) {
      if (i < labels.length) {
        addressMap[labels[i]] = addressLines[i].trim();
      }
    }
    final formattedAddress = addressMap.entries
        .map((entry) => '${entry.key}: ${entry.value}')
        .where((entry) => entry.isNotEmpty)
        .join('\n');
    return formattedAddress;
  }

  Map<String, String> _extractAddressComponents(String address) {
    final addressLines = address.split('\n');
    return {
      'address': addressLines.isNotEmpty ? addressLines[0].trim() : '',
      'houseNo': addressLines.length > 1 ? addressLines[1].trim() : '',
      'phoneNo': addressLines.length > 2 ? addressLines[2].trim() : '',
      'pinCode': addressLines.length > 3 ? addressLines[3].trim() : '',
      'cityName': addressLines.length > 4 ? addressLines[4].trim() : '',
      'stateName': addressLines.length > 5 ? addressLines[5].trim() : '',
      'locality': addressLines.length > 6 ? addressLines[6].trim() : '',
    };
  }
}
