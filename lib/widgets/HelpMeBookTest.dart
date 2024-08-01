import 'dart:io';

import 'package:dspuiproject/constant/colors.dart';
import 'package:dspuiproject/services/BottomNavigationfooter/NavigationMenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../SharedPreferecneService/SharedPreferenceSerivice.dart';
import '../helper/session_manager/SessionController.dart';
import '../helper/utils.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// List of Indian cities with states
List<Map<String, String>> indianCitiesWithStates = [
  {"state": "Andhra Pradesh", "city": "Visakhapatnam"},
  {"state": "Andhra Pradesh", "city": "Vijayawada"},
  {"state": "Andhra Pradesh", "city": "Guntur"},
  {"state": "Andhra Pradesh", "city": "Nellore"},
  {"state": "Arunachal Pradesh", "city": "Itanagar"},
  {"state": "Arunachal Pradesh", "city": "Tawang"},
  {"state": "Arunachal Pradesh", "city": "Ziro"},
  {"state": "Assam", "city": "Guwahati"},
  {"state": "Assam", "city": "Silchar"},
  {"state": "Assam", "city": "Dibrugarh"},
  {"state": "Bihar", "city": "Patna"},
  {"state": "Bihar", "city": "Gaya"},
  {"state": "Bihar", "city": "Bhagalpur"},
  {"state": "Chhattisgarh", "city": "Raipur"},
  {"state": "Chhattisgarh", "city": "Bhilai"},
  {"state": "Chhattisgarh", "city": "Bilaspur"},
  {"state": "Goa", "city": "Panaji"},
  {"state": "Goa", "city": "Vasco da Gama"},
  {"state": "Goa", "city": "Margao"},
  // Add more cities with states here
];

class HelpMeBookTestPage extends StatefulWidget {
  @override
  _HelpMeBookTestPageState createState() => _HelpMeBookTestPageState();
}

class _HelpMeBookTestPageState extends State<HelpMeBookTestPage> {

  final SharedPreferencesService _sharedPreferencesService =
  SharedPreferencesService();
  late String _userId;
  late String _username;
  late String _email;
  late String _password;
  late String _mobile;
  late String _profileImg;
  late String _role;
  late String _createdAt;
  late String _updatedAt;
  bool isLoggedIn = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _queryController = TextEditingController();
  final TextEditingController emailcontroller  = TextEditingController();
  String _selectedRelation = 'Self';
  Map<String, String>? _selectedCity;
  List<Map<String, String>> _filteredCities = [];
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('User');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final picker = ImagePicker();
  XFile? _image;
  XFile? get image => _image;

  bool _isImageUploaded = false;
  bool _isUploadingImage = false; // Variable to track image upload progress

  @override
  void initState() {
    _filteredCities = indianCitiesWithStates;
    _loadUsername();
    super.initState();
  }


  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Replace 'user_name' with your actual key
    bool loggedIn = await _sharedPreferencesService.isUserLoggedIn();

