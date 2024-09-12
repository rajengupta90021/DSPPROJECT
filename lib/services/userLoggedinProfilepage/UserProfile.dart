import 'dart:convert';
import 'dart:io';

import 'package:dspuiproject/constant/colors.dart';
import 'package:dspuiproject/services/SubAdmin/RequestForSubAdmin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/ChildMember.dart';
import '../../Model/UserProfileImage.dart';
import '../../SharedPreferecneService/SharedPreferenceSerivice.dart';
import '../../provider/UserImageComtroller.dart';
import '../../repository/ChildMemberRepository.dart';
import '../../widgets/SnackBarUtils.dart';
import '../family_member_widgets/EditFamilyMemeber.dart';
import 'UserProfileEditPage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;



class Userprofile extends StatefulWidget {
  final String username;
  final String email;
  final String mobile;
  final String profileimg;
  final String dob;
  final String gender;

  const Userprofile( {
    required this.username,
    required this.email,
    required this.mobile,
    required this.profileimg,
    required this.dob,
    required this.gender,
    Key? key,
  }) : super(key: key);

  @override
  _UserprofileState createState() => _UserprofileState();
}

class _UserprofileState extends State<Userprofile> {
  final ChildMemberRepository _repository = ChildMemberRepository();
  final SharedPreferencesService _sharedPreferencesService =
  SharedPreferencesService();
  String? userId;
  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    userId = await _sharedPreferencesService.getUserId();
    setState(() {}); // Update the UI with the retrieved userId
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 29),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: iconcolor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20),
              height: 310,
              decoration: BoxDecoration(
                color: iconcolor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                 Consumer<UserImageController>(
                     builder: (context,imagecontroller,child){
                       return  Stack(
                         children: [
                           InkWell(
                             onTap: (){

                               imagecontroller.idnameemail(userId!, widget.username, widget.email);
                               imagecontroller.pickiamge(context);
                             },

                             child: CircleAvatar(
                               backgroundImage: imagecontroller.imageUrl != null && imagecontroller.imageUrl!.isNotEmpty
                                   ? NetworkImage(imagecontroller.imageUrl!)
                                   : NetworkImage(widget.profileimg),
                               radius: 50,
                             ),
                           ),
                           if (imagecontroller.isLoading)
                             Positioned.fill(
                               child: Center(
                                 child: Container(
                                   decoration: BoxDecoration(
                                     shape: BoxShape.circle,
                                     color: Colors.black.withOpacity(0.5),
                                   ),
                                   child: Padding(
                                     padding: const EdgeInsets.all(12.0), // Adjust padding as needed
                                     child: CircularProgressIndicator(
                                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                     ),
                                   ),
                                 ),
                               ),
                             ),
                           Positioned(
                             bottom: 0.0,
                             right: 0.0,
                             child: Container(
                               padding: EdgeInsets.all(4),
                               decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 color: Colors.white,
                               ),
                               child: Icon(Icons.edit, color: Colors.purpleAccent),
                             ),
                           )
                         ],
                       );
                     }

                 ),

                  SizedBox(height: 10),
                  Text(
                    "${widget.username}",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            icon:  Image.asset(
                                'assets/viewreports.png',  // Replace 'assets/your_image.png' with your actual image path
                                width: 35,
                                height: 35,
                                fit: BoxFit.contain,  // Adjust the fit as per your requirement
                              ),
                            onPressed: () {
                              // Handle report action
                            },
                          ),
                          SizedBox(height: 10),
                          Text(
                            'REPORTS',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Image.asset("assets/RequestForAdmin.png"
                              ,height: 35,
                              width: 35,
                            ),
                            onPressed: () {
                              showTermsAndConditionsDialog(context);
                            },
                          ),
                          SizedBox(height: 10),
                          Text(
                            'REQUEST',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon:  Image.asset(
                            'assets/editicon.png',  // Replace 'assets/your_image.png' with your actual image path
                                    width: 35,
                                    height: 35,
                                    fit: BoxFit.contain,  // Adjust the fit as per your requirement
                                    ),
                                                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return FractionallySizedBox(
                                    heightFactor: 0.99,
                                    child: UserProflieEditPage(
                                      username: widget.username,
                                      email: widget.email,
                                      mobile: widget.mobile,
                                      profileimg: widget.profileimg,
                                      dob: widget.dob,
                                      gender: widget.gender,
                                    ),
                                  );
                                },
                              );
                              // Handle edit action
                            },
                          ),
                          SizedBox(height: 10),
                          Text(
                            'EDIT',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Family Members",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            StreamBuilder<List<childmember>>(
              stream: userId == null ? Stream.empty() : _repository.getAllChildMembers(userId!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0), // Padding around the message
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          SizedBox(height: 16.0), // Spacing between icon and text
                          Text(
                            'No family members found',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  List<childmember> childMembers = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: childMembers.length,
                    itemBuilder: (context, index) {
                      childmember member = childMembers[index];

                      DateTime? createdAt;
                      try {
                        createdAt = DateTime.parse(member.data?.createdAt ?? '');
                      } catch (e) {
                        createdAt = DateTime.now(); // Default value if parsing fails
                      }

                      // Format createdAt DateTime to string
                      String formattedDate = DateFormat('dd-MM-yyyy').format(createdAt);

                      return Container(
                        height: 115,
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        child: Card(
                          elevation: 2,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbMWwCck2JKqm9H8t53puxSlKZ9mi2SuVdEEk48k6LtA&s',
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        member.data!.name!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text("${member.data?.relation} ${formattedDate}"),
                                      SizedBox(height: 2),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.purple,
                                        ),
                                        child: Text(
                                          "Regular",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text('ABHA Id: Not available'),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: IconButton(
                                    color: Colors.black,
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      print('Name: ${member.data?.parentId}');
                                      print('name: ${member.data?.name}');
                                      print('email: ${member.data?.email}');
                                      print('moblie: ${member.data?.mobile}');
                                      print('relation: ${member.data?.relation}');
                                      print('address: ${member.data?.address}');
                                      print('child id : ${member.id}');
                                      print('child id : ${member.data?.dob}');
                                      print('child id : ${member.data?.gender}');

                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EditFamilyMemeber(
                                        parentId: member.data?.parentId ?? '',
                                        username: member.data?.name ?? '',
                                        email: member.data?.email ?? '',
                                        mobile: member.data?.mobile ?? '',
                                        relation: member.data?.relation ?? '',
                                        address: member.data?.address ?? '',
                                        id: member.id ?? '',
                                        dob: member.data?.dob ?? '', // Pass dob
                                        gender: member.data?.gender ?? '', // Pass gender
                                      )));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}



void showTermsAndConditionsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0), // Rounded corners
        ),
        title: Text(
          'Terms and Conditions',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        content: SingleChildScrollView(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '1. ',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'Purpose\n'
                      'You agree that the sample collected will be used solely for the purpose of analysis and management of the test process.\n\n',
                  style: TextStyle(color: Colors.grey[800]),
                ),
                TextSpan(
                  text: '2. ',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'Consent\n'
                      'By providing your sample, you consent to its use for the intended testing and management procedures.\n\n',
                  style: TextStyle(color: Colors.grey[800]),
                ),
                TextSpan(
                  text: '3. ',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'Confidentiality\n'
                      'All data related to the sample will be handled with strict confidentiality and in accordance with privacy regulations.\n\n',
                  style: TextStyle(color: Colors.grey[800]),
                ),
                TextSpan(
                  text: '4. ',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'Responsibility\n'
                      'You are responsible for providing accurate information and ensuring the sample is collected and handled properly.\n\n',
                  style: TextStyle(color: Colors.grey[800]),
                ),
                TextSpan(
                  text: '5. ',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'Liability\n'
                      'We are not liable for any issues resulting from incorrect sample handling or information provided.',
                  style: TextStyle(color: Colors.grey[800]),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Padding for button
            ),
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: iconcolor, // Change this to your `iconcolor` if needed
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Padding for button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
              ),
            ),
            child: Text('Agree'),
            onPressed: () {
              Navigator.of(context).pop(); // Close terms and conditions dialog
              RequestForSubAdmin(context); // Open request form dialog
            },
          ),
        ],
      );
    },
  );
}






