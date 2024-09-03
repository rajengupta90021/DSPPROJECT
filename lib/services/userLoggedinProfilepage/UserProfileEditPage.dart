import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dspuiproject/services/UnoHomePage.dart';
import 'package:dspuiproject/widgets/SnackBarUtils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../SharedPreferecneService/SharedPreferenceSerivice.dart';
import '../../constant/colors.dart';
import '../../helper/session_manager/SessionController.dart';
import '../../provider/controller/SignUpcontroller.dart';
import '../../repository/AuthRepository.dart';
import '../../helper/utils.dart';
import '../BottomNavigationfooter/NavigationMenu.dart';
import 'UserProfile.dart';

class UserProflieEditPage extends StatefulWidget {
  final String username;
  final String email;
  final String mobile;
  final String profileimg;
  final String dob;
  final String gender;

  UserProflieEditPage({
    required this.username,
    required this.email,
    required this.mobile,
    required this.profileimg,
    required this.dob,
    required this.gender,
    Key? key,
  }) : super(key: key);

  @override
  _AddFamilyMember2State createState() => _AddFamilyMember2State();
}

class _AddFamilyMember2State extends State<UserProflieEditPage> {

  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('User');
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  XFile? _image;
  XFile? get image => _image;

  final SharedPreferencesService _sharedPreferencesService =
  SharedPreferencesService();

  String? dropdownValue="self";
  File? pickedImage;
  List<File> pickedImages = [];
  List<Reference> uploadedFiles = [];
  TextEditingController _datecontroller = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  // String uid = "86vhciYNilhgRZrLlAf31xrmVGC2";
  String uid = SessionController().userId.toString();
  final formkey = GlobalKey<FormState>();

  Gender selectedGender = Gender.Others;
  @override
  void initState() {
    super.initState();
    // fetchUserData();
    _loadUsername();
  }
  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Replace 'user_name' with your actual key
    bool loggedIn = await _sharedPreferencesService.isUserLoggedIn();

