import 'package:dspuiproject/constant/colors.dart';
import 'package:dspuiproject/services/Payment/AddNewAddress.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../SharedPreferecneService/SharedPreferenceSerivice.dart';
import '../../Payment/SelectAnAdress.dart';
import '../../userLoggedinProfilepage/UserProfile.dart';
import 'ChangePassword.dart';
import 'FamilyMemberReport/FamilyMember.dart';
import 'LanguageSecletion.dart';
import 'ManageAdresss.dart';

class AccountSettingpage extends StatefulWidget {
  const AccountSettingpage({Key? key}) : super(key: key);

  @override
  State<AccountSettingpage> createState() => _AccountSettingpageState();
}

class _AccountSettingpageState extends State<AccountSettingpage> {

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

  final SharedPreferencesService _sharedPreferencesService =
  SharedPreferencesService();
  @override
  void initState() {
    super.initState();
    _loadUsername();
  }


  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Replace 'user_name' with your actual key
    bool loggedIn = await _sharedPreferencesService.isUserLoggedIn();

    setState(() {
      isLoggedIn = loggedIn;
      _userId = prefs.getString('user_id') ?? '';
      _username = prefs.getString('name') ?? '';
      _email = prefs.getString('email') ?? '';
      _password = prefs.getString('password') ?? '';
      _mobile = prefs.getString('mobile') ?? '';
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
        centerTitle: true,
        backgroundColor: iconcolor,
        title: Text('Account Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Profile Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),

            SizedBox(height: 10),

            // Profile Settings ListTile with GestureDetector
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Userprofile(  username: _username,
                    email: _email,
                    mobile: _mobile,
                    profileimg: _profileImg,)),
                );
              },
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text('Profile Settings'),
              ),
            ),

            // Family Members ListTile with GestureDetector
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FamilyMemeberReport()),
                );
              },
              child: ListTile(
                leading: Icon(Icons.people),
                title: Text('Family Members'),
              ),
            ),

            // Manage Address ListTile with GestureDetector
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageAddressPage()),
                );
              },
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text('Manage Address'),
              ),
            ),

            SizedBox(height: 20),
            Text(
              'General Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10),

            // Change Password ListTile with GestureDetector
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePassword()),
                );
              },
              child: ListTile(
                leading: Icon(Icons.lock),
                title: Text('Change Password'),
              ),
            ),

            // Language Selection ListTile with GestureDetector
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LanguageSelectionPage()),
                );
              },
              child: ListTile(
                leading: Icon(Icons.language),
                title: Text('Language Selection'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Example pages to navigate to remain unchanged