void RequestForSubAdmin(BuildContext context) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController addressController = TextEditingController();
  final TextEditingController houseFlatNoController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  pinCodeController.addListener(() {
    final pinCode = pinCodeController.text;
    if (pinCode.length == 6) {
      getDataFromPinCode(
        context,
        pinCode,
        cityController,
        stateController,
        _formKey,
      );
    } else if (pinCode.length > 6) {
      // Optionally, you can handle cases where the length exceeds 6 digits
      pinCodeController.text = pinCode.substring(0, 6); // Trim to 6 digits
      pinCodeController.selection = TextSelection.fromPosition(TextPosition(offset: pinCodeController.text.length)); // Move cursor to end
    } else {
      // Clear city and state fields if pin code is invalid
      cityController.text = '';
      stateController.text = '';
    }
  });
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0), // Rounded corners
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
          padding: EdgeInsets.all(16.0), // Add padding inside the container
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min, // Ensure the column is not taking extra space
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Request for Sub Admin',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Would you like to proceed with the request? Please fill out the form below.',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 20),
                  _buildTextField(addressController, 'Address', 'Please enter your address', _formKey),
                  SizedBox(height: 16),
                  _buildTextField(houseFlatNoController, 'House/Flat No', 'Please enter house or flat number', _formKey),
                  SizedBox(height: 16),
                  _buildTextField(pinCodeController, 'Pin Code', 'Please enter your pin code', _formKey, keyboardType: TextInputType.number),
                  SizedBox(height: 16),
                  _buildTextField(cityController, 'City Name', 'Please enter your city name', _formKey),
                  SizedBox(height: 16),
                  _buildTextField(stateController, 'State Name', 'Please enter your state name', _formKey),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Padding for button
                        ),
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: iconcolor, // Change this to your `iconcolor`
                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Padding for button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // Rounded corners
                          ),
                        ),
                        child: Text('Request'),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // Retrieve the input values
                            String address = addressController.text;
                            String houseFlatNo = houseFlatNoController.text;
                            String pinCode = pinCodeController.text;
                            String city = cityController.text;
                            String state = stateController.text;

                            // Handle the request action
                            print('Address: $address');
                            print('House/Flat No: $houseFlatNo');
                            print('Pin Code: $pinCode');
                            print('City: $city');
                            print('State: $state');

                            // Optionally, you can add logic to send this data to your server or handle it accordingly

                            Fluttertoast.showToast(
                              msg: "We will contact you soon thank you for connecting us ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                            );

                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

// Custom text field widget to reduce repetition and improve design consistency
Widget _buildTextField(
    TextEditingController controller,
    String labelText,
    String validationMessage,
    GlobalKey<FormState> formKey, {
      TextInputType keyboardType = TextInputType.text,
      bool enabled = true
    }) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Padding inside the text field
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: iconcolor, width: 2.0), // Focused border color
      ),
    ),
    style: TextStyle(fontSize: 16), // Font size of the text
    validator: (value) {
      if (!enabled) return null; // Skip validation for disabled fields
      if (value == null || value.isEmpty) {
        return validationMessage;
      }
      return null;
    },
    onChanged: (value) {
      if (enabled) {
        formKey.currentState?.validate(); // Trigger validation to clear errors
      }
    },
    enabled: enabled,
  );
}



