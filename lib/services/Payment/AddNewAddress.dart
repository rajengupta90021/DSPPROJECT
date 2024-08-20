import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/UserAddress.dart';
import '../../constant/colors.dart';
import '../../repository/UserAddressRepository.dart';
import '../../widgets/LoadingOverlay.dart';
import '../../widgets/SnackBarUtils.dart';
import 'SelectAnAdress.dart';
import 'package:http/http.dart' as http;
class AddNewAddress extends StatefulWidget {
  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController houseBlockController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController areaCityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController localityController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  String pinCodeDetails = "";// New controller for phone number
  String? userId;
  String selectedLocality = 'Yes';
  bool loading = false;
  final AddressRepository addressRepository = AddressRepository();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pinCodeController.addListener(_onPinCodeChanged);

    _loadUsername();
    localityController.text = selectedLocality;
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
        backgroundColor: iconcolor,
        centerTitle: true,
        title: Text("add an address"),
      ),
      body: Stack(
        children: [
          Padding(
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
                            child: Image.asset(
                              'assets/address.png',
                              width: 80.0, // Set the desired width
                              height: 80.0, // Set the desired height
                              fit: BoxFit.cover,
                            ),
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
                                selectedLocality = newValue!;
                                localityController.text = newValue;
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
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });

                        String addressDetails =
                            '${address1Controller.text}\n'
                            '${houseBlockController.text}\n'
                            '${phoneNumberController.text}\n'
                            '${pinCodeController.text}\n'
                            '${areaCityController.text}\n'
                            '${stateController.text}\n'
                            '${localityController.text}';

                        // Print the concatenated string with new lines
                        print(addressDetails);
                        print(localityController.text);
                        bool address = await addressRepository.CreateOrUpdate(userId!, addressDetails);
                        if (address) {
                          setState(() {
                            loading = false;
                          });
                          SnackBarUtils.showSuccessSnackBar(context, "Address saved successfully");
                          Navigator.pop(context, address);
                        } else {
                          setState(() {
                            loading = false;
                          });
                          SnackBarUtils.showErrorSnackBar(context, "Failed to save address");
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
                ),
              ],
            ),
          ),
          if (loading) LoadingOverlay(isLoading: loading), // Overlay for loading
        ],
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
          SnackBarUtils.showErrorSnackBar(context, "Pin Code is not valid.");
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
        SnackBarUtils.showErrorSnackBar(context, "Failed to fetch data. Please try again.");
        setState(() {
          pinCodeDetails = 'Failed to fetch data. Please try again.';
        });
      }
    } catch (e) {
      // Show a snackbar if an error occurs during the API call
      SnackBarUtils.showErrorSnackBar(context, "Error Occurred. Please try again.");
      setState(() {
        pinCodeDetails = 'Error occurred. Please try again.';
      });
    }
  }
}
