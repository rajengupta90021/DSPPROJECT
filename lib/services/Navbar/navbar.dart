import 'package:dspuiproject/constant/colors.dart';
import 'package:dspuiproject/provider/UserImageComtroller.dart';
import 'package:dspuiproject/services/BottomNavigationfooter/FaqSection.dart';
import 'package:dspuiproject/services/BottomNavigationfooter/Wallet.dart';
import 'package:dspuiproject/services/home_page2.dart';
import 'package:dspuiproject/services/userLoggedinProfilepage/UserProfile.dart';
import 'package:dspuiproject/helper/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../SharedPreferecneService/SharedPreferenceSerivice.dart';
import '../../helper/session_manager/SessionController.dart';
import '../../provider/CartProvider.dart';
import '../../provider/ProviderData.dart';

import '../../provider/controller/loginController.dart';
import '../../widgets/SnackBarUtils.dart';
import '../../widgets/loginAndLoginLater.dart';
import '../BottomNavigationfooter/NavigationMenu.dart';
import '../auth/login_screen.dart';
import 'AccountSetting/AccountSettingpage.dart';
import 'Navbar_Subscription.dart';
import 'ReportandIssue.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
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
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('User');
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
    final User? user = auth.currentUser;
    final loginController = Provider.of<LoginController>(context);
    final userimagecontroller = Provider.of<UserImageController>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 150,
            child: DrawerHeader(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isLoggedIn)
                      ...[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Userprofile(  username: _username,
                                      email: _email,
                                      mobile: _mobile,
                                      profileimg: _profileImg,)));
                          },
                          child: Row(
                            children: [
                              Consumer<UserImageController>(

                                  builder: (context ,imagecontorller,child){
                                    return CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 35,
                                      backgroundImage: imagecontorller.imageUrl != null && imagecontorller.imageUrl!.isNotEmpty
                                          ? NetworkImage(imagecontorller.imageUrl!)
                                          : NetworkImage(_profileImg),
                                    );
                                  }
                              ),
                              SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        _username.isNotEmpty
                                            ? 'Hi, $_username'
                                            : 'user',

                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(Icons.edit),
                                    ],
                                  ),

                                  Text(
                                    'Self  | Regular',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ), // User details
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    if (!isLoggedIn)
                      Column(
                        children: [
                          Text(
                            'Hi, there!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'Login to start your healthy journey',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),


                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: iconcolor,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.subscriptions), // Add icon for My Subscription
            title: Text('My Subscription'),
            onTap: () async {
              bool isLoggedIn = await _sharedPreferencesService.isUserLoggedIn();
              if (isLoggedIn) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubscriptionPage()),
                );
              } else {
                Navigator.pop(context); // Close the drawer
                LoginandLoginLaterpage.show(context, 'My Subscription');
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag), // Add icon for My Order
            title: Text('My Order'),
            onTap: () {
              // Handle tap on My Order
            },
          ),
          ListTile(
            leading: Icon(Icons.local_hospital), // Add icon for Wellness
            title: Text('Wellness'),
            onTap: () {
              // Handle tap on Wellness
            },
          ),
          ListTile(
            leading: Icon(Icons.settings), // Add icon for Settings
            title: Text('Settings'),
            onTap: () async {
              bool isLoggedIn = await _sharedPreferencesService.isUserLoggedIn();
              if (isLoggedIn) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountSettingpage()),
                );
              } else {
                Navigator.pop(context); // Close the drawer
                LoginandLoginLaterpage.show(context, 'My Setting');
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.account_balance_wallet), // Add icon for Wallet
            title: Text('Wallet'),
            onTap: () async {
              bool isLoggedIn = await _sharedPreferencesService.isUserLoggedIn();
              if (isLoggedIn) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Wallet()),
                );
              } else {
                Navigator.pop(context); // Close the drawer
                LoginandLoginLaterpage.show(context, 'wallet');
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.video_library), // Add icon for Vlog Preference
            title: Text('Vlog Preference'),
            onTap: () {
              // Handle tap on Vlog Preference
            },
          ),
          ListTile(
            leading: Icon(Icons.report), // Add icon for Report an Issue
            title: Text('Report an Issue'),
            onTap: () async {
              bool isLoggedIn = await _sharedPreferencesService.isUserLoggedIn();
              if (isLoggedIn) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportIssuePage()),
                );
              } else {
                Navigator.pop(context); // Close the drawer
                LoginandLoginLaterpage.show(context, 'Report and issue');
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.help_outline), // Add icon for FAQ
            title: Text('FAQ'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FaqSection()));
            },
          ),
          Divider(),
          Center(
            child: Container(
              height: 40,
              width: 100,
              child: Center(
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Center(
                      child: Text(
                        isLoggedIn  ? 'Logout' : 'Login',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onTap: () async {
                    if (isLoggedIn) {
                      auth.signOut();
                      SessionController().userId = '';
                       print("user id before logout ${await _sharedPreferencesService.getUserId()}");

                      await _sharedPreferencesService.remove();
                      await loginController.remove();
                      userimagecontroller.clearImage();
                      print("user ifd deleted ${isLoggedIn}");
                      print("user id after logout ${await _sharedPreferencesService.getUserId()}");
                      final cartProvider = Provider.of<CartProvider>(context, listen: false);

                      // Clear cart data
                      await cartProvider.clearCart();
                      SnackBarUtils.showSuccessSnackBar(
                        context,
                          "logout successfully",
                      );
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationMenu()));
                    } else {

                      SnackBarUtils.showErrorSnackBar(context, "please login here ");
                      Navigator.push(context, MaterialPageRoute(builder: (context) => loginscreen()));
                    }
                  },
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: textColor),
                borderRadius: BorderRadius.circular(10),
                color: redColor.withOpacity(0.2),
              ),
              margin: EdgeInsets.all(2),
            ),
          ),
          ListTile(
            title: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Privacy Policy  ',
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Terms and Conditions',
                      style: TextStyle(fontSize: 12, color: Colors.blue, decoration: TextDecoration.underline),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