Future<void> getDataFromPinCode(BuildContext context, String pinCode, TextEditingController cityController, TextEditingController stateController,GlobalKey<FormState> formKey) async {
  final url = "http://www.postalpincode.in/api/pincode/$pinCode";

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      if (jsonResponse['Status'] == 'Error') {
        // Show a snackbar if the PIN code is not valid
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Pin Code is not valid.")),
        );
        cityController.text = '';
        stateController.text = '';
        // Clear any validation errors for city and state fields
        formKey.currentState?.validate(); // Trigger validation to clear errors
      } else {
        // Parse and display details if the PIN code is valid
        final postOfficeArray = jsonResponse['PostOffice'] as List;
        final obj = postOfficeArray[0];

        final district = obj['District'];
        final state = obj['State'];
        final country = obj['Country'];

        cityController.text = district;
        stateController.text = state;
        // Manually trigger validation to clear errors in city and state fields
        formKey.currentState?.validate();
      }
    } else {
      // Show a snackbar if there is an issue fetching data
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch data. Please try again.")),
      );
      cityController.text = '';
      stateController.text = '';
    }
  } catch (e) {
    // Show a snackbar if an error occurs during the API call
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error occurred. Please try again.")),
    );
    cityController.text = '';
    stateController.text = '';
  }
}
