import 'dart:convert';

import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/UserAddress.dart';
import '../../constant/colors.dart';
import '../../repository/UserAddressRepository.dart';
import 'SelectAnAdress.dart';
import 'package:http/http.dart' as http;
class UpdateAddressPage extends StatefulWidget {
  final String address;
  final String houseNo;
  final String phoneNo;
  final String pinCode;
  final String cityName;
  final String stateName;
  final String locality;

  UpdateAddressPage({
    required this.address,
    required this.houseNo,
    required this.phoneNo,
    required this.pinCode,
    required this.cityName,
    required this.stateName,
    required this.locality,
  });

  @override
  _UpdateAddressPageState createState() => _UpdateAddressPageState();
}

class _UpdateAddressPageState extends State<UpdateAddressPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController address1Controller;
  late TextEditingController houseBlockController;
  late TextEditingController pinCodeController;
  late TextEditingController areaCityController;
  late TextEditingController stateController;
  late TextEditingController localityController;
  late TextEditingController phoneNumberController;
  final TextEditingController countryController = TextEditingController();
  String? userId;
  final AddressRepository addressRepository = AddressRepository();
  String pinCodeDetails = "";
  String? selectedLocality;
  @override
  void initState() {
    super.initState();
    address1Controller = TextEditingController(text: widget.address);
    houseBlockController = TextEditingController(text: widget.houseNo);
    phoneNumberController = TextEditingController(text: widget.phoneNo);
    pinCodeController = TextEditingController(text: widget.pinCode);
    areaCityController = TextEditingController(text: widget.cityName);
    stateController = TextEditingController(text: widget.stateName);
    localityController = TextEditingController(text: widget.locality);
    pinCodeController.addListener(_onPinCodeChanged);
    selectedLocality = 'Yes';
    _loadUsername();
  }

  @override
  void dispose() {
    pinCodeController.removeListener(_onPinCodeChanged);
    pinCodeController.dispose();
    address1Controller.dispose();
    houseBlockController.dispose();
    phoneNumberController.dispose();
    areaCityController.dispose();
    stateController.dispose();
    localityController.dispose();
    super.dispose();
  }
  void _onPinCodeChanged() {
    final pinCode = pinCodeController.text;
    if (pinCode.length == 6) {  // Assuming a valid pin code is 6 digits
      getDataFromPinCode(pinCode);
    }
  }
  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('user_id') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Update Address',style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: iconcolor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset('assets/address.png',
                          width: 80.0, // Set the desired width
                          height: 80.0, // Set the desired height
                          fit: BoxFit.cover,),
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: Text(
                          'Enter your address details below:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: address1Controller,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          hintText: 'Enter address line 1',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Address 1';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 26),
                      TextFormField(
                        controller: houseBlockController,
                        decoration: InputDecoration(
                          labelText: 'House/ Flat/ Block No',
                          hintText: 'Enter house/flat/block number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter House/ Flat/ Block No';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 26),
                      TextFormField(
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                          labelText: 'Mobile Number',
                          prefixText: '+91 ',
                          prefixStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a mobile number';
                          }
                          RegExp mobileRegex = RegExp(r'^\+?[1-9]\d{9}$');
                          if (!mobileRegex.hasMatch(value)) {
                            return 'Please enter a valid mobile number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 26),
                      TextFormField(
                        controller: pinCodeController,
                        decoration: InputDecoration(
                          labelText: 'Pin Code',
                          hintText: 'Enter pin code',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Pin Code';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        controller: areaCityController,
                        decoration: InputDecoration(
                          labelText: 'City Name',
                          hintText: 'Enter area or city',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Area, City Name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 26),
                      TextFormField(
                        controller: stateController,
                        decoration: InputDecoration(
                          labelText: 'State Name',
                          hintText: 'Enter state name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter State Name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 26),
                      DropdownButtonFormField<String>(
                        value: selectedLocality,
                        decoration: InputDecoration(
                          labelText: 'Locality',
                          hintText: 'Select locality',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        items: ['Yes', 'No'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            localityController.text = newValue!;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a locality option';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 26),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                  await Future.delayed(Duration(seconds: 2));

                  String addressDetails =
                      '${address1Controller.text}\n'
                      '${houseBlockController.text}\n'
                      '${phoneNumberController.text}\n'
                      '${pinCodeController.text}\n'
                      '${areaCityController.text}\n'
                      '${stateController.text}\n'
                      '${localityController.text}';

                  bool addressUpdated = await addressRepository.updateUserAddress(userId!, addressDetails);

                  Navigator.pop(context);
                  if (addressUpdated) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Address updated successfully')),
                    );
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => SelectAnAddress()),
                    // );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to save address')),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 110, vertical: 15),
                backgroundColor: iconcolor,
              ),
              child: Text(
                'Save Address',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future<void> getDataFromPinCode(String pinCode) async {
    final url = "http://www.postalpincode.in/api/pincode/$pinCode";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['Status'] == 'Error') {
          // Show a snackbar if the PIN code is not valid
          showSnackbar(context, "Pin Code is not valid. ");
          setState(() {
            pinCodeDetails = 'Pin code is not valid.';
          });
        } else {
          // Parse and display details if the PIN code is valid
          final postOfficeArray = jsonResponse['PostOffice'] as List;
          final obj = postOfficeArray[0];

          final district = obj['District'];
          final state = obj['State'];
          final country = obj['Country'];

          setState(() {
            pinCodeDetails =
            'Details of pin code are:\nDistrict: $district\nState: $state\nCountry: $country';
            areaCityController.text = district;
            stateController.text = state;
          });
        }
      } else {
        // Show a snackbar if there is an issue fetching data
        showSnackbar(context, "Failed to fetch data. Please try again");
        setState(() {
          pinCodeDetails = 'Failed to fetch data. Please try again.';
        });
      }
    } catch (e) {
      // Show a snackbar if an error occurs during the API call
      showSnackbar(context, "Error Occurred. Please try again");
      setState(() {
        pinCodeDetails = 'Error occurred. Please try again.';
      });
    }
  }

  // Function to display a snackbar with a specified message
  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2), // Adjust the duration as needed
      ),
    );
  }
}

