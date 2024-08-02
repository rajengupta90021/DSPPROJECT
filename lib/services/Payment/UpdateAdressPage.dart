import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/UserAddress.dart';
import '../../constant/colors.dart';
import '../../repository/UserAddressRepository.dart';
import 'SelectAnAdress.dart';

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
  late  TextEditingController address1Controller = TextEditingController();
  late TextEditingController houseBlockController = TextEditingController();
  late TextEditingController pinCodeController = TextEditingController();
  late TextEditingController areaCityController = TextEditingController();
  late TextEditingController stateController = TextEditingController();
  late TextEditingController localityController = TextEditingController();
  late TextEditingController phoneNumberController = TextEditingController(); // New controller for phone number
  String? userId;
  final AddressRepository addressRepository = AddressRepository();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    address1Controller = TextEditingController(text: widget.address);
    houseBlockController = TextEditingController(text: widget.houseNo);
    phoneNumberController = TextEditingController(text: widget.phoneNo);
    pinCodeController = TextEditingController(text: widget.pinCode);
    areaCityController = TextEditingController(text: widget.cityName);
    stateController = TextEditingController(text: widget.stateName);
    localityController = TextEditingController(text: widget.locality);
    _loadUsername();
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
        title: Text('update Address'),
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
                      SizedBox(height: 16),
                      Text(
                        'Enter your address details below:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      _buildTextField(
                        controller: address1Controller,
                        label: 'Address',
                        hint: 'Enter address line 1',
                        validatorMessage: 'Please enter Address 1',
                      ),
                      SizedBox(height: 26),
                      _buildTextField(
                        controller: houseBlockController,
                        label: 'House/ Flat/ Block No',
                        hint: 'Enter house/flat/block number',
                        validatorMessage: 'Please enter House/ Flat/ Block No',
                      ),
                      SizedBox(height: 26),
                      _buildTextField(
                        controller: phoneNumberController, // New field
                        label: 'Phone Number',
                        hint: 'Enter phone number',
                        validatorMessage: 'Please enter Phone Number',
                        keyboardType: TextInputType.phone, // Phone number keyboard type
                      ),
                      SizedBox(height: 26),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: pinCodeController,
                              label: 'Pin Code',
                              hint: 'Enter pin code',
                              keyboardType: TextInputType.phone,
                              validatorMessage: 'Please enter Pin Code',
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                              controller: areaCityController,
                              label: 'City Name',
                              hint: 'Enter area or city',
                              validatorMessage: 'Please enter Area, City Name',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 26),
                      _buildTextField(
                        controller: stateController,
                        label: 'State Name',
                        hint: 'Enter state name',
                        validatorMessage: 'Please enter State Name',
                      ),
                      SizedBox(height: 26),
                      _buildTextField(
                        controller: localityController,
                        label: 'Locality',
                        hint: 'Enter locality',
                        validatorMessage: 'Please enter Locality',
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
                    barrierDismissible: false, // Prevent dismiss on tap outside
                    builder: (BuildContext context) {
                      return Center(
                        child: CircularProgressIndicator(), // Loading indicator
                      );
                    },
                  );
                  await Future.delayed(Duration(seconds: 2));
                  // Print all field values
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

                bool address = await addressRepository.updateUserAddress(userId!, addressDetails);
                  if (address) {

                    // Address created successfully


                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Address updated successfully')),
                    );
                    // await Future.delayed(Duration(seconds: 3));
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationMenu()));
                    Navigator.pop(context);

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectAnAddress()));
                  } else {
                    // Failed to create address
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String validatorMessage,
    TextInputType keyboardType = TextInputType.text, // Default to text input
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorMessage;
        }
        return null;
      },
      onChanged: (value) {
        // Trigger validation to remove the error message as the user types
        _formKey.currentState?.validate();
      },
    );
  }
}
