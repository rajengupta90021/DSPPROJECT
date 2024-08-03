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

import 'UpdateAdressPage.dart';

class SelectAnAddress extends StatefulWidget {
  @override
  _SelectAnAddressState createState() => _SelectAnAddressState();
}

class _SelectAnAddressState extends State<SelectAnAddress> {
  List<UserAdress> _addresses = [];
  String? userId;
  bool _isLoading = true;
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
      final repository = AddressRepository();
      List<UserAdress> addresses = await repository.fetchUserAddresses(userId!);
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
      body: _isLoading ? Center(child: CircularProgressIndicator()):Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_addresses.isNotEmpty) ...[
              Text(
                'Saved Addresses',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: ListView.builder(
                  itemCount: _addresses.length,
                  itemBuilder: (context, index) {
                    final addressData = _addresses[index].data;
                    final addressText = addressData?.currentAddress ?? '';
                    final formattedAddressText = _extractAddressDetails(addressText);
                    final addressComponents = _extractAddressComponents(addressText);


                    return GestureDetector(
                      onTap: () {
                        print('Selected address: $formattedAddressText');
                      },
                      child: Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.blueGrey.shade700,
                                size: 30,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Address',
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
                                icon: Icon(Icons.edit, color: Colors.blueAccent),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateAddressPage(

                                        address: addressComponents['address'] ?? '',
                                        houseNo: addressComponents['houseNo'] ?? '',
                                        phoneNo: addressComponents['phoneNo'] ?? '',
                                        pinCode: addressComponents['pinCode'] ?? '',
                                        cityName: addressComponents['cityName'] ?? '',
                                        stateName: addressComponents['stateName'] ?? '',
                                        locality: addressComponents['locality'] ?? '',

                                      ),
                                    ),
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddNewAddress(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min, // Makes the button width fit its content
                            children: [
                              Text(
                                'Add New Address',
                                style: TextStyle(color: Colors.black, fontSize: 15),
                              ),
                              SizedBox(width: 8), // Space between text and icon
                              Icon(Icons.add,color: Colors.black,),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12), backgroundColor: iconcolor, // Background color
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.zero, // Sharp, rectangular corners
                            // ),
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
          onPressed: () {
           if(_addresses.isNotEmpty){

             // Store selected address in provider
             final addressProvider = Provider.of<AddressProvider>(context, listen: false);

             // Assuming the first address is selected
             final selectedAddress = _addresses[0].data?.currentAddress ?? '';

             final addressComponents = _extractAddressComponents(selectedAddress);
             addressProvider.setAddress(addressComponents['address'] ?? '');
             addressProvider.setHouseNo(addressComponents['houseNo'] ?? '');
             addressProvider.setPhoneNo(addressComponents['phoneNo'] ?? '');
             addressProvider.setPinCode(addressComponents['pinCode'] ?? '');
             addressProvider.setCityName(addressComponents['cityName'] ?? '');
             addressProvider.setStateName(addressComponents['stateName'] ?? '');
             addressProvider.setLocality(addressComponents['locality'] ?? '');

             Navigator.push(
               context,
               MaterialPageRoute(
                 builder: (context) => SelectFamilyMember(),
               ),
             );

           }
           else{
             ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text('Please add address')),
             );
           }
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
    // Split the address string by newline characters
    final addressLines = address.split('\n');

    // Define the labels for each line
    final labels = [
      'Address',
      'House No',
      'Phone No',
      'Pincode',
      'City Name',
      'State Name',
      'Locality'
    ];

    // Create a map to store the formatted address
    final addressMap = <String, String>{};

    // Map each line to a label if available
    for (int i = 0; i < addressLines.length; i++) {
      if (i < labels.length) {
        addressMap[labels[i]] = addressLines[i].trim();
      }
    }

    // Format the address text with labels and their values
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
