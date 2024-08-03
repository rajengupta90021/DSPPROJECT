import 'package:dspuiproject/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Model/UserAddress.dart';
import '../../../provider/AddressControlller.dart';
import '../../../repository/UserAddressRepository.dart';
import '../../Payment/AddNewAddress.dart';
import '../../Payment/UpdateAdressPage.dart';
import '../../family_member_widgets/FamilyMember.dart'; // Adjust import path as per your project structure

class ManageAddressPage extends StatefulWidget {
  @override
  _ManageAddressPageState createState() => _ManageAddressPageState();
}

class _ManageAddressPageState extends State<ManageAddressPage> {
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
        centerTitle: true,
        backgroundColor: iconcolor,
        title: Text('Manage Address'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
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
                  _addresses.removeAt(index);
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