    setState(() {
      fullNameController.text = prefs.getString('name') ?? '';
      emailController.text= prefs.getString('email') ?? '';
      mobileNumberController.text =prefs.getString('mobile') ?? '';
      _datecontroller.text = prefs.getString('dob') ?? ''; // Load date of birth
      genderController.text = prefs.getString('gender') ?? ''; // Load gender
      selectedGender = getGenderFromString(genderController.text);

    });
  }



  @override
  Widget build(BuildContext context) {
    final signUpController = Provider.of<SignUpController>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: [
          Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Image.asset(
                      'assets/editprofileimage.jpg',
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Would you like to edit Profile',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Do you want to edit your profile details',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: mobileNumberController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        labelText: 'Mobile Number',
                        prefixText: '+91 ',

                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        prefixStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      keyboardType: TextInputType.phone,
                      readOnly: true,
                       // Limit input to 13 characters (+, country code, and 10 digits)
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a mobile number";
                        }

                        // Regular expression to match a valid mobile number with country code.
                        // Accepts formats: +91XXXXXXXXXX, 91XXXXXXXXXX, 919XXXXXXXXX, 9XXXXXXXXX
                        RegExp mobileRegex = RegExp(r'^\+?[1-9]\d{9}$');

                        if (!mobileRegex.hasMatch(value)) {
                          return "Please enter a valid mobile number";
                        }

                        return null;
                      },
                    ),


                    SizedBox(height: 10),
                    TextFormField(
                      controller: fullNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        labelText: 'Full Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "enter full name ";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    // TextFormField(
                    //   controller: emailController,
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                    //     labelText: 'Email ID',
                    //   ),
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return "enter email id ";
                    //     }
                    //     return null;
                    //   },
                    // ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        labelText: 'Email ID',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter an email address";
                        }

                        // Regular expression to validate email format
                        RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                        if (!emailRegex.hasMatch(value)) {
                          return "Please enter a valid email address";
                        }

                        return null;
                      },
                    ),

                    SizedBox(height: 10),

                    DropdownButtonFormField<String>(

                      // value: dropdownValue,
                      // onChanged: (newValue) {
                      //   setState(() {
                      //     dropdownValue = newValue!;
                      //     relationController.text = newValue ?? '';
                      //   });
                      // },
                      onChanged: null,
                      items: [
                        DropdownMenuItem<String>(
                          value: 'Daughter',
                          child: Text('Daughter'),
                        ), DropdownMenuItem<String>(
                          value: 'self',
                          child: Text('self'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Family',
                          child: Text('Family'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Father',
                          child: Text('Father'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Mother',
                          child: Text('Mother'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Son',
                          child: Text('Son'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Spouse',
                          child: Text('Spouse'),
                        ),
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        labelText: 'Relation',
                      ),
                      disabledHint: Text('self'),
                      onTap: () {},
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _datecontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        labelText: 'Date of birth',
                        prefixIcon: Icon(Icons.calendar_today),
                        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                      ),
                      readOnly: true,
                      onTap: () {
                        _selectdate();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please select date of birth";
                        }
                        return null;
                      },
                    ),
                    _genderWidget( showOther: true,
                      alignment: false,
                      defaultGender: selectedGender,
                      genderController: genderController,),
                    // filebox(),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1.0),
                      child: Row(
                        // children: [
                        //   Icon(Icons.check_circle_outline_sharp, color: navyBlueColor),
                        //   SizedBox(width: 10),
                        //   Expanded(
                        //     child: Text(
                        //       'The document submitted are valid and correct \n to the best of my knowledge',
                        //       overflow: TextOverflow.ellipsis,
                        //     ),
                        //   ),
                        // ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      // child: Row(
                      //   children: [
                      //     Icon(Icons.check_circle_outline_sharp, color: navyBlueColor),
                      //     SizedBox(width: 10),
                      //     Text('By uploading this document i provide permission to \n DSP to store and use this document for\n verification purpose'),
                      //   ],
                      // ),
                    ),
                    SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 45,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 1.0),
        child: FloatingActionButton.extended(
          onPressed: () async {
            if (formkey.currentState!.validate()) {
              printFormData();

              showDialog(
                context: context,
                barrierDismissible: false, // Prevent dismiss on tap outside
                builder: (BuildContext context) {
                  return Center(
                    child: CircularProgressIndicator(), // Loading indicator
                  );
                },
              );
              await Future.delayed(Duration(seconds: 4));
              signUpController.updateUserData(
                fullName: fullNameController.text,
                email: emailController.text,
                mobileNumber: mobileNumberController.text,
                dob: _datecontroller.text,
                gender: genderController.text,

              );
              Navigator.pop(context);
              await Future.delayed(Duration(seconds: 3));
              Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationMenu()));
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Userprofile()));
            // Navigator.pop(context);
           } else {
              SnackBarUtils.showErrorSnackBar(context, "Please fill all required fields.");
            }
          },
          label: Text('SAVE', style: TextStyle(color: Colors.black, fontSize: 19)),
          backgroundColor: iconcolor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> _selectdate() async {
    DateTime currentDate = DateTime.now();

    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900), // Set a reasonable past date limit
      lastDate: currentDate, // Prevent future dates
    );

    if (_picked != null && _picked.isBefore(currentDate)) {
      setState(() {
        _datecontroller.text = _picked.toLocal().toString().split(" ")[0]; // Format the date
      });
    } else if (_picked != null && _picked.isAfter(currentDate)) {
      // Optionally show a message if an invalid date is picked (future date)
      Fluttertoast.showToast(
        msg: 'Please select a valid date of birth (no future dates allowed).',
        backgroundColor: Colors.red,
      );
    }
  }


  Widget _genderWidget({
    required bool showOther,
    required bool alignment,
    required Gender defaultGender,
    required TextEditingController genderController,
  }) {
    Gender selectedGender = defaultGender;
    String genderText = genderController.text.toLowerCase();
    String? genderError;

    if (genderText == 'male') {
      selectedGender = Gender.Male;
    } else if (genderText == 'female') {
      selectedGender = Gender.Female;
    } else if (genderText == 'others') {
      selectedGender = Gender.Others;
    } else {
      genderError = 'Gender is required'; // Set error message if no valid gender is selected
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: GenderPickerWithImage(
            showOtherGender: showOther,
            verticalAlignedText: alignment,
            onChanged: (Gender? gender) {
              if (gender != null) {
                selectedGender = gender;
                genderController.text = gender.toString().split('.').last;
                print(gender);
                setState(() {
                  genderError = null; // Clear error message when a gender is selected
                });
              }
            },
            selectedGender: selectedGender,
            selectedGenderTextStyle: TextStyle(color: Color(0xFFC41A3B), fontWeight: FontWeight.bold),
            unSelectedGenderTextStyle: TextStyle(color: Color(0xFF1B1F32), fontWeight: FontWeight.bold),
            equallyAligned: true,
            size: 64.0,
            animationDuration: Duration(seconds: 1),
            isCircular: true,
            opacityOfGradient: 0.5,
            padding: EdgeInsets.all(8.0),
          ),
        ),
        if (genderError != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              genderError!,
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }

  void printFormData() {

    print("printing form data ************************");
    print('Mobile Number: ${mobileNumberController.text}');
    print('Full Name: ${fullNameController.text}');
    print('Email ID: ${emailController.text}');
    print('Relation: $dropdownValue');
    print("relation controllwe ${relationController.text}");
    print('Date of Birth: ${_datecontroller.text}');
    print('Gender: ${genderController.text}');
  }

  Gender getGenderFromString(String gender) {
    switch (gender.toLowerCase()) {
      case 'male':
        return Gender.Male;
      case 'female':
        return Gender.Female;
      case 'others':
        return Gender.Others;
      default:
        return Gender.Others;
    }
  }



}
