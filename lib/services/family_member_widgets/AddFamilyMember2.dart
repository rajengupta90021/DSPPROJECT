import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:path/path.dart' as path;

import '../../Model/ChildMember.dart';
import '../../SharedPreferecneService/SharedPreferenceSerivice.dart';
import '../../constant/colors.dart';
import '../../repository/ChildMemberRepository.dart';
import '../BottomNavigationfooter/NavigationMenu.dart';

class AddFamilyMember2 extends StatefulWidget {
  @override
  _AddFamilyMember2State createState() => _AddFamilyMember2State();
}

class _AddFamilyMember2State extends State<AddFamilyMember2> {
  String? dropdownValue;
  File? pickedImage;
  List<File> pickedImages = [];
  TextEditingController _datecontroller = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  String? userId;
  final formkey = GlobalKey<FormState>();
  SharedPreferencesService SharedPreferencesServicee = SharedPreferencesService();
  Gender selectedGender = Gender.Others;

  ChildMemberRepository ChildMemberRepositoryy= ChildMemberRepository();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    try {
      String? id = await SharedPreferencesServicee.getUserId();
      setState(() {
        userId = id;
      });
    } catch (e) {
      print('Error loading user ID: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    // print("user id from shared in family ${userId}");
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
                      'assets/familymember.png',
                      width: 120,
                      height: 120,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Add Family Member',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Enter your family member details below ',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    // TextFormField(
                    //   controller: mobileNumberController,
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                    //     labelText: 'Mobile Number',
                    //   ),
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return "Please enter mobile number";
                    //     }
                    //     return null;
                    //   },
                    // ),
                    TextFormField(
                      controller: mobileNumberController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        labelText: 'Mobile Number',
                        prefixText: '+',
                        prefixStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      keyboardType: TextInputType.phone,
                      maxLength: 13, // Limit input to 13 characters (+, country code, and 10 digits)
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
                          return "Please enter full name";
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
                    //       return "Please enter email id";
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
                      value: dropdownValue,
                      onChanged: (newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: [
                        DropdownMenuItem<String>(
                          value: 'Daughter',
                          child: Text('Daughter'),
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
                      validator: (value) {
                        if (value == null) {
                          return "Please select relation";
                        }
                        return null;
                      },
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
                    SizedBox(height: 30),
                    // Add more form fields or widgets as needed
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
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

               try{
                 printFormData();


                 ChildMemberRepositoryy.createUserChild( parentId: userId ?? '',
                   name: fullNameController.text,
                   email: emailController.text,
                   mobile: mobileNumberController.text,
                   relation: dropdownValue ?? '',
                   address: "",);

                 Fluttertoast.showToast(
                   msg: 'User child created successfully',
                   toastLength: Toast.LENGTH_SHORT,
                   gravity: ToastGravity.BOTTOM,
                   timeInSecForIosWeb: 1,
                   backgroundColor: Colors.green,
                   textColor: Colors.white,
                   fontSize: 16.0,
                 );

                 await Future.delayed(Duration(seconds: 3));
                 // Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationMenu()));
                 Navigator.of(context).pop();
               }
               catch(e){
                 print('Error creating user child: $e');
                 Fluttertoast.showToast(
                   msg: 'Failed to create user child',
                   toastLength: Toast.LENGTH_SHORT,
                   gravity: ToastGravity.BOTTOM,
                   timeInSecForIosWeb: 1,
                   backgroundColor: Colors.red,
                   textColor: Colors.white,
                   fontSize: 16.0,
                 );
               }

            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please fill all required fields.'),
                ),
              );
            }
          },
          label: Text('ADD PATIENT', style: TextStyle(color: Colors.black, fontSize: 19)),
          backgroundColor: iconcolor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> _selectdate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (_picked != null) {
      setState(() {
        _datecontroller.text = _picked.toString().split(" ")[0];
      });
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
    print('Mobile Number: ${mobileNumberController.text}');
    print('Full Name: ${fullNameController.text}');
    print('Email ID: ${emailController.text}');
    print('Relation: $dropdownValue');
    print('Date of Birth: ${_datecontroller.text}');
    print('Gender: ${genderController.text}');


  }
}
