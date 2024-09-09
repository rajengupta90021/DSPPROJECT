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
import '../../widgets/LoadingOverlay.dart';
import '../../widgets/SnackBarUtils.dart';
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
  TextEditingController dobController = TextEditingController();
  String? userId;
  final formkey = GlobalKey<FormState>();
  SharedPreferencesService SharedPreferencesServicee = SharedPreferencesService();
  Gender selectedGender = Gender.Others;
  String? relationError;
  String? dobError; // State variable for date of birth error

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
                        prefixText: '+91 ',
                        prefixStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      keyboardType: TextInputType.phone,
                      maxLength: 13, // Limit input to 13 characters (+, country code, and 10 digits)
                      onChanged: (value) {
                        formkey.currentState?.validate();
                      },
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
                      onChanged: (value) {
                        formkey.currentState?.validate();
                      },
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
                      onChanged: (value) {
                        formkey.currentState?.validate();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return null;
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
                          if (dropdownValue != null) {
                            // Clear the error message when a valid selection is made
                            relationError = null;
                          }
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
                        errorText: relationError, // Display the error message if present
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() {
                            relationError = "Please select a relation";
                          });
                          return null; // Return null to prevent form submission
                        }
                        return null; // Return null if no error
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
                        errorText: dobError, // Display error text if present
                      ),
                      readOnly: true,
                      onTap: () {
                        _selectdate();
                      },
                      onChanged: (value) {
                        formkey.currentState?.validate();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() {
                            dobError = "Please select date of birth"; // Set error message if empty
                          });
                          return null;
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
              printFormData();
               try{


                 showDialog(
                   context: context,
                   barrierDismissible: false, // Prevent dismiss on tap outside
                   builder: (BuildContext context) {
                     return Center(
                       child: CircularProgressIndicator(), // Loading indicator
                     );
                   },
                 );
               final resposne =  ChildMemberRepositoryy.createUserChild( parentId: userId ?? '',
                   name: fullNameController.text,
                   email: emailController.text,
                   mobile: mobileNumberController.text,
                   relation: dropdownValue ?? '',
                   address: "",
                    dob:_datecontroller.text,
                 gender:genderController.text
               );


                 await Future.delayed(Duration(seconds: 2));
                 // SnackBarUtils.showSuccessSnackBar(
                 //   context,
                 //   "User child created successfully",
                 // );
                 SnackBarUtils.showSuccessSnackBar(context,   "family  created successfully");
                 Navigator.of(context).pop();
                 // Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationMenu()));
                 Navigator.of(context).pop();
               }
               catch(e){
                 print('Error creating user child: $e');
                 SnackBarUtils.showErrorSnackBar(context, "Failed to create user child");
               }

            } else {

              SnackBarUtils.showErrorSnackBar(context,"Please fill all required fields.");
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
        dobError=null;
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
    print('Mobile Number: ${mobileNumberController.text}');
    print('Full Name: ${fullNameController.text}');
    print('Email ID: ${emailController.text}');
    print('Relation: $dropdownValue');
    print('Date of Birth: ${_datecontroller.text}');
    print('Gender: ${genderController.text}');



  }
}