    setState(() {
      isLoggedIn = loggedIn;
      _userId = prefs.getString('user_id') ?? '';
      _nameController.text = prefs.getString('name') ?? '';
      emailcontroller.text = prefs.getString('email') ?? '';
      _password = prefs.getString('password') ?? '';
      _mobileController.text = prefs.getString('mobile') ?? '';
      _profileImg = prefs.getString('profile_img') ?? '';
      _role = prefs.getString('role') ?? '';
      _createdAt = prefs.getString('created_at') ?? '';
      _updatedAt = prefs.getString('updated_at') ?? '';

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: iconcolor,
        title: Center(child: Text('Not Sure about Test')),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Handle history action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // First Container: Image and Title
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Image.asset('assets/bookatest.png',
                      width: 100, height: 100), // Image widget for displaying the image
                  SizedBox(height: 10),
                  Text(
                    'Help me book a test', // Title
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Please fill the enquiry form to help us understand your query', // Description
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            // Second Container: Form
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey), // Border color
                          borderRadius: BorderRadius.circular(10), // Border radius
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue), // Border color when focused
                          borderRadius: BorderRadius.circular(10), // Border radius
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        labelText: 'email',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey), // Border color
                          borderRadius: BorderRadius.circular(10), // Border radius
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue), // Border color when focused
                          borderRadius: BorderRadius.circular(10), // Border radius
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _mobileController,
                      decoration: InputDecoration(
                        labelText: 'Mobile',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey), // Border color
                          borderRadius: BorderRadius.circular(10), // Border radius
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue), // Border color when focused
                          borderRadius: BorderRadius.circular(10), // Border radius
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your mobile number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField(
                      value: _selectedRelation,
                      items: [
                        'Self',
                        'Daughter',
                        'Family',
                        'Mother',
                        'Son',
                        'Spouse'
                      ].map((relation) {
                        return DropdownMenuItem(
                          child: Text(relation),
                          value: relation,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedRelation = value.toString();
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Relation',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey), // Border color
                          borderRadius: BorderRadius.circular(10), // Border radius
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue), // Border color when focused
                          borderRadius: BorderRadius.circular(10), // Border radius
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your relation';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 60,
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _isImageUploaded ? Colors.green : Colors.grey, // Change border color based on upload status
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          pickImage(context);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.attach_file),
                            SizedBox(width: 8),
                            Text(
                              'Upload Prescription',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Spacer(),
                            _isImageUploaded
                                ? Icon(Icons.check, color: Colors.green)
                                : _isUploadingImage // Check if uploading is in progress
                                ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                              ),
                            )
                                : Icon(Icons.arrow_forward_ios),
                          ],
                        ),

                      ),


                    ),



                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'City with State',
                        hintText: 'Search for your city with state',
                        prefixIcon: Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey), // Border color
                          borderRadius: BorderRadius.circular(10), // Border radius
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue), // Border color when focused
                          borderRadius: BorderRadius.circular(10), // Border radius
                        ),
                      ),
                      onChanged: _filterCities,
                      onTap: () {
                        showCityPicker(context);
                      },
                      readOnly: true,
                      controller: TextEditingController(
                          text: _selectedCity?.values.join(', ') ?? ''),
                      validator: (value) {
                        if (_selectedCity == null) {
                          return 'Please select city with state';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _queryController,
                      decoration: InputDecoration(
                        labelText: 'Query',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey), // Border color
                          borderRadius: BorderRadius.circular(10), // Border radius
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue), // Border color when focused
                          borderRadius: BorderRadius.circular(10), // Border radius
                        ),
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your query';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // if ( !_isImageUploaded) {
                            //   Utils().toastmessage("Please upload prescription", Colors.red);
                            // } else
                            if (_selectedCity == null) {
                              Utils().toastmessage("Please select city with state", Colors.red);
                            } else {
                              // All mandatory fields are filled, proceed with data submission
                              print('Name: ${_nameController.text}');
                              print('Mobile: ${_mobileController.text}');
                              print('Query: ${_queryController.text}');
                              print('Selected Relation: $_selectedRelation');
                              print('Selected City: ${_selectedCity?.values.join(', ')}');
                              print("user id  ${SessionController().userId}");

                              Utils().toastmessage("thank you we will contact you soon ", Colors.green);
                              Future.delayed(Duration(seconds: 3), () {
                                // Navigate to NavigationMenu after delay
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => NavigationMenu()),
                                );
                              });
                            }
                          }

                        },

                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                              return iconcolor; // Replace with your color variable
                            },
                          ),
                        ),
                        child: Text(
                          'Submit',
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17,color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCityPicker(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.90, // Adjusted height
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end, // Align the icon to the right
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'search for the city',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      ),
                      onChanged: _filterCities,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: _filteredCities.isNotEmpty
                    ? ListView.builder(
                  itemCount: _filteredCities.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(_filteredCities[index]['city']!),
                      subtitle: Text(_filteredCities[index]['state']!),
                      onTap: () {
                        setState(() {
                          _selectedCity = _filteredCities[index];
                        });
                        Navigator.of(context).pop();
                      },
                    );
                  },
                )
                    : Center(
                  child: Text(
                    "No cities found",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _filterCities(String value) {
    List<Map<String, String>> result = [];
    if (value.isEmpty) {
      result = indianCitiesWithStates;
    } else {
      result = indianCitiesWithStates
          .where((city) =>
      city['city']!.toLowerCase().contains(value.toLowerCase()) ||
          city['state']!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    setState(() {
      _filteredCities = result;
    });
  }

  Future pickGalleryImage(BuildContext context) async {
    final pickedfile = await picker.pickImage(
        source: ImageSource.gallery, imageQuality: 100);
    if (pickedfile != null) {
      _image = XFile(pickedfile.path);
      uploadImage(context);
    }
  }

  Future pickCameraImage(BuildContext context) async {
    final pickedfile = await picker.pickImage(
        source: ImageSource.camera, imageQuality: 100);
    if (pickedfile != null) {
      _image = XFile(pickedfile.path);
      uploadImage(context);
    }
  }

  void pickImage(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  onTap: () {
                    pickCameraImage(context);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.camera, color: Colors.blue),
                  title: Text('Camera'),
                ),
                ListTile(
                  onTap: () {
                    pickGalleryImage(context);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.image, color: Colors.blue),
                  title: Text('Gallery'),
                ),
                ListTile(
                  onTap: () {
                    deleteImage(context);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.delete, color: Colors.red),
                  title: Text(
                    'Delete Profile Image',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void uploadImage(BuildContext context) async {
    setState(() {
      _isUploadingImage = true; // Start image uploading progress
    });

    File imageFile = File(image!.path).absolute;
    firebase_storage.Reference storageReference = storage
        .ref('/helpmebookatest/${SessionController().userId}');

    try {
      firebase_storage.UploadTask uploadTask =
      storageReference.putFile(imageFile);

      firebase_storage.TaskSnapshot taskSnapshot =
      await uploadTask.whenComplete(() {});

      String downloadURL = await taskSnapshot.ref.getDownloadURL();

      ref
          .child(SessionController().userId.toString())
          .update({'profile': downloadURL.toString()}).then((value) {
        setState(() {
          _isImageUploaded = true;
          _isUploadingImage = false; // Reset image uploading progress
        });
        Utils().toastmessage("image uploaded successfully", Colors.lightGreen);
        _image = null;
      }).onError((error, stackTrace) {
        Utils().toastmessage("image uploading failed ", Colors.red);
        setState(() {
          _isUploadingImage = false; // Reset image uploading progress
        });
      });

      // You can now use the downloadURL as needed (e.g., save it to the database)
      print('Download URL: $downloadURL');
    } catch (error) {
      // Handle any errors that occur during the upload process
      print('Error uploading image: $error');
      setState(() {
        _isUploadingImage = false; // Reset image uploading progress
      });
    }
  }

  Future<void> deleteImage(BuildContext context) async {
    if (SessionController().userId == null) {
      // Handle the case where the user ID is not available
      return;
    }

    firebase_storage.Reference storageReference =
    storage.ref('/helpmebookatest/${SessionController().userId}');

    try {
      await storageReference.delete();
      await ref
          .child(SessionController().userId.toString())
          .update({'profile': ''});
      setState(() {
        _isImageUploaded = false;
      });
      Utils().toastmessage("Image deleted successfully", Colors.lightGreen);
    } catch (error) {
      print('Error deleting image: $error');
      Utils().toastmessage("Failed to delete image", Colors.red);
    }
  }
}
